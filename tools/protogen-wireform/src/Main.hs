{-# LANGUAGE LambdaCase #-}

module Main (main) where

import Data.Char (isDigit)
import Data.List (foldl', sortOn)
import qualified Data.Map.Strict as Map
import Data.Maybe (fromMaybe, mapMaybe, maybeToList)
import Data.Ord (Down (..))
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Vector as V
import Proto.CodeGen
import Proto.Google.Protobuf.Compiler.Plugin
import Proto.Google.Protobuf.Descriptor
import Proto.IDL.AST
import Proto.IDL.Descriptor (fileDescriptorToAST)
import Proto.IDL.Parser.Resolver (ResolvedProto (..))


main :: IO ()
main = pluginMain handleRequest


handleRequest :: CodeGeneratorRequest -> IO CodeGeneratorResponse
handleRequest req = do
  let requestedFiles = V.toList (cgrFileToGenerate req)
      allProtos = V.toList (cgrProtoFile req)
      opts = parsePluginOpts (cgrParameter req)
      resolvedPairs = fmap (fdpToResolved opts) allProtos
      typeReg = buildTypeRegistry opts resolvedPairs
      outputFiles = concatMap (generateForFile opts typeReg requestedFiles) allProtos
  pure
    defaultCodeGeneratorResponse
      { cgrsFile = V.fromList outputFiles
      , cgrsSupportedFeatures = 1
      }


parsePluginOpts :: Text -> GenerateOpts
parsePluginOpts param =
  let entries = filter (not . T.null) $ T.splitOn "," param
      optionMap = Map.fromList $ fmap parseEntry entries
      fieldNaming = case Map.lookup "field_naming" optionMap <|> Map.lookup "field-naming" optionMap of
        Just "unprefixed" -> UnprefixedFields
        Just "unprefixed-fields" -> UnprefixedFields
        Just "prefixed" -> PrefixedFields
        _
          | Map.member "unprefixed_fields" optionMap -> UnprefixedFields
          | Map.member "unprefixed-fields" optionMap -> UnprefixedFields
          | otherwise -> UnprefixedFields
      modulePrefix = fromMaybe "Proto" (Map.lookup "module_prefix" optionMap <|> Map.lookup "module-prefix" optionMap)
  in defaultGenerateOpts
      { genModulePrefix = modulePrefix
      , genFieldNaming = fieldNaming
      }
  where
    parseEntry raw =
      let (key, valueWithEquals) = T.breakOn "=" (T.strip raw)
      in (T.strip key, T.strip (T.drop 1 valueWithEquals))


fdpToResolved :: GenerateOpts -> FileDescriptorProto -> (FilePath, ResolvedProto)
fdpToResolved opts fdp =
  let path = T.unpack (fdpName fdp)
      pf = normalizeProtoFileForHaskell opts (fileDescriptorToAST fdp)
  in ( path
     , ResolvedProto {rpFile = pf, rpPath = path, rpImports = Map.empty}
     )


generateForFile
  :: GenerateOpts
  -> TypeRegistry
  -> [Text]
  -> FileDescriptorProto
  -> [CodeGeneratorResponseFile]
generateForFile opts reg requestedFiles fdp =
  if fdpName fdp `elem` requestedFiles
    then
      let filePath = T.unpack (fdpName fdp)
          pf = normalizeProtoFileForHaskell opts (fileDescriptorToAST fdp)
          moduleName = moduleNameForProto opts filePath pf
          outputPath = T.replace "." "/" moduleName <> ".hs"
          content = correctMultiByteArchetypeTags opts pf (normalizeGeneratedModule (addSiblingRequestResponseImport moduleName (generateModuleText opts reg filePath pf)))
      in [CodeGeneratorResponseFile outputPath content]
    else []


addSiblingRequestResponseImport :: Text -> Text -> Text
addSiblingRequestResponseImport moduleName content
  | Just parent <- T.stripSuffix ".Service" moduleName =
      let marker = "\n-- | Serialized FileDescriptorProto"
          importLine = "\nimport " <> parent <> ".RequestResponse\nimport Proto.Google.Protobuf.Empty (Empty)\n"
      in T.replace marker (importLine <> marker) content
  | otherwise = content


data ArchetypeTag = ArchetypeTag
  { archetypeFunction :: Text
  , archetypeTag :: Int
  }


data SizeCorrection = SizeCorrection
  { correctionTypeName :: Text
  , correctionUnknownAccessor :: Text
  , correctionHelperName :: Text
  , correctionBody :: Text
  }


correctMultiByteArchetypeTags :: GenerateOpts -> ProtoFile -> Text -> Text
correctMultiByteArchetypeTags opts pf generated =
  let corrections = concatMap (topLevelCorrections opts generated) (protoTopLevels pf)
      multiByteTags = filter ((> 255) . archetypeTag) (archetypeTagsIn generated)
      rewritten = replaceMultiByteArchetypeTags generated multiByteTags
      withSizeCorrections = foldl' insertSizeCorrection rewritten corrections
      withGenericHelpers
        | null multiByteTags = withSizeCorrections
        | otherwise = injectGenericArchetypeHelpers withSizeCorrections
  in if null corrections
      then withGenericHelpers
      else T.stripEnd withGenericHelpers <> "\n\n" <> T.intercalate "\n\n" (fmap renderSizeCorrection corrections) <> "\n"


topLevelCorrections :: GenerateOpts -> Text -> TopLevel -> [SizeCorrection]
topLevelCorrections opts generated = \case
  TLMessage msg -> messageCorrections opts generated [] msg
  _ -> []


messageCorrections :: GenerateOpts -> Text -> [Text] -> MessageDef -> [SizeCorrection]
messageCorrections opts generated parentScope msg =
  let scope = parentScope <> [msgName msg]
      typeName = scopedTypeName scope
      encoderTags = archetypeTagsIn (messageEncodeBlock generated typeName)
      terms = concatMap (messageElementCorrections opts scope encoderTags) (msgElements msg)
      nested = concatMap (nestedMessageCorrections opts generated scope) (msgElements msg)
      current =
        if null terms
          then []
          else
            [ SizeCorrection
                { correctionTypeName = typeName
                , correctionUnknownAccessor = generatedUnknownFieldAccessor scope
                , correctionHelperName = "multiByteTagSize" <> typeName
                , correctionBody = T.intercalate " + " terms
                }
            ]
  in current <> nested


generatedUnknownFieldAccessor :: [Text] -> Text
generatedUnknownFieldAccessor scope =
  let prefix = case scope of
        [] -> ""
        [name] -> lowerFirst (hsTypeName name)
        _ -> lowerFirst (T.intercalate "" (fmap hsTypeName scope))
  in prefix <> "UnknownFields"


nestedMessageCorrections :: GenerateOpts -> Text -> [Text] -> MessageElement -> [SizeCorrection]
nestedMessageCorrections opts generated scope = \case
  MEMessage msg -> messageCorrections opts generated scope msg
  _ -> []


messageElementCorrections :: GenerateOpts -> [Text] -> [ArchetypeTag] -> MessageElement -> [Text]
messageElementCorrections opts scope tags = \case
  MEField field -> maybeToList (fieldCorrection opts scope tags field)
  MEOneof oneof -> maybeToList (oneofCorrection opts scope tags oneof)
  _ -> []


fieldCorrection :: GenerateOpts -> [Text] -> [ArchetypeTag] -> FieldDef -> Maybe Text
fieldCorrection opts scope tags field
  | fieldLabel field == Just Repeated
  , FTScalar scalar <- fieldType field
  , scalar == SString || scalar == SBytes =
      Nothing
  | otherwise = do
      let fieldNum = unFieldNumber (fieldNumber field)
          accessor = "msg." <> scopedFieldNameWith (genFieldNaming opts) scope (fieldName field)
      fieldKind <- fieldKindFor tags fieldNum (fieldType field)
      pure (presentFieldSize fieldKind (fieldLabel field) accessor fieldNum)


oneofCorrection :: GenerateOpts -> [Text] -> [ArchetypeTag] -> OneofDef -> Maybe Text
oneofCorrection opts scope tags oneof =
  let arms = mapMaybe oneofArm (oneofFields oneof)
  in if null arms
      then Nothing
      else
        Just
          ( "(case msg."
              <> scopedFieldNameWith (genFieldNaming opts) scope (oneofName oneof)
              <> " of { Nothing -> 0"
              <> T.concat arms
              <> " })"
          )
  where
    oneofArm field = do
      let fieldNum = unFieldNumber (oneofFieldNumber field)
      _ <- fieldKindFor tags fieldNum (oneofFieldType field)
      let constructor =
            scopedTypeName scope
              <> "'"
              <> snakeToPascal (oneofName oneof)
              <> "'"
              <> snakeToPascal (oneofFieldName field)
      pure ("; Just (" <> constructor <> " _) -> " <> tagSizeDelta fieldNum)


data FieldKind = ScalarKind ScalarType | EnumKind | MessageKind


fieldKindFor :: [ArchetypeTag] -> Int -> FieldType -> Maybe FieldKind
fieldKindFor tags fieldNum = \case
  FTScalar scalar
    | hasMultiByteArchetypeTag tags (encodedTag fieldNum (scalarWireType scalar)) -> Just (ScalarKind scalar)
    | otherwise -> Nothing
  FTNamed _
    | hasMultiByteArchetypeTag tags (encodedTag fieldNum 0) -> Just EnumKind
    | hasMultiByteArchetypeTag tags (encodedTag fieldNum 2) -> Just MessageKind
    | otherwise -> Nothing


scalarWireType :: ScalarType -> Int
scalarWireType = \case
  SDouble -> 1
  SFixed64 -> 1
  SSFixed64 -> 1
  SFloat -> 5
  SFixed32 -> 5
  SSFixed32 -> 5
  SString -> 2
  SBytes -> 2
  _ -> 0


presentFieldSize :: FieldKind -> Maybe FieldLabel -> Text -> Int -> Text
presentFieldSize kind label accessor fieldNum =
  let delta = tagSizeDelta fieldNum
      repeated = "(" <> delta <> " * V.length " <> accessor <> ")"
      optional = "(maybe 0 (const " <> delta <> ") " <> accessor <> ")"
  in case label of
      Just Repeated -> repeated
      Just Optional -> optional
      Just Required -> scalarOrEnumDefault kind
      Nothing -> case kind of
        MessageKind -> optional
        _ -> scalarOrEnumDefault kind
  where
    scalarOrEnumDefault = \case
      MessageKind -> "(maybe 0 (const " <> tagSizeDelta fieldNum <> ") " <> accessor <> ")"
      EnumKind -> defaultGuard ("fromEnum " <> accessor <> " == 0")
      ScalarKind SBool -> defaultGuard (accessor <> " == False")
      ScalarKind SString -> defaultGuard (accessor <> " == T.empty")
      ScalarKind SBytes -> defaultGuard ("BS.null " <> accessor)
      ScalarKind _ -> defaultGuard (accessor <> " == 0")
    defaultGuard predicate =
      "(if " <> predicate <> " then 0 else " <> tagSizeDelta fieldNum <> ")"


tagSizeDelta :: Int -> Text
tagSizeDelta fieldNum = "(tagSize " <> intText fieldNum <> " - 1)"


encodedTag :: Int -> Int -> Int
encodedTag fieldNum wireType = fieldNum * 8 + wireType


hasArchetypeTag :: [ArchetypeTag] -> Int -> Bool
hasArchetypeTag tags tag = any ((== tag) . archetypeTag) tags


hasMultiByteArchetypeTag :: [ArchetypeTag] -> Int -> Bool
hasMultiByteArchetypeTag tags tag = tag > 255 && hasArchetypeTag tags tag


messageEncodeBlock :: Text -> Text -> Text
messageEncodeBlock generated typeName =
  let marker = "\ninstance MessageEncode " <> typeName <> " where\n"
      (_, afterMarker) = T.breakOn marker generated
  in if T.null afterMarker
      then ""
      else fst (T.breakOn "\ninstance MessageSize " (T.drop (T.length marker) afterMarker))


insertSizeCorrection :: Text -> SizeCorrection -> Text
insertSizeCorrection generated correction =
  let marker = "\ninstance MessageSize " <> correctionTypeName correction <> " where\n"
      (before, afterMarker) = T.breakOn marker generated
  in if T.null afterMarker
      then generated
      else
        let sizeStart = T.drop (T.length marker) afterMarker
            (sizeBlock, afterSize) = T.breakOn "\ninstance MessageDecode " sizeStart
            unknownFieldLine = "\n    + unknownFieldsSize msg." <> correctionUnknownAccessor correction
            replacement = unknownFieldLine <> "\n    + " <> correctionHelperName correction <> " msg"
        in if T.null afterSize
            then generated
            else before <> marker <> T.replace unknownFieldLine replacement sizeBlock <> afterSize


renderSizeCorrection :: SizeCorrection -> Text
renderSizeCorrection correction =
  T.unlines
    [ correctionHelperName correction <> " :: " <> correctionTypeName correction <> " -> Int"
    , correctionHelperName correction <> " msg = " <> correctionBody correction
    ]


replaceMultiByteArchetypeTags :: Text -> [ArchetypeTag] -> Text
replaceMultiByteArchetypeTags generated tags =
  foldl' replaceOne generated (sortOn (Down . T.length . archetypeTagText) tags)
  where
    replaceOne source tag =
      T.replace
        (archetypeFunction tag <> " " <> archetypeTagText tag)
        ("genericArch" <> T.drop (T.length "arch") (archetypeFunction tag) <> " " <> intText (archetypeTag tag `div` 8))
        source


archetypeTagText :: ArchetypeTag -> Text
archetypeTagText = intText . archetypeTag


archetypeTagsIn :: Text -> [ArchetypeTag]
archetypeTagsIn source = concatMap (`tagsForArchetype` source) archetypeFunctions


tagsForArchetype :: Text -> Text -> [ArchetypeTag]
tagsForArchetype function = go
  where
    marker = function <> " "
    go source =
      let (_, afterMarker) = T.breakOn marker source
      in if T.null afterMarker
          then []
          else
            let afterTag = T.drop (T.length marker) afterMarker
                (digits, remaining) = T.span isDigit afterTag
            in case reads (T.unpack digits) of
                [(tag, "")]
                  | not (T.null digits) -> ArchetypeTag function tag : go remaining
                _ -> go (T.drop 1 afterMarker)


archetypeFunctions :: [Text]
archetypeFunctions =
  [ "archVarint"
  , "archSVarint32"
  , "archSVarint64"
  , "archFixed32"
  , "archFixed64"
  , "archFloat"
  , "archDouble"
  , "archBool"
  , "archString"
  , "archBytes"
  , "archSubmessage"
  ]


injectGenericArchetypeHelpers :: Text -> Text
injectGenericArchetypeHelpers =
  T.replace
    "\n-- | Serialized FileDescriptorProto"
    ("\n" <> genericArchetypeHelpers <> "\n-- | Serialized FileDescriptorProto")


genericArchetypeHelpers :: Text
genericArchetypeHelpers =
  T.unlines
    [ "genericArchVarint :: Int -> Word64 -> B.Builder"
    , "genericArchVarint fieldNumber value = putTag fieldNumber WireVarint <> putVarint value"
    , "genericArchSVarint32 :: Int -> Int32 -> B.Builder"
    , "genericArchSVarint32 fieldNumber value = putTag fieldNumber WireVarint <> putSVarint32 value"
    , "genericArchSVarint64 :: Int -> Int64 -> B.Builder"
    , "genericArchSVarint64 fieldNumber value = putTag fieldNumber WireVarint <> putSVarint64 value"
    , "genericArchFixed32 :: Int -> Word32 -> B.Builder"
    , "genericArchFixed32 fieldNumber value = putTag fieldNumber Wire32Bit <> putFixed32 value"
    , "genericArchFixed64 :: Int -> Word64 -> B.Builder"
    , "genericArchFixed64 fieldNumber value = putTag fieldNumber Wire64Bit <> putFixed64 value"
    , "genericArchFloat :: Int -> Float -> B.Builder"
    , "genericArchFloat fieldNumber value = putTag fieldNumber Wire32Bit <> putFloat value"
    , "genericArchDouble :: Int -> Double -> B.Builder"
    , "genericArchDouble fieldNumber value = putTag fieldNumber Wire64Bit <> putDouble value"
    , "genericArchBool :: Int -> Bool -> B.Builder"
    , "genericArchBool fieldNumber value = putTag fieldNumber WireVarint <> putVarint (if value then 1 else 0)"
    , "genericArchString :: Int -> Text -> B.Builder"
    , "genericArchString fieldNumber value = putTag fieldNumber WireLengthDelimited <> putText value"
    , "genericArchBytes :: Int -> ByteString -> B.Builder"
    , "genericArchBytes fieldNumber value = putTag fieldNumber WireLengthDelimited <> putByteString value"
    , "genericArchSubmessage :: Int -> Int -> B.Builder -> B.Builder"
    , "genericArchSubmessage fieldNumber size body = putTag fieldNumber WireLengthDelimited <> putVarint (fromIntegral size) <> body"
    ]


intText :: Int -> Text
intText = T.pack . show


normalizeGeneratedModule :: Text -> Text
normalizeGeneratedModule =
  T.unlines
    . fmap normalizeGeneratedLine
    . T.lines
    . T.replace "{-# LANGUAGE NoFieldSelectors #-}\n" ""


normalizeGeneratedLine :: Text -> Text
normalizeGeneratedLine line =
  case T.stripPrefix "  messageUnknownFields = " line of
    Just accessor -> "  messageUnknownFields msg = msg." <> accessor
    Nothing -> normalizeMaybeDefaultLine (normalizeRecordUpdateLine line)


normalizeRecordUpdateLine :: Text -> Text
normalizeRecordUpdateLine line =
  let typeMarker = "(m :: "
      updateMarker = ") -> m { "
  in case T.breakOn typeMarker line of
      (beforeType, typeRest)
        | not (T.null typeRest) ->
            let afterTypeMarker = T.drop (T.length typeMarker) typeRest
                (typeName, afterType) = T.breakOn updateMarker afterTypeMarker
                afterUpdateMarker = T.drop (T.length updateMarker) afterType
                (fieldAssign, afterAssign) = T.breakOn " = v }" afterUpdateMarker
            in if T.null afterType || T.null afterAssign
                then line
                else
                  beforeType
                    <> typeMarker
                    <> typeName
                    <> ") -> (m { "
                    <> fieldAssign
                    <> " = v } :: "
                    <> typeName
                    <> ")"
                    <> T.drop (T.length " = v }") afterAssign
      _ -> line


normalizeMaybeDefaultLine :: Text -> Text
normalizeMaybeDefaultLine line =
  let marker = " = maybe ("
  in case T.breakOn marker line of
      (prefix, rest)
        | not (T.null rest) ->
            let afterMarker = T.drop (T.length marker) rest
                (inside, afterInside) = T.breakOn ") id " afterMarker
            in case T.words inside of
                [accessor, defaultValue] ->
                  prefix
                    <> marker
                    <> defaultValue
                    <> "."
                    <> accessor
                    <> ") Prelude.id "
                    <> T.drop (T.length ") id ") afterInside
                _ -> line
      _ -> line


normalizeProtoFileForHaskell :: GenerateOpts -> ProtoFile -> ProtoFile
normalizeProtoFileForHaskell _opts pf =
  pf {protoOptions = filter (not . isCsharpNamespaceOption) (protoOptions pf)}


isCsharpNamespaceOption :: OptionDef -> Bool
isCsharpNamespaceOption OptionDef {optName = OptionName [SimpleOption "csharp_namespace"]} = True
isCsharpNamespaceOption _ = False


(<|>) :: Maybe a -> Maybe a -> Maybe a
Just a <|> _ = Just a
Nothing <|> b = b
