{- This file was auto-generated from temporal/api/sdk/v1/enhanced_stack_trace.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace (
        EnhancedStackTrace(), EnhancedStackTrace'SourcesEntry(),
        StackTrace(), StackTraceFileLocation(), StackTraceFileSlice(),
        StackTraceSDKInfo()
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
     
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.sdk' @:: Lens' EnhancedStackTrace StackTraceSDKInfo@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.maybe'sdk' @:: Lens' EnhancedStackTrace (Prelude.Maybe StackTraceSDKInfo)@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.sources' @:: Lens' EnhancedStackTrace (Data.Map.Map Data.Text.Text StackTraceFileSlice)@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.stacks' @:: Lens' EnhancedStackTrace [StackTrace]@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.vec'stacks' @:: Lens' EnhancedStackTrace (Data.Vector.Vector StackTrace)@ -}
data EnhancedStackTrace
  = EnhancedStackTrace'_constructor {_EnhancedStackTrace'sdk :: !(Prelude.Maybe StackTraceSDKInfo),
                                     _EnhancedStackTrace'sources :: !(Data.Map.Map Data.Text.Text StackTraceFileSlice),
                                     _EnhancedStackTrace'stacks :: !(Data.Vector.Vector StackTrace),
                                     _EnhancedStackTrace'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show EnhancedStackTrace where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField EnhancedStackTrace "sdk" StackTraceSDKInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'sdk
           (\ x__ y__ -> x__ {_EnhancedStackTrace'sdk = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField EnhancedStackTrace "maybe'sdk" (Prelude.Maybe StackTraceSDKInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'sdk
           (\ x__ y__ -> x__ {_EnhancedStackTrace'sdk = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EnhancedStackTrace "sources" (Data.Map.Map Data.Text.Text StackTraceFileSlice) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'sources
           (\ x__ y__ -> x__ {_EnhancedStackTrace'sources = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EnhancedStackTrace "stacks" [StackTrace] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'stacks
           (\ x__ y__ -> x__ {_EnhancedStackTrace'stacks = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField EnhancedStackTrace "vec'stacks" (Data.Vector.Vector StackTrace) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'stacks
           (\ x__ y__ -> x__ {_EnhancedStackTrace'stacks = y__}))
        Prelude.id
instance Data.ProtoLens.Message EnhancedStackTrace where
  messageName _
    = Data.Text.pack "temporal.api.sdk.v1.EnhancedStackTrace"
  packedMessageDescriptor _
    = "\n\
      \\DC2EnhancedStackTrace\DC28\n\
      \\ETXsdk\CAN\SOH \SOH(\v2&.temporal.api.sdk.v1.StackTraceSDKInfoR\ETXsdk\DC2N\n\
      \\asources\CAN\STX \ETX(\v24.temporal.api.sdk.v1.EnhancedStackTrace.SourcesEntryR\asources\DC27\n\
      \\ACKstacks\CAN\ETX \ETX(\v2\US.temporal.api.sdk.v1.StackTraceR\ACKstacks\SUBd\n\
      \\fSourcesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2>\n\
      \\ENQvalue\CAN\STX \SOH(\v2(.temporal.api.sdk.v1.StackTraceFileSliceR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        sdk__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sdk"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StackTraceSDKInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'sdk")) ::
              Data.ProtoLens.FieldDescriptor EnhancedStackTrace
        sources__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sources"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor EnhancedStackTrace'SourcesEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"sources")) ::
              Data.ProtoLens.FieldDescriptor EnhancedStackTrace
        stacks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "stacks"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StackTrace)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"stacks")) ::
              Data.ProtoLens.FieldDescriptor EnhancedStackTrace
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, sdk__field_descriptor),
           (Data.ProtoLens.Tag 2, sources__field_descriptor),
           (Data.ProtoLens.Tag 3, stacks__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _EnhancedStackTrace'_unknownFields
        (\ x__ y__ -> x__ {_EnhancedStackTrace'_unknownFields = y__})
  defMessage
    = EnhancedStackTrace'_constructor
        {_EnhancedStackTrace'sdk = Prelude.Nothing,
         _EnhancedStackTrace'sources = Data.Map.empty,
         _EnhancedStackTrace'stacks = Data.Vector.Generic.empty,
         _EnhancedStackTrace'_unknownFields = []}
  parseMessage
    = let
        loop ::
          EnhancedStackTrace
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld StackTrace
             -> Data.ProtoLens.Encoding.Bytes.Parser EnhancedStackTrace
        loop x mutable'stacks
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'stacks <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'stacks)
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
                              (Data.ProtoLens.Field.field @"vec'stacks") frozen'stacks x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "sdk"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"sdk") y x)
                                  mutable'stacks
                        18
                          -> do !(entry :: EnhancedStackTrace'SourcesEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                                 (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                     Data.ProtoLens.Encoding.Bytes.isolate
                                                                                       (Prelude.fromIntegral
                                                                                          len)
                                                                                       Data.ProtoLens.parseMessage)
                                                                                 "sources"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"sources")
                                        (\ !t -> Data.Map.insert key value t) x)
                                     mutable'stacks)
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "stacks"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'stacks y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'stacks
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'stacks <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'stacks)
          "EnhancedStackTrace"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'sdk") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (Data.Monoid.mconcat
                   (Prelude.map
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                    (Lens.Family2.set
                                       (Data.ProtoLens.Field.field @"value") (Prelude.snd _v)
                                       (Data.ProtoLens.defMessage ::
                                          EnhancedStackTrace'SourcesEntry)))))
                      (Data.Map.toList
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"sources") _x))))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'stacks") _x))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData EnhancedStackTrace where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_EnhancedStackTrace'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_EnhancedStackTrace'sdk x__)
                (Control.DeepSeq.deepseq
                   (_EnhancedStackTrace'sources x__)
                   (Control.DeepSeq.deepseq (_EnhancedStackTrace'stacks x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.key' @:: Lens' EnhancedStackTrace'SourcesEntry Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.value' @:: Lens' EnhancedStackTrace'SourcesEntry StackTraceFileSlice@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.maybe'value' @:: Lens' EnhancedStackTrace'SourcesEntry (Prelude.Maybe StackTraceFileSlice)@ -}
data EnhancedStackTrace'SourcesEntry
  = EnhancedStackTrace'SourcesEntry'_constructor {_EnhancedStackTrace'SourcesEntry'key :: !Data.Text.Text,
                                                  _EnhancedStackTrace'SourcesEntry'value :: !(Prelude.Maybe StackTraceFileSlice),
                                                  _EnhancedStackTrace'SourcesEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show EnhancedStackTrace'SourcesEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField EnhancedStackTrace'SourcesEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'SourcesEntry'key
           (\ x__ y__ -> x__ {_EnhancedStackTrace'SourcesEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField EnhancedStackTrace'SourcesEntry "value" StackTraceFileSlice where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'SourcesEntry'value
           (\ x__ y__ -> x__ {_EnhancedStackTrace'SourcesEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField EnhancedStackTrace'SourcesEntry "maybe'value" (Prelude.Maybe StackTraceFileSlice) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _EnhancedStackTrace'SourcesEntry'value
           (\ x__ y__ -> x__ {_EnhancedStackTrace'SourcesEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message EnhancedStackTrace'SourcesEntry where
  messageName _
    = Data.Text.pack
        "temporal.api.sdk.v1.EnhancedStackTrace.SourcesEntry"
  packedMessageDescriptor _
    = "\n\
      \\fSourcesEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2>\n\
      \\ENQvalue\CAN\STX \SOH(\v2(.temporal.api.sdk.v1.StackTraceFileSliceR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        key__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"key")) ::
              Data.ProtoLens.FieldDescriptor EnhancedStackTrace'SourcesEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StackTraceFileSlice)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor EnhancedStackTrace'SourcesEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _EnhancedStackTrace'SourcesEntry'_unknownFields
        (\ x__ y__
           -> x__ {_EnhancedStackTrace'SourcesEntry'_unknownFields = y__})
  defMessage
    = EnhancedStackTrace'SourcesEntry'_constructor
        {_EnhancedStackTrace'SourcesEntry'key = Data.ProtoLens.fieldDefault,
         _EnhancedStackTrace'SourcesEntry'value = Prelude.Nothing,
         _EnhancedStackTrace'SourcesEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          EnhancedStackTrace'SourcesEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser EnhancedStackTrace'SourcesEntry
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
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
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "key"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"key") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "value"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"value") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SourcesEntry"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"key") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'value") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData EnhancedStackTrace'SourcesEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_EnhancedStackTrace'SourcesEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_EnhancedStackTrace'SourcesEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_EnhancedStackTrace'SourcesEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.locations' @:: Lens' StackTrace [StackTraceFileLocation]@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.vec'locations' @:: Lens' StackTrace (Data.Vector.Vector StackTraceFileLocation)@ -}
data StackTrace
  = StackTrace'_constructor {_StackTrace'locations :: !(Data.Vector.Vector StackTraceFileLocation),
                             _StackTrace'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StackTrace where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StackTrace "locations" [StackTraceFileLocation] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTrace'locations
           (\ x__ y__ -> x__ {_StackTrace'locations = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField StackTrace "vec'locations" (Data.Vector.Vector StackTraceFileLocation) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTrace'locations
           (\ x__ y__ -> x__ {_StackTrace'locations = y__}))
        Prelude.id
instance Data.ProtoLens.Message StackTrace where
  messageName _ = Data.Text.pack "temporal.api.sdk.v1.StackTrace"
  packedMessageDescriptor _
    = "\n\
      \\n\
      \StackTrace\DC2I\n\
      \\tlocations\CAN\SOH \ETX(\v2+.temporal.api.sdk.v1.StackTraceFileLocationR\tlocations"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        locations__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "locations"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StackTraceFileLocation)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"locations")) ::
              Data.ProtoLens.FieldDescriptor StackTrace
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, locations__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StackTrace'_unknownFields
        (\ x__ y__ -> x__ {_StackTrace'_unknownFields = y__})
  defMessage
    = StackTrace'_constructor
        {_StackTrace'locations = Data.Vector.Generic.empty,
         _StackTrace'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StackTrace
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld StackTraceFileLocation
             -> Data.ProtoLens.Encoding.Bytes.Parser StackTrace
        loop x mutable'locations
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'locations <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                               mutable'locations)
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
                              (Data.ProtoLens.Field.field @"vec'locations") frozen'locations x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "locations"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'locations y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'locations
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'locations <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                     Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'locations)
          "StackTrace"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                (\ _v
                   -> (Data.Monoid.<>)
                        (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                        ((Prelude..)
                           (\ bs
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                      (Prelude.fromIntegral (Data.ByteString.length bs)))
                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                           Data.ProtoLens.encodeMessage _v))
                (Lens.Family2.view
                   (Data.ProtoLens.Field.field @"vec'locations") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData StackTrace where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StackTrace'_unknownFields x__)
             (Control.DeepSeq.deepseq (_StackTrace'locations x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.filePath' @:: Lens' StackTraceFileLocation Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.line' @:: Lens' StackTraceFileLocation Data.Int.Int32@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.column' @:: Lens' StackTraceFileLocation Data.Int.Int32@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.functionName' @:: Lens' StackTraceFileLocation Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.internalCode' @:: Lens' StackTraceFileLocation Prelude.Bool@ -}
data StackTraceFileLocation
  = StackTraceFileLocation'_constructor {_StackTraceFileLocation'filePath :: !Data.Text.Text,
                                         _StackTraceFileLocation'line :: !Data.Int.Int32,
                                         _StackTraceFileLocation'column :: !Data.Int.Int32,
                                         _StackTraceFileLocation'functionName :: !Data.Text.Text,
                                         _StackTraceFileLocation'internalCode :: !Prelude.Bool,
                                         _StackTraceFileLocation'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StackTraceFileLocation where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StackTraceFileLocation "filePath" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileLocation'filePath
           (\ x__ y__ -> x__ {_StackTraceFileLocation'filePath = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StackTraceFileLocation "line" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileLocation'line
           (\ x__ y__ -> x__ {_StackTraceFileLocation'line = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StackTraceFileLocation "column" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileLocation'column
           (\ x__ y__ -> x__ {_StackTraceFileLocation'column = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StackTraceFileLocation "functionName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileLocation'functionName
           (\ x__ y__ -> x__ {_StackTraceFileLocation'functionName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StackTraceFileLocation "internalCode" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileLocation'internalCode
           (\ x__ y__ -> x__ {_StackTraceFileLocation'internalCode = y__}))
        Prelude.id
instance Data.ProtoLens.Message StackTraceFileLocation where
  messageName _
    = Data.Text.pack "temporal.api.sdk.v1.StackTraceFileLocation"
  packedMessageDescriptor _
    = "\n\
      \\SYNStackTraceFileLocation\DC2\ESC\n\
      \\tfile_path\CAN\SOH \SOH(\tR\bfilePath\DC2\DC2\n\
      \\EOTline\CAN\STX \SOH(\ENQR\EOTline\DC2\SYN\n\
      \\ACKcolumn\CAN\ETX \SOH(\ENQR\ACKcolumn\DC2#\n\
      \\rfunction_name\CAN\EOT \SOH(\tR\ffunctionName\DC2#\n\
      \\rinternal_code\CAN\ENQ \SOH(\bR\finternalCode"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        filePath__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "file_path"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"filePath")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileLocation
        line__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "line"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"line")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileLocation
        column__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "column"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"column")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileLocation
        functionName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "function_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"functionName")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileLocation
        internalCode__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "internal_code"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"internalCode")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileLocation
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, filePath__field_descriptor),
           (Data.ProtoLens.Tag 2, line__field_descriptor),
           (Data.ProtoLens.Tag 3, column__field_descriptor),
           (Data.ProtoLens.Tag 4, functionName__field_descriptor),
           (Data.ProtoLens.Tag 5, internalCode__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StackTraceFileLocation'_unknownFields
        (\ x__ y__ -> x__ {_StackTraceFileLocation'_unknownFields = y__})
  defMessage
    = StackTraceFileLocation'_constructor
        {_StackTraceFileLocation'filePath = Data.ProtoLens.fieldDefault,
         _StackTraceFileLocation'line = Data.ProtoLens.fieldDefault,
         _StackTraceFileLocation'column = Data.ProtoLens.fieldDefault,
         _StackTraceFileLocation'functionName = Data.ProtoLens.fieldDefault,
         _StackTraceFileLocation'internalCode = Data.ProtoLens.fieldDefault,
         _StackTraceFileLocation'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StackTraceFileLocation
          -> Data.ProtoLens.Encoding.Bytes.Parser StackTraceFileLocation
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
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
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "file_path"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"filePath") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "line"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"line") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "column"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"column") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "function_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"functionName") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "internal_code"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"internalCode") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StackTraceFileLocation"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"filePath") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"line") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"column") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view (Data.ProtoLens.Field.field @"functionName") _x
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
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view (Data.ProtoLens.Field.field @"internalCode") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (\ b -> if b then 1 else 0) _v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData StackTraceFileLocation where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StackTraceFileLocation'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StackTraceFileLocation'filePath x__)
                (Control.DeepSeq.deepseq
                   (_StackTraceFileLocation'line x__)
                   (Control.DeepSeq.deepseq
                      (_StackTraceFileLocation'column x__)
                      (Control.DeepSeq.deepseq
                         (_StackTraceFileLocation'functionName x__)
                         (Control.DeepSeq.deepseq
                            (_StackTraceFileLocation'internalCode x__) ())))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.lineOffset' @:: Lens' StackTraceFileSlice Data.Word.Word32@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.content' @:: Lens' StackTraceFileSlice Data.Text.Text@ -}
data StackTraceFileSlice
  = StackTraceFileSlice'_constructor {_StackTraceFileSlice'lineOffset :: !Data.Word.Word32,
                                      _StackTraceFileSlice'content :: !Data.Text.Text,
                                      _StackTraceFileSlice'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StackTraceFileSlice where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StackTraceFileSlice "lineOffset" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileSlice'lineOffset
           (\ x__ y__ -> x__ {_StackTraceFileSlice'lineOffset = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StackTraceFileSlice "content" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceFileSlice'content
           (\ x__ y__ -> x__ {_StackTraceFileSlice'content = y__}))
        Prelude.id
instance Data.ProtoLens.Message StackTraceFileSlice where
  messageName _
    = Data.Text.pack "temporal.api.sdk.v1.StackTraceFileSlice"
  packedMessageDescriptor _
    = "\n\
      \\DC3StackTraceFileSlice\DC2\US\n\
      \\vline_offset\CAN\SOH \SOH(\rR\n\
      \lineOffset\DC2\CAN\n\
      \\acontent\CAN\STX \SOH(\tR\acontent"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        lineOffset__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "line_offset"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"lineOffset")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileSlice
        content__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "content"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"content")) ::
              Data.ProtoLens.FieldDescriptor StackTraceFileSlice
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, lineOffset__field_descriptor),
           (Data.ProtoLens.Tag 2, content__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StackTraceFileSlice'_unknownFields
        (\ x__ y__ -> x__ {_StackTraceFileSlice'_unknownFields = y__})
  defMessage
    = StackTraceFileSlice'_constructor
        {_StackTraceFileSlice'lineOffset = Data.ProtoLens.fieldDefault,
         _StackTraceFileSlice'content = Data.ProtoLens.fieldDefault,
         _StackTraceFileSlice'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StackTraceFileSlice
          -> Data.ProtoLens.Encoding.Bytes.Parser StackTraceFileSlice
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
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
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "line_offset"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"lineOffset") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "content"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"content") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StackTraceFileSlice"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"lineOffset") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"content") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData StackTraceFileSlice where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StackTraceFileSlice'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StackTraceFileSlice'lineOffset x__)
                (Control.DeepSeq.deepseq (_StackTraceFileSlice'content x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.name' @:: Lens' StackTraceSDKInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.EnhancedStackTrace_Fields.version' @:: Lens' StackTraceSDKInfo Data.Text.Text@ -}
data StackTraceSDKInfo
  = StackTraceSDKInfo'_constructor {_StackTraceSDKInfo'name :: !Data.Text.Text,
                                    _StackTraceSDKInfo'version :: !Data.Text.Text,
                                    _StackTraceSDKInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StackTraceSDKInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StackTraceSDKInfo "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceSDKInfo'name
           (\ x__ y__ -> x__ {_StackTraceSDKInfo'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StackTraceSDKInfo "version" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StackTraceSDKInfo'version
           (\ x__ y__ -> x__ {_StackTraceSDKInfo'version = y__}))
        Prelude.id
instance Data.ProtoLens.Message StackTraceSDKInfo where
  messageName _
    = Data.Text.pack "temporal.api.sdk.v1.StackTraceSDKInfo"
  packedMessageDescriptor _
    = "\n\
      \\DC1StackTraceSDKInfo\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\CAN\n\
      \\aversion\CAN\STX \SOH(\tR\aversion"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor StackTraceSDKInfo
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor StackTraceSDKInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, version__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StackTraceSDKInfo'_unknownFields
        (\ x__ y__ -> x__ {_StackTraceSDKInfo'_unknownFields = y__})
  defMessage
    = StackTraceSDKInfo'_constructor
        {_StackTraceSDKInfo'name = Data.ProtoLens.fieldDefault,
         _StackTraceSDKInfo'version = Data.ProtoLens.fieldDefault,
         _StackTraceSDKInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StackTraceSDKInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser StackTraceSDKInfo
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
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
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "version"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "StackTraceSDKInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData StackTraceSDKInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StackTraceSDKInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StackTraceSDKInfo'name x__)
                (Control.DeepSeq.deepseq (_StackTraceSDKInfo'version x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \.temporal/api/sdk/v1/enhanced_stack_trace.proto\DC2\DC3temporal.api.sdk.v1\"\189\STX\n\
    \\DC2EnhancedStackTrace\DC28\n\
    \\ETXsdk\CAN\SOH \SOH(\v2&.temporal.api.sdk.v1.StackTraceSDKInfoR\ETXsdk\DC2N\n\
    \\asources\CAN\STX \ETX(\v24.temporal.api.sdk.v1.EnhancedStackTrace.SourcesEntryR\asources\DC27\n\
    \\ACKstacks\CAN\ETX \ETX(\v2\US.temporal.api.sdk.v1.StackTraceR\ACKstacks\SUBd\n\
    \\fSourcesEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2>\n\
    \\ENQvalue\CAN\STX \SOH(\v2(.temporal.api.sdk.v1.StackTraceFileSliceR\ENQvalue:\STX8\SOH\"A\n\
    \\DC1StackTraceSDKInfo\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2\CAN\n\
    \\aversion\CAN\STX \SOH(\tR\aversion\"P\n\
    \\DC3StackTraceFileSlice\DC2\US\n\
    \\vline_offset\CAN\SOH \SOH(\rR\n\
    \lineOffset\DC2\CAN\n\
    \\acontent\CAN\STX \SOH(\tR\acontent\"\171\SOH\n\
    \\SYNStackTraceFileLocation\DC2\ESC\n\
    \\tfile_path\CAN\SOH \SOH(\tR\bfilePath\DC2\DC2\n\
    \\EOTline\CAN\STX \SOH(\ENQR\EOTline\DC2\SYN\n\
    \\ACKcolumn\CAN\ETX \SOH(\ENQR\ACKcolumn\DC2#\n\
    \\rfunction_name\CAN\EOT \SOH(\tR\ffunctionName\DC2#\n\
    \\rinternal_code\CAN\ENQ \SOH(\bR\finternalCode\"W\n\
    \\n\
    \StackTrace\DC2I\n\
    \\tlocations\CAN\SOH \ETX(\v2+.temporal.api.sdk.v1.StackTraceFileLocationR\tlocationsB\133\SOH\n\
    \\SYNio.temporal.api.sdk.v1B\ETBEnhancedStackTraceProtoP\SOHZ\GSgo.temporal.io/api/sdk/v1;sdk\170\STX\NAKTemporalio.Api.Sdk.V1\234\STX\CANTemporalio::Api::Sdk::V1J\248\RS\n\
    \\ACK\DC2\EOT\SYN\NUL_\SOH\n\
    \\241\b\n\
    \\SOH\f\DC2\ETX\SYN\NUL\DC22\230\b The MIT License\n\
    \\n\
    \ Copyright (c) 2024 Temporal Technologies Inc.  All rights reserved.\n\
    \\n\
    \ Permission is hereby granted, free of charge, to any person obtaining a copy\n\
    \ of this software and associated documentation files (the \"Software\"), to deal\n\
    \ in the Software without restriction, including without limitation the rights\n\
    \ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n\
    \ copies of the Software, and to permit persons to whom the Software is\n\
    \ furnished to do so, subject to the following conditions:\n\
    \\n\
    \ The above copyright notice and this permission notice shall be included in\n\
    \ all copies or substantial portions of the Software.\n\
    \\n\
    \ THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n\
    \ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n\
    \ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n\
    \ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n\
    \ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n\
    \ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n\
    \ THE SOFTWARE.\n\
    \\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\CAN\NUL\FS\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL4\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL4\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL/\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL/\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\FS\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NUL8\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\GS\NUL8\n\
    \\b\n\
    \\SOH\b\DC2\ETX\RS\NUL1\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL1\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL2\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL2\n\
    \\\\n\
    \\STX\EOT\NUL\DC2\EOT\"\NUL+\SOH\SUBP Internal structure used to create worker stack traces with references to code.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\"\b\SUB\n\
    \W\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX$\EOT\RS\SUBJ Information pertaining to the SDK that the trace has been captured from.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX$\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX$\SYN\EM\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX$\FS\GS\n\
    \5\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX'\EOT1\SUB( Mapping of file path to file contents.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX'\EOT$\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX'%,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX'/0\n\
    \-\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX*\EOT#\SUB  Collection of stacks captured.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\EOT\DC2\ETX*\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX*\r\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX*\CAN\RS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX*!\"\n\
    \\209\SOH\n\
    \\STX\EOT\SOH\DC2\EOT0\NUL6\SOH\SUB\196\SOH Information pertaining to the SDK that the trace has been captured from.\n\
    \ (-- api-linter: core::0123::resource-annotation=disabled\n\
    \     aip.dev/not-precedent: Naming SDK version is optional. --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX0\b\EM\n\
    \\RS\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX2\EOT\DC4\SUB\DC1 Name of the SDK\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX2\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX2\v\SI\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX2\DC2\DC3\n\
    \(\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX5\EOT\ETB\SUB\ESC Version string of the SDK\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX5\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX5\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX5\NAK\SYN\n\
    \\DEL\n\
    \\STX\EOT\STX\DC2\EOT9\NULB\SOH\SUBs \"Slice\" of a file starting at line_offset -- a line offset and code fragment corresponding to the worker's stack.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX9\b\ESC\n\
    \\175\STX\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX>\EOT\ESC\SUB\161\STX Only used (possibly) to trim the file without breaking syntax highlighting. This is not optional, unlike\n\
    \ the `line` property of a `StackTraceFileLocation`.\n\
    \ (-- api-linter: core::0141::forbidden-types=disabled\n\
    \     aip.dev/not-precedent: These really shouldn't have negative values. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX>\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX>\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX>\EM\SUB\n\
    \O\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXA\EOT\ETB\SUBB Slice of a file with the respective OS-specific line terminator.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETXA\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXA\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXA\NAK\SYN\n\
    \\192\SOH\n\
    \\STX\EOT\ETX\DC2\EOTF\NULY\SOH\SUB\179\SOH More specific location details of a file: its path, precise line and column numbers if applicable, and function name if available.\n\
    \ In essence, a pointer to a location in a file\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXF\b\RS\n\
    \\138\SOH\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXI\EOT\EM\SUB} Path to source file (absolute or relative).\n\
    \ If the paths are relative, ensure that they are all relative to the same root.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXI\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXI\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXI\ETB\CAN\n\
    \\142\SOH\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXM\EOT\DC3\SUB\128\SOH Optional; If possible, SDK should send this -- this is required for displaying the code location.\n\
    \ If not provided, set to -1.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXM\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXM\n\
    \\SO\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXM\DC1\DC2\n\
    \X\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETXQ\EOT\NAK\SUBK Optional; if possible, SDK should send this.\n\
    \ If not provided, set to -1.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ENQ\DC2\ETXQ\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETXQ\n\
    \\DLE\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETXQ\DC3\DC4\n\
    \m\n\
    \\EOT\EOT\ETX\STX\ETX\DC2\ETXU\EOT\GS\SUB` Function name this line belongs to, if applicable.\n\
    \ Used for falling back to stack trace view.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ENQ\DC2\ETXU\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\SOH\DC2\ETXU\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ETX\DC2\ETXU\ESC\FS\n\
    \d\n\
    \\EOT\EOT\ETX\STX\EOT\DC2\ETXX\EOT\ESC\SUBW Flag to communicate whether a location should be hidden by default in the stack view.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ENQ\DC2\ETXX\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\SOH\DC2\ETXX\t\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ETX\DC2\ETXX\EM\SUB\n\
    \F\n\
    \\STX\EOT\EOT\DC2\EOT\\\NUL_\SOH\SUB: Collection of FileLocation messages from a single stack.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX\\\b\DC2\n\
    \a\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX^\EOT2\SUBT Collection of `FileLocation`s, each for a stack frame that comprise a stack trace.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\EOT\DC2\ETX^\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETX^\r#\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX^$-\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX^01b\ACKproto3"