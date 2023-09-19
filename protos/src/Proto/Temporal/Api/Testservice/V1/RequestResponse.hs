{- This file was auto-generated from temporal/api/testservice/v1/request_response.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Testservice.V1.RequestResponse (
        GetCurrentTimeResponse(), LockTimeSkippingRequest(),
        LockTimeSkippingResponse(), SleepRequest(), SleepResponse(),
        SleepUntilRequest(), UnlockTimeSkippingRequest(),
        UnlockTimeSkippingResponse()
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
import qualified Proto.Dependencies.Gogoproto.Gogo
import qualified Proto.Google.Protobuf.Duration
import qualified Proto.Google.Protobuf.Timestamp
{- | Fields :
     
         * 'Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields.time' @:: Lens' GetCurrentTimeResponse Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields.maybe'time' @:: Lens' GetCurrentTimeResponse (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data GetCurrentTimeResponse
  = GetCurrentTimeResponse'_constructor {_GetCurrentTimeResponse'time :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                         _GetCurrentTimeResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show GetCurrentTimeResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField GetCurrentTimeResponse "time" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetCurrentTimeResponse'time
           (\ x__ y__ -> x__ {_GetCurrentTimeResponse'time = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField GetCurrentTimeResponse "maybe'time" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _GetCurrentTimeResponse'time
           (\ x__ y__ -> x__ {_GetCurrentTimeResponse'time = y__}))
        Prelude.id
instance Data.ProtoLens.Message GetCurrentTimeResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.testservice.v1.GetCurrentTimeResponse"
  packedMessageDescriptor _
    = "\n\
      \\SYNGetCurrentTimeResponse\DC24\n\
      \\EOTtime\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\EOTtimeB\EOT\144\223\US\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        time__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'time")) ::
              Data.ProtoLens.FieldDescriptor GetCurrentTimeResponse
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, time__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _GetCurrentTimeResponse'_unknownFields
        (\ x__ y__ -> x__ {_GetCurrentTimeResponse'_unknownFields = y__})
  defMessage
    = GetCurrentTimeResponse'_constructor
        {_GetCurrentTimeResponse'time = Prelude.Nothing,
         _GetCurrentTimeResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          GetCurrentTimeResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser GetCurrentTimeResponse
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
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "time"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"time") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "GetCurrentTimeResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'time") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData GetCurrentTimeResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_GetCurrentTimeResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq (_GetCurrentTimeResponse'time x__) ())
{- | Fields :
      -}
data LockTimeSkippingRequest
  = LockTimeSkippingRequest'_constructor {_LockTimeSkippingRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show LockTimeSkippingRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message LockTimeSkippingRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.testservice.v1.LockTimeSkippingRequest"
  packedMessageDescriptor _
    = "\n\
      \\ETBLockTimeSkippingRequest"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _LockTimeSkippingRequest'_unknownFields
        (\ x__ y__ -> x__ {_LockTimeSkippingRequest'_unknownFields = y__})
  defMessage
    = LockTimeSkippingRequest'_constructor
        {_LockTimeSkippingRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          LockTimeSkippingRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser LockTimeSkippingRequest
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "LockTimeSkippingRequest"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData LockTimeSkippingRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_LockTimeSkippingRequest'_unknownFields x__) ()
{- | Fields :
      -}
data LockTimeSkippingResponse
  = LockTimeSkippingResponse'_constructor {_LockTimeSkippingResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show LockTimeSkippingResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message LockTimeSkippingResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.testservice.v1.LockTimeSkippingResponse"
  packedMessageDescriptor _
    = "\n\
      \\CANLockTimeSkippingResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _LockTimeSkippingResponse'_unknownFields
        (\ x__ y__ -> x__ {_LockTimeSkippingResponse'_unknownFields = y__})
  defMessage
    = LockTimeSkippingResponse'_constructor
        {_LockTimeSkippingResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          LockTimeSkippingResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser LockTimeSkippingResponse
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "LockTimeSkippingResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData LockTimeSkippingResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_LockTimeSkippingResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields.duration' @:: Lens' SleepRequest Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields.maybe'duration' @:: Lens' SleepRequest (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@ -}
data SleepRequest
  = SleepRequest'_constructor {_SleepRequest'duration :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                               _SleepRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SleepRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SleepRequest "duration" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SleepRequest'duration
           (\ x__ y__ -> x__ {_SleepRequest'duration = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SleepRequest "maybe'duration" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SleepRequest'duration
           (\ x__ y__ -> x__ {_SleepRequest'duration = y__}))
        Prelude.id
instance Data.ProtoLens.Message SleepRequest where
  messageName _
    = Data.Text.pack "temporal.api.testservice.v1.SleepRequest"
  packedMessageDescriptor _
    = "\n\
      \\fSleepRequest\DC2;\n\
      \\bduration\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\bdurationB\EOT\152\223\US\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        duration__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "duration"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'duration")) ::
              Data.ProtoLens.FieldDescriptor SleepRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, duration__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SleepRequest'_unknownFields
        (\ x__ y__ -> x__ {_SleepRequest'_unknownFields = y__})
  defMessage
    = SleepRequest'_constructor
        {_SleepRequest'duration = Prelude.Nothing,
         _SleepRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SleepRequest -> Data.ProtoLens.Encoding.Bytes.Parser SleepRequest
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
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "duration"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"duration") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SleepRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'duration") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData SleepRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SleepRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq (_SleepRequest'duration x__) ())
{- | Fields :
      -}
data SleepResponse
  = SleepResponse'_constructor {_SleepResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SleepResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message SleepResponse where
  messageName _
    = Data.Text.pack "temporal.api.testservice.v1.SleepResponse"
  packedMessageDescriptor _
    = "\n\
      \\rSleepResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SleepResponse'_unknownFields
        (\ x__ y__ -> x__ {_SleepResponse'_unknownFields = y__})
  defMessage
    = SleepResponse'_constructor {_SleepResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SleepResponse -> Data.ProtoLens.Encoding.Bytes.Parser SleepResponse
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SleepResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData SleepResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq (_SleepResponse'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields.timestamp' @:: Lens' SleepUntilRequest Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Testservice.V1.RequestResponse_Fields.maybe'timestamp' @:: Lens' SleepUntilRequest (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data SleepUntilRequest
  = SleepUntilRequest'_constructor {_SleepUntilRequest'timestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                    _SleepUntilRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SleepUntilRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SleepUntilRequest "timestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SleepUntilRequest'timestamp
           (\ x__ y__ -> x__ {_SleepUntilRequest'timestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SleepUntilRequest "maybe'timestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SleepUntilRequest'timestamp
           (\ x__ y__ -> x__ {_SleepUntilRequest'timestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Message SleepUntilRequest where
  messageName _
    = Data.Text.pack "temporal.api.testservice.v1.SleepUntilRequest"
  packedMessageDescriptor _
    = "\n\
      \\DC1SleepUntilRequest\DC2>\n\
      \\ttimestamp\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ttimestampB\EOT\144\223\US\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        timestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'timestamp")) ::
              Data.ProtoLens.FieldDescriptor SleepUntilRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, timestamp__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SleepUntilRequest'_unknownFields
        (\ x__ y__ -> x__ {_SleepUntilRequest'_unknownFields = y__})
  defMessage
    = SleepUntilRequest'_constructor
        {_SleepUntilRequest'timestamp = Prelude.Nothing,
         _SleepUntilRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SleepUntilRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser SleepUntilRequest
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
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "timestamp"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"timestamp") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SleepUntilRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'timestamp") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData SleepUntilRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SleepUntilRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq (_SleepUntilRequest'timestamp x__) ())
{- | Fields :
      -}
data UnlockTimeSkippingRequest
  = UnlockTimeSkippingRequest'_constructor {_UnlockTimeSkippingRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UnlockTimeSkippingRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message UnlockTimeSkippingRequest where
  messageName _
    = Data.Text.pack
        "temporal.api.testservice.v1.UnlockTimeSkippingRequest"
  packedMessageDescriptor _
    = "\n\
      \\EMUnlockTimeSkippingRequest"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UnlockTimeSkippingRequest'_unknownFields
        (\ x__ y__
           -> x__ {_UnlockTimeSkippingRequest'_unknownFields = y__})
  defMessage
    = UnlockTimeSkippingRequest'_constructor
        {_UnlockTimeSkippingRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UnlockTimeSkippingRequest
          -> Data.ProtoLens.Encoding.Bytes.Parser UnlockTimeSkippingRequest
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UnlockTimeSkippingRequest"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData UnlockTimeSkippingRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UnlockTimeSkippingRequest'_unknownFields x__) ()
{- | Fields :
      -}
data UnlockTimeSkippingResponse
  = UnlockTimeSkippingResponse'_constructor {_UnlockTimeSkippingResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UnlockTimeSkippingResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message UnlockTimeSkippingResponse where
  messageName _
    = Data.Text.pack
        "temporal.api.testservice.v1.UnlockTimeSkippingResponse"
  packedMessageDescriptor _
    = "\n\
      \\SUBUnlockTimeSkippingResponse"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UnlockTimeSkippingResponse'_unknownFields
        (\ x__ y__
           -> x__ {_UnlockTimeSkippingResponse'_unknownFields = y__})
  defMessage
    = UnlockTimeSkippingResponse'_constructor
        {_UnlockTimeSkippingResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UnlockTimeSkippingResponse
          -> Data.ProtoLens.Encoding.Bytes.Parser UnlockTimeSkippingResponse
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
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UnlockTimeSkippingResponse"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData UnlockTimeSkippingResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UnlockTimeSkippingResponse'_unknownFields x__) ()
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \2temporal/api/testservice/v1/request_response.proto\DC2\ESCtemporal.api.testservice.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB!dependencies/gogoproto/gogo.proto\"\EM\n\
    \\ETBLockTimeSkippingRequest\"\SUB\n\
    \\CANLockTimeSkippingResponse\"\ESC\n\
    \\EMUnlockTimeSkippingRequest\"\FS\n\
    \\SUBUnlockTimeSkippingResponse\"S\n\
    \\DC1SleepUntilRequest\DC2>\n\
    \\ttimestamp\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ttimestampB\EOT\144\223\US\SOH\"K\n\
    \\fSleepRequest\DC2;\n\
    \\bduration\CAN\SOH \SOH(\v2\EM.google.protobuf.DurationR\bdurationB\EOT\152\223\US\SOH\"\SI\n\
    \\rSleepResponse\"N\n\
    \\SYNGetCurrentTimeResponse\DC24\n\
    \\EOTtime\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\EOTtimeB\EOT\144\223\US\SOHB\170\SOH\n\
    \\RSio.temporal.api.testservice.v1B\DC4RequestResponseProtoP\SOHZ-go.temporal.io/api/testservice/v1;testservice\170\STX\GSTemporalio.Api.TestService.V1\234\STX Temporalio::Api::TestService::V1J\231\r\n\
    \\ACK\DC2\EOT\SYN\NUL>\SOH\n\
    \\241\b\n\
    \\SOH\f\DC2\ETX\SYN\NUL\DC22\230\b The MIT License\n\
    \\n\
    \ Copyright (c) 2020 Temporal Technologies Inc.  All rights reserved.\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL$\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NULD\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NULD\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL7\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL7\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\FS\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NUL5\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\GS\NUL5\n\
    \\b\n\
    \\SOH\b\DC2\ETX\RS\NUL9\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL9\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL:\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL:\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL)\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX#\NUL+\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT%\NUL&\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX%\b\US\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT(\NUL)\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX(\b \n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT+\NUL,\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX+\b!\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT.\NUL/\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX.\b\"\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT1\NUL3\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX1\b\EM\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX2\EOTI\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETX2\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX2\RS'\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX2*+\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\b\DC2\ETX2,H\n\
    \\SI\n\
    \\b\EOT\EOT\STX\NUL\b\242\251\ETX\DC2\ETX2-G\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT5\NUL7\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX5\b\DC4\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX6\EOTK\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ACK\DC2\ETX6\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX6\GS%\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX6()\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\b\DC2\ETX6*J\n\
    \\SI\n\
    \\b\EOT\ENQ\STX\NUL\b\243\251\ETX\DC2\ETX6+I\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOT9\NUL:\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETX9\b\NAK\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOT<\NUL>\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETX<\b\RS\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETX=\EOTD\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ACK\DC2\ETX=\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETX=\RS\"\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETX=%&\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\b\DC2\ETX='C\n\
    \\SI\n\
    \\b\EOT\a\STX\NUL\b\242\251\ETX\DC2\ETX=(Bb\ACKproto3"