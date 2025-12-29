{- This file was auto-generated from temporal/api/sdk/v1/task_complete_metadata.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata (
        WorkflowTaskCompletedMetadata()
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields.coreUsedFlags' @:: Lens' WorkflowTaskCompletedMetadata [Data.Word.Word32]@
         * 'Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields.vec'coreUsedFlags' @:: Lens' WorkflowTaskCompletedMetadata (Data.Vector.Unboxed.Vector Data.Word.Word32)@
         * 'Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields.langUsedFlags' @:: Lens' WorkflowTaskCompletedMetadata [Data.Word.Word32]@
         * 'Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields.vec'langUsedFlags' @:: Lens' WorkflowTaskCompletedMetadata (Data.Vector.Unboxed.Vector Data.Word.Word32)@
         * 'Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields.sdkName' @:: Lens' WorkflowTaskCompletedMetadata Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.TaskCompleteMetadata_Fields.sdkVersion' @:: Lens' WorkflowTaskCompletedMetadata Data.Text.Text@ -}
data WorkflowTaskCompletedMetadata
  = WorkflowTaskCompletedMetadata'_constructor {_WorkflowTaskCompletedMetadata'coreUsedFlags :: !(Data.Vector.Unboxed.Vector Data.Word.Word32),
                                                _WorkflowTaskCompletedMetadata'langUsedFlags :: !(Data.Vector.Unboxed.Vector Data.Word.Word32),
                                                _WorkflowTaskCompletedMetadata'sdkName :: !Data.Text.Text,
                                                _WorkflowTaskCompletedMetadata'sdkVersion :: !Data.Text.Text,
                                                _WorkflowTaskCompletedMetadata'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowTaskCompletedMetadata where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowTaskCompletedMetadata "coreUsedFlags" [Data.Word.Word32] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowTaskCompletedMetadata'coreUsedFlags
           (\ x__ y__
              -> x__ {_WorkflowTaskCompletedMetadata'coreUsedFlags = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowTaskCompletedMetadata "vec'coreUsedFlags" (Data.Vector.Unboxed.Vector Data.Word.Word32) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowTaskCompletedMetadata'coreUsedFlags
           (\ x__ y__
              -> x__ {_WorkflowTaskCompletedMetadata'coreUsedFlags = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowTaskCompletedMetadata "langUsedFlags" [Data.Word.Word32] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowTaskCompletedMetadata'langUsedFlags
           (\ x__ y__
              -> x__ {_WorkflowTaskCompletedMetadata'langUsedFlags = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowTaskCompletedMetadata "vec'langUsedFlags" (Data.Vector.Unboxed.Vector Data.Word.Word32) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowTaskCompletedMetadata'langUsedFlags
           (\ x__ y__
              -> x__ {_WorkflowTaskCompletedMetadata'langUsedFlags = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowTaskCompletedMetadata "sdkName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowTaskCompletedMetadata'sdkName
           (\ x__ y__ -> x__ {_WorkflowTaskCompletedMetadata'sdkName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowTaskCompletedMetadata "sdkVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowTaskCompletedMetadata'sdkVersion
           (\ x__ y__
              -> x__ {_WorkflowTaskCompletedMetadata'sdkVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowTaskCompletedMetadata where
  messageName _
    = Data.Text.pack
        "temporal.api.sdk.v1.WorkflowTaskCompletedMetadata"
  packedMessageDescriptor _
    = "\n\
      \\GSWorkflowTaskCompletedMetadata\DC2&\n\
      \\SIcore_used_flags\CAN\SOH \ETX(\rR\rcoreUsedFlags\DC2&\n\
      \\SIlang_used_flags\CAN\STX \ETX(\rR\rlangUsedFlags\DC2\EM\n\
      \\bsdk_name\CAN\ETX \SOH(\tR\asdkName\DC2\US\n\
      \\vsdk_version\CAN\EOT \SOH(\tR\n\
      \sdkVersion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        coreUsedFlags__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "core_used_flags"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Packed
                 (Data.ProtoLens.Field.field @"coreUsedFlags")) ::
              Data.ProtoLens.FieldDescriptor WorkflowTaskCompletedMetadata
        langUsedFlags__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "lang_used_flags"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Packed
                 (Data.ProtoLens.Field.field @"langUsedFlags")) ::
              Data.ProtoLens.FieldDescriptor WorkflowTaskCompletedMetadata
        sdkName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sdk_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"sdkName")) ::
              Data.ProtoLens.FieldDescriptor WorkflowTaskCompletedMetadata
        sdkVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sdk_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"sdkVersion")) ::
              Data.ProtoLens.FieldDescriptor WorkflowTaskCompletedMetadata
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, coreUsedFlags__field_descriptor),
           (Data.ProtoLens.Tag 2, langUsedFlags__field_descriptor),
           (Data.ProtoLens.Tag 3, sdkName__field_descriptor),
           (Data.ProtoLens.Tag 4, sdkVersion__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowTaskCompletedMetadata'_unknownFields
        (\ x__ y__
           -> x__ {_WorkflowTaskCompletedMetadata'_unknownFields = y__})
  defMessage
    = WorkflowTaskCompletedMetadata'_constructor
        {_WorkflowTaskCompletedMetadata'coreUsedFlags = Data.Vector.Generic.empty,
         _WorkflowTaskCompletedMetadata'langUsedFlags = Data.Vector.Generic.empty,
         _WorkflowTaskCompletedMetadata'sdkName = Data.ProtoLens.fieldDefault,
         _WorkflowTaskCompletedMetadata'sdkVersion = Data.ProtoLens.fieldDefault,
         _WorkflowTaskCompletedMetadata'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowTaskCompletedMetadata
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Unboxed.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Word.Word32
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Unboxed.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Word.Word32
                -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowTaskCompletedMetadata
        loop x mutable'coreUsedFlags mutable'langUsedFlags
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'coreUsedFlags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                   mutable'coreUsedFlags)
                      frozen'langUsedFlags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                   mutable'langUsedFlags)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'coreUsedFlags")
                              frozen'coreUsedFlags
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'langUsedFlags")
                                 frozen'langUsedFlags x)))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (Prelude.fmap
                                           Prelude.fromIntegral
                                           Data.ProtoLens.Encoding.Bytes.getVarInt)
                                        "core_used_flags"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'coreUsedFlags y)
                                loop x v mutable'langUsedFlags
                        10
                          -> do y <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                        Data.ProtoLens.Encoding.Bytes.isolate
                                          (Prelude.fromIntegral len)
                                          ((let
                                              ploop qs
                                                = do packedEnd <- Data.ProtoLens.Encoding.Bytes.atEnd
                                                     if packedEnd then
                                                         Prelude.return qs
                                                     else
                                                         do !q <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                    (Prelude.fmap
                                                                       Prelude.fromIntegral
                                                                       Data.ProtoLens.Encoding.Bytes.getVarInt)
                                                                    "core_used_flags"
                                                            qs' <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                                     (Data.ProtoLens.Encoding.Growing.append
                                                                        qs q)
                                                            ploop qs'
                                            in ploop)
                                             mutable'coreUsedFlags)
                                loop x y mutable'langUsedFlags
                        16
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (Prelude.fmap
                                           Prelude.fromIntegral
                                           Data.ProtoLens.Encoding.Bytes.getVarInt)
                                        "lang_used_flags"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'langUsedFlags y)
                                loop x mutable'coreUsedFlags v
                        18
                          -> do y <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                        Data.ProtoLens.Encoding.Bytes.isolate
                                          (Prelude.fromIntegral len)
                                          ((let
                                              ploop qs
                                                = do packedEnd <- Data.ProtoLens.Encoding.Bytes.atEnd
                                                     if packedEnd then
                                                         Prelude.return qs
                                                     else
                                                         do !q <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                    (Prelude.fmap
                                                                       Prelude.fromIntegral
                                                                       Data.ProtoLens.Encoding.Bytes.getVarInt)
                                                                    "lang_used_flags"
                                                            qs' <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                                     (Data.ProtoLens.Encoding.Growing.append
                                                                        qs q)
                                                            ploop qs'
                                            in ploop)
                                             mutable'langUsedFlags)
                                loop x mutable'coreUsedFlags y
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "sdk_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"sdkName") y x)
                                  mutable'coreUsedFlags mutable'langUsedFlags
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "sdk_version"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"sdkVersion") y x)
                                  mutable'coreUsedFlags mutable'langUsedFlags
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'coreUsedFlags mutable'langUsedFlags
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'coreUsedFlags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         Data.ProtoLens.Encoding.Growing.new
              mutable'langUsedFlags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'coreUsedFlags
                mutable'langUsedFlags)
          "WorkflowTaskCompletedMetadata"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                p = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"vec'coreUsedFlags") _x
              in
                if Data.Vector.Generic.null p then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((\ bs
                          -> (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                  (Prelude.fromIntegral (Data.ByteString.length bs)))
                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         (Data.ProtoLens.Encoding.Bytes.runBuilder
                            (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                               p))))
             ((Data.Monoid.<>)
                (let
                   p = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"vec'langUsedFlags") _x
                 in
                   if Data.Vector.Generic.null p then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            (Data.ProtoLens.Encoding.Bytes.runBuilder
                               (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                                  p))))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"sdkName") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((Prelude..)
                               (\ bs
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                          (Prelude.fromIntegral (Data.ByteString.length bs)))
                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               Data.Text.Encoding.encodeUtf8 _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"sdkVersion") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                               ((Prelude..)
                                  (\ bs
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                             (Prelude.fromIntegral (Data.ByteString.length bs)))
                                          (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                  Data.Text.Encoding.encodeUtf8 _v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData WorkflowTaskCompletedMetadata where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowTaskCompletedMetadata'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowTaskCompletedMetadata'coreUsedFlags x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowTaskCompletedMetadata'langUsedFlags x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowTaskCompletedMetadata'sdkName x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowTaskCompletedMetadata'sdkVersion x__) ()))))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \0temporal/api/sdk/v1/task_complete_metadata.proto\DC2\DC3temporal.api.sdk.v1\"\171\SOH\n\
    \\GSWorkflowTaskCompletedMetadata\DC2&\n\
    \\SIcore_used_flags\CAN\SOH \ETX(\rR\rcoreUsedFlags\DC2&\n\
    \\SIlang_used_flags\CAN\STX \ETX(\rR\rlangUsedFlags\DC2\EM\n\
    \\bsdk_name\CAN\ETX \SOH(\tR\asdkName\DC2\US\n\
    \\vsdk_version\CAN\EOT \SOH(\tR\n\
    \sdkVersionB\135\SOH\n\
    \\SYNio.temporal.api.sdk.v1B\EMTaskCompleteMetadataProtoP\SOHZ\GSgo.temporal.io/api/sdk/v1;sdk\170\STX\NAKTemporalio.Api.Sdk.V1\234\STX\CANTemporalio::Api::Sdk::V1J\186\DC3\n\
    \\ACK\DC2\EOT\NUL\NUL5\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\FS\n\
    \\b\n\
    \\SOH\b\DC2\ETX\EOT\NUL4\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\EOT\NUL4\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ENQ\NUL/\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ENQ\NUL/\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ACK\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\ACK\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\a\NUL:\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\a\NUL:\n\
    \\b\n\
    \\SOH\b\DC2\ETX\b\NUL1\n\
    \\t\n\
    \\STX\b-\DC2\ETX\b\NUL1\n\
    \\b\n\
    \\SOH\b\DC2\ETX\t\NUL2\n\
    \\t\n\
    \\STX\b%\DC2\ETX\t\NUL2\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\v\NUL5\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\v\b%\n\
    \\143\b\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\US\STX&\SUB\129\b Internal flags used by the core SDK. SDKs using flags must comply with the following behavior:\n\
    \\n\
    \ During replay:\n\
    \ * If a flag is not recognized (value is too high or not defined), it must fail the workflow\n\
    \   task.\n\
    \ * If a flag is recognized, it is stored in a set of used flags for the run. Code checks for\n\
    \   that flag during and after this WFT are allowed to assume that the flag is present.\n\
    \ * If a code check for a flag does not find the flag in the set of used flags, it must take\n\
    \   the branch corresponding to the absence of that flag.\n\
    \\n\
    \ During non-replay execution of new WFTs:\n\
    \ * The SDK is free to use all flags it knows about. It must record any newly-used (IE: not\n\
    \   previously recorded) flags when completing the WFT.\n\
    \\n\
    \ SDKs which are too old to even know about this field at all are considered to produce\n\
    \ undefined behavior if they replay workflows which used this mechanism.\n\
    \\n\
    \ (-- api-linter: core::0141::forbidden-types=disabled\n\
    \     aip.dev/not-precedent: These really shouldn't have negative values. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\EOT\DC2\ETX\US\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\US\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\US\DC2!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\US$%\n\
    \\139\ETX\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX'\STX&\SUB\253\STX Flags used by the SDK lang. No attempt is made to distinguish between different SDK languages\n\
    \ here as processing a workflow with a different language than the one which authored it is\n\
    \ already undefined behavior. See `core_used_patches` for more.\n\
    \\n\
    \ (-- api-linter: core::0141::forbidden-types=disabled\n\
    \     aip.dev/not-precedent: These really shouldn't have negative values. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\EOT\DC2\ETX'\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX'\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX'\DC2!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX'$%\n\
    \\137\ETX\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX/\STX\SYN\SUB\251\STX Name of the SDK that processed the task. This is usually something like \"temporal-go\" and is\n\
    \ usually the same as client-name gRPC header. This should only be set if its value changed\n\
    \ since the last time recorded on the workflow (or be set on the first task).\n\
    \\n\
    \ (-- api-linter: core::0122::name-suffix=disabled\n\
    \     aip.dev/not-precedent: We're ok with a name suffix here. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX/\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX/\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX/\DC4\NAK\n\
    \\149\STX\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX4\STX\EM\SUB\135\STX Version of the SDK that processed the task. This is usually something like \"1.20.0\" and is\n\
    \ usually the same as client-version gRPC header. This should only be set if its value changed\n\
    \ since the last time recorded on the workflow (or be set on the first task).\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ENQ\DC2\ETX4\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX4\t\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX4\ETB\CANb\ACKproto3"