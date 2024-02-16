{- This file was auto-generated from temporal/api/batch/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Batch.V1.Message (
        BatchOperationCancellation(), BatchOperationDeletion(),
        BatchOperationInfo(), BatchOperationReset(),
        BatchOperationSignal(), BatchOperationTermination()
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.BatchOperation
import qualified Proto.Temporal.Api.Enums.V1.Reset
{- | Fields :
     
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.identity' @:: Lens' BatchOperationCancellation Data.Text.Text@ -}
data BatchOperationCancellation
  = BatchOperationCancellation'_constructor {_BatchOperationCancellation'identity :: !Data.Text.Text,
                                             _BatchOperationCancellation'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BatchOperationCancellation where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BatchOperationCancellation "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationCancellation'identity
           (\ x__ y__ -> x__ {_BatchOperationCancellation'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Message BatchOperationCancellation where
  messageName _
    = Data.Text.pack "temporal.api.batch.v1.BatchOperationCancellation"
  packedMessageDescriptor _
    = "\n\
      \\SUBBatchOperationCancellation\DC2\SUB\n\
      \\bidentity\CAN\SOH \SOH(\tR\bidentity"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationCancellation
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, identity__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BatchOperationCancellation'_unknownFields
        (\ x__ y__
           -> x__ {_BatchOperationCancellation'_unknownFields = y__})
  defMessage
    = BatchOperationCancellation'_constructor
        {_BatchOperationCancellation'identity = Data.ProtoLens.fieldDefault,
         _BatchOperationCancellation'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BatchOperationCancellation
          -> Data.ProtoLens.Encoding.Bytes.Parser BatchOperationCancellation
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
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchOperationCancellation"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData BatchOperationCancellation where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BatchOperationCancellation'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BatchOperationCancellation'identity x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.identity' @:: Lens' BatchOperationDeletion Data.Text.Text@ -}
data BatchOperationDeletion
  = BatchOperationDeletion'_constructor {_BatchOperationDeletion'identity :: !Data.Text.Text,
                                         _BatchOperationDeletion'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BatchOperationDeletion where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BatchOperationDeletion "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationDeletion'identity
           (\ x__ y__ -> x__ {_BatchOperationDeletion'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Message BatchOperationDeletion where
  messageName _
    = Data.Text.pack "temporal.api.batch.v1.BatchOperationDeletion"
  packedMessageDescriptor _
    = "\n\
      \\SYNBatchOperationDeletion\DC2\SUB\n\
      \\bidentity\CAN\SOH \SOH(\tR\bidentity"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationDeletion
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, identity__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BatchOperationDeletion'_unknownFields
        (\ x__ y__ -> x__ {_BatchOperationDeletion'_unknownFields = y__})
  defMessage
    = BatchOperationDeletion'_constructor
        {_BatchOperationDeletion'identity = Data.ProtoLens.fieldDefault,
         _BatchOperationDeletion'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BatchOperationDeletion
          -> Data.ProtoLens.Encoding.Bytes.Parser BatchOperationDeletion
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
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchOperationDeletion"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData BatchOperationDeletion where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BatchOperationDeletion'_unknownFields x__)
             (Control.DeepSeq.deepseq (_BatchOperationDeletion'identity x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.jobId' @:: Lens' BatchOperationInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.state' @:: Lens' BatchOperationInfo Proto.Temporal.Api.Enums.V1.BatchOperation.BatchOperationState@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.startTime' @:: Lens' BatchOperationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.maybe'startTime' @:: Lens' BatchOperationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.closeTime' @:: Lens' BatchOperationInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.maybe'closeTime' @:: Lens' BatchOperationInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data BatchOperationInfo
  = BatchOperationInfo'_constructor {_BatchOperationInfo'jobId :: !Data.Text.Text,
                                     _BatchOperationInfo'state :: !Proto.Temporal.Api.Enums.V1.BatchOperation.BatchOperationState,
                                     _BatchOperationInfo'startTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                     _BatchOperationInfo'closeTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                     _BatchOperationInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BatchOperationInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BatchOperationInfo "jobId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationInfo'jobId
           (\ x__ y__ -> x__ {_BatchOperationInfo'jobId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationInfo "state" Proto.Temporal.Api.Enums.V1.BatchOperation.BatchOperationState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationInfo'state
           (\ x__ y__ -> x__ {_BatchOperationInfo'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationInfo "startTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationInfo'startTime
           (\ x__ y__ -> x__ {_BatchOperationInfo'startTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BatchOperationInfo "maybe'startTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationInfo'startTime
           (\ x__ y__ -> x__ {_BatchOperationInfo'startTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationInfo "closeTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationInfo'closeTime
           (\ x__ y__ -> x__ {_BatchOperationInfo'closeTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BatchOperationInfo "maybe'closeTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationInfo'closeTime
           (\ x__ y__ -> x__ {_BatchOperationInfo'closeTime = y__}))
        Prelude.id
instance Data.ProtoLens.Message BatchOperationInfo where
  messageName _
    = Data.Text.pack "temporal.api.batch.v1.BatchOperationInfo"
  packedMessageDescriptor _
    = "\n\
      \\DC2BatchOperationInfo\DC2\NAK\n\
      \\ACKjob_id\CAN\SOH \SOH(\tR\ENQjobId\DC2@\n\
      \\ENQstate\CAN\STX \SOH(\SO2*.temporal.api.enums.v1.BatchOperationStateR\ENQstate\DC29\n\
      \\n\
      \start_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\DC29\n\
      \\n\
      \close_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\tcloseTime"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        jobId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "job_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"jobId")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationInfo
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.BatchOperation.BatchOperationState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationInfo
        startTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startTime")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationInfo
        closeTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "close_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'closeTime")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, jobId__field_descriptor),
           (Data.ProtoLens.Tag 2, state__field_descriptor),
           (Data.ProtoLens.Tag 3, startTime__field_descriptor),
           (Data.ProtoLens.Tag 4, closeTime__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BatchOperationInfo'_unknownFields
        (\ x__ y__ -> x__ {_BatchOperationInfo'_unknownFields = y__})
  defMessage
    = BatchOperationInfo'_constructor
        {_BatchOperationInfo'jobId = Data.ProtoLens.fieldDefault,
         _BatchOperationInfo'state = Data.ProtoLens.fieldDefault,
         _BatchOperationInfo'startTime = Prelude.Nothing,
         _BatchOperationInfo'closeTime = Prelude.Nothing,
         _BatchOperationInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BatchOperationInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser BatchOperationInfo
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
                                       "job_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"jobId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"startTime") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "close_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"closeTime") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchOperationInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"jobId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"state") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                            Prelude.fromEnum _v))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'startTime") _x
                    of
                      Prelude.Nothing -> Data.Monoid.mempty
                      (Prelude.Just _v)
                        -> (Data.Monoid.<>)
                             (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                             ((Prelude..)
                                (\ bs
                                   -> (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (Prelude.fromIntegral (Data.ByteString.length bs)))
                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                Data.ProtoLens.encodeMessage _v))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'closeTime") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData BatchOperationInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BatchOperationInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BatchOperationInfo'jobId x__)
                (Control.DeepSeq.deepseq
                   (_BatchOperationInfo'state x__)
                   (Control.DeepSeq.deepseq
                      (_BatchOperationInfo'startTime x__)
                      (Control.DeepSeq.deepseq (_BatchOperationInfo'closeTime x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.identity' @:: Lens' BatchOperationReset Data.Text.Text@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.options' @:: Lens' BatchOperationReset Proto.Temporal.Api.Common.V1.Message.ResetOptions@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.maybe'options' @:: Lens' BatchOperationReset (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ResetOptions)@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.resetType' @:: Lens' BatchOperationReset Proto.Temporal.Api.Enums.V1.Reset.ResetType@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.resetReapplyType' @:: Lens' BatchOperationReset Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType@ -}
data BatchOperationReset
  = BatchOperationReset'_constructor {_BatchOperationReset'identity :: !Data.Text.Text,
                                      _BatchOperationReset'options :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ResetOptions),
                                      _BatchOperationReset'resetType :: !Proto.Temporal.Api.Enums.V1.Reset.ResetType,
                                      _BatchOperationReset'resetReapplyType :: !Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType,
                                      _BatchOperationReset'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BatchOperationReset where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BatchOperationReset "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationReset'identity
           (\ x__ y__ -> x__ {_BatchOperationReset'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationReset "options" Proto.Temporal.Api.Common.V1.Message.ResetOptions where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationReset'options
           (\ x__ y__ -> x__ {_BatchOperationReset'options = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BatchOperationReset "maybe'options" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.ResetOptions) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationReset'options
           (\ x__ y__ -> x__ {_BatchOperationReset'options = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationReset "resetType" Proto.Temporal.Api.Enums.V1.Reset.ResetType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationReset'resetType
           (\ x__ y__ -> x__ {_BatchOperationReset'resetType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationReset "resetReapplyType" Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationReset'resetReapplyType
           (\ x__ y__ -> x__ {_BatchOperationReset'resetReapplyType = y__}))
        Prelude.id
instance Data.ProtoLens.Message BatchOperationReset where
  messageName _
    = Data.Text.pack "temporal.api.batch.v1.BatchOperationReset"
  packedMessageDescriptor _
    = "\n\
      \\DC3BatchOperationReset\DC2\SUB\n\
      \\bidentity\CAN\ETX \SOH(\tR\bidentity\DC2>\n\
      \\aoptions\CAN\EOT \SOH(\v2$.temporal.api.common.v1.ResetOptionsR\aoptions\DC2?\n\
      \\n\
      \reset_type\CAN\SOH \SOH(\SO2 .temporal.api.enums.v1.ResetTypeR\tresetType\DC2U\n\
      \\DC2reset_reapply_type\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.ResetReapplyTypeR\DLEresetReapplyType"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationReset
        options__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "options"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.ResetOptions)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'options")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationReset
        resetType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reset_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Reset.ResetType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"resetType")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationReset
        resetReapplyType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reset_reapply_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Reset.ResetReapplyType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"resetReapplyType")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationReset
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 3, identity__field_descriptor),
           (Data.ProtoLens.Tag 4, options__field_descriptor),
           (Data.ProtoLens.Tag 1, resetType__field_descriptor),
           (Data.ProtoLens.Tag 2, resetReapplyType__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BatchOperationReset'_unknownFields
        (\ x__ y__ -> x__ {_BatchOperationReset'_unknownFields = y__})
  defMessage
    = BatchOperationReset'_constructor
        {_BatchOperationReset'identity = Data.ProtoLens.fieldDefault,
         _BatchOperationReset'options = Prelude.Nothing,
         _BatchOperationReset'resetType = Data.ProtoLens.fieldDefault,
         _BatchOperationReset'resetReapplyType = Data.ProtoLens.fieldDefault,
         _BatchOperationReset'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BatchOperationReset
          -> Data.ProtoLens.Encoding.Bytes.Parser BatchOperationReset
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
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "options"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"options") y x)
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "reset_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"resetType") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "reset_reapply_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"resetReapplyType") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchOperationReset"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'options") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"resetType") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                            ((Prelude..)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                               Prelude.fromEnum _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"resetReapplyType") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                               ((Prelude..)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                                  Prelude.fromEnum _v))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData BatchOperationReset where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BatchOperationReset'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BatchOperationReset'identity x__)
                (Control.DeepSeq.deepseq
                   (_BatchOperationReset'options x__)
                   (Control.DeepSeq.deepseq
                      (_BatchOperationReset'resetType x__)
                      (Control.DeepSeq.deepseq
                         (_BatchOperationReset'resetReapplyType x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.signal' @:: Lens' BatchOperationSignal Data.Text.Text@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.input' @:: Lens' BatchOperationSignal Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.maybe'input' @:: Lens' BatchOperationSignal (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.header' @:: Lens' BatchOperationSignal Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.maybe'header' @:: Lens' BatchOperationSignal (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.identity' @:: Lens' BatchOperationSignal Data.Text.Text@ -}
data BatchOperationSignal
  = BatchOperationSignal'_constructor {_BatchOperationSignal'signal :: !Data.Text.Text,
                                       _BatchOperationSignal'input :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                       _BatchOperationSignal'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                       _BatchOperationSignal'identity :: !Data.Text.Text,
                                       _BatchOperationSignal'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BatchOperationSignal where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BatchOperationSignal "signal" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationSignal'signal
           (\ x__ y__ -> x__ {_BatchOperationSignal'signal = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationSignal "input" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationSignal'input
           (\ x__ y__ -> x__ {_BatchOperationSignal'input = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BatchOperationSignal "maybe'input" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationSignal'input
           (\ x__ y__ -> x__ {_BatchOperationSignal'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationSignal "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationSignal'header
           (\ x__ y__ -> x__ {_BatchOperationSignal'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BatchOperationSignal "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationSignal'header
           (\ x__ y__ -> x__ {_BatchOperationSignal'header = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationSignal "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationSignal'identity
           (\ x__ y__ -> x__ {_BatchOperationSignal'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Message BatchOperationSignal where
  messageName _
    = Data.Text.pack "temporal.api.batch.v1.BatchOperationSignal"
  packedMessageDescriptor _
    = "\n\
      \\DC4BatchOperationSignal\DC2\SYN\n\
      \\ACKsignal\CAN\SOH \SOH(\tR\ACKsignal\DC26\n\
      \\ENQinput\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC26\n\
      \\ACKheader\CAN\ETX \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2\SUB\n\
      \\bidentity\CAN\EOT \SOH(\tR\bidentity"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        signal__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "signal"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"signal")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationSignal
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'input")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationSignal
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationSignal
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationSignal
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, signal__field_descriptor),
           (Data.ProtoLens.Tag 2, input__field_descriptor),
           (Data.ProtoLens.Tag 3, header__field_descriptor),
           (Data.ProtoLens.Tag 4, identity__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BatchOperationSignal'_unknownFields
        (\ x__ y__ -> x__ {_BatchOperationSignal'_unknownFields = y__})
  defMessage
    = BatchOperationSignal'_constructor
        {_BatchOperationSignal'signal = Data.ProtoLens.fieldDefault,
         _BatchOperationSignal'input = Prelude.Nothing,
         _BatchOperationSignal'header = Prelude.Nothing,
         _BatchOperationSignal'identity = Data.ProtoLens.fieldDefault,
         _BatchOperationSignal'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BatchOperationSignal
          -> Data.ProtoLens.Encoding.Bytes.Parser BatchOperationSignal
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
                                       "signal"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"signal") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "input"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"input") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchOperationSignal"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"signal") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'input") _x
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
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'header") _x
                    of
                      Prelude.Nothing -> Data.Monoid.mempty
                      (Prelude.Just _v)
                        -> (Data.Monoid.<>)
                             (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                             ((Prelude..)
                                (\ bs
                                   -> (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (Prelude.fromIntegral (Data.ByteString.length bs)))
                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                Data.ProtoLens.encodeMessage _v))
                   ((Data.Monoid.<>)
                      (let
                         _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
instance Control.DeepSeq.NFData BatchOperationSignal where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BatchOperationSignal'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BatchOperationSignal'signal x__)
                (Control.DeepSeq.deepseq
                   (_BatchOperationSignal'input x__)
                   (Control.DeepSeq.deepseq
                      (_BatchOperationSignal'header x__)
                      (Control.DeepSeq.deepseq
                         (_BatchOperationSignal'identity x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.details' @:: Lens' BatchOperationTermination Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.maybe'details' @:: Lens' BatchOperationTermination (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Batch.V1.Message_Fields.identity' @:: Lens' BatchOperationTermination Data.Text.Text@ -}
data BatchOperationTermination
  = BatchOperationTermination'_constructor {_BatchOperationTermination'details :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                            _BatchOperationTermination'identity :: !Data.Text.Text,
                                            _BatchOperationTermination'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show BatchOperationTermination where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField BatchOperationTermination "details" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationTermination'details
           (\ x__ y__ -> x__ {_BatchOperationTermination'details = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField BatchOperationTermination "maybe'details" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationTermination'details
           (\ x__ y__ -> x__ {_BatchOperationTermination'details = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField BatchOperationTermination "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _BatchOperationTermination'identity
           (\ x__ y__ -> x__ {_BatchOperationTermination'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Message BatchOperationTermination where
  messageName _
    = Data.Text.pack "temporal.api.batch.v1.BatchOperationTermination"
  packedMessageDescriptor _
    = "\n\
      \\EMBatchOperationTermination\DC2:\n\
      \\adetails\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsR\adetails\DC2\SUB\n\
      \\bidentity\CAN\STX \SOH(\tR\bidentity"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'details")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationTermination
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor BatchOperationTermination
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, details__field_descriptor),
           (Data.ProtoLens.Tag 2, identity__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _BatchOperationTermination'_unknownFields
        (\ x__ y__
           -> x__ {_BatchOperationTermination'_unknownFields = y__})
  defMessage
    = BatchOperationTermination'_constructor
        {_BatchOperationTermination'details = Prelude.Nothing,
         _BatchOperationTermination'identity = Data.ProtoLens.fieldDefault,
         _BatchOperationTermination'_unknownFields = []}
  parseMessage
    = let
        loop ::
          BatchOperationTermination
          -> Data.ProtoLens.Encoding.Bytes.Parser BatchOperationTermination
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
                                       "details"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"details") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BatchOperationTermination"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'details") _x
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
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
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
instance Control.DeepSeq.NFData BatchOperationTermination where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_BatchOperationTermination'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_BatchOperationTermination'details x__)
                (Control.DeepSeq.deepseq
                   (_BatchOperationTermination'identity x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \#temporal/api/batch/v1/message.proto\DC2\NAKtemporal.api.batch.v1\SUB\USgoogle/protobuf/timestamp.proto\SUB$temporal/api/common/v1/message.proto\SUB+temporal/api/enums/v1/batch_operation.proto\SUB!temporal/api/enums/v1/reset.proto\"\227\SOH\n\
    \\DC2BatchOperationInfo\DC2\NAK\n\
    \\ACKjob_id\CAN\SOH \SOH(\tR\ENQjobId\DC2@\n\
    \\ENQstate\CAN\STX \SOH(\SO2*.temporal.api.enums.v1.BatchOperationStateR\ENQstate\DC29\n\
    \\n\
    \start_time\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\DC29\n\
    \\n\
    \close_time\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\tcloseTime\"s\n\
    \\EMBatchOperationTermination\DC2:\n\
    \\adetails\CAN\SOH \SOH(\v2 .temporal.api.common.v1.PayloadsR\adetails\DC2\SUB\n\
    \\bidentity\CAN\STX \SOH(\tR\bidentity\"\186\SOH\n\
    \\DC4BatchOperationSignal\DC2\SYN\n\
    \\ACKsignal\CAN\SOH \SOH(\tR\ACKsignal\DC26\n\
    \\ENQinput\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ENQinput\DC26\n\
    \\ACKheader\CAN\ETX \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\DC2\SUB\n\
    \\bidentity\CAN\EOT \SOH(\tR\bidentity\"8\n\
    \\SUBBatchOperationCancellation\DC2\SUB\n\
    \\bidentity\CAN\SOH \SOH(\tR\bidentity\"4\n\
    \\SYNBatchOperationDeletion\DC2\SUB\n\
    \\bidentity\CAN\SOH \SOH(\tR\bidentity\"\137\STX\n\
    \\DC3BatchOperationReset\DC2\SUB\n\
    \\bidentity\CAN\ETX \SOH(\tR\bidentity\DC2>\n\
    \\aoptions\CAN\EOT \SOH(\v2$.temporal.api.common.v1.ResetOptionsR\aoptions\DC2?\n\
    \\n\
    \reset_type\CAN\SOH \SOH(\SO2 .temporal.api.enums.v1.ResetTypeR\tresetType\DC2U\n\
    \\DC2reset_reapply_type\CAN\STX \SOH(\SO2'.temporal.api.enums.v1.ResetReapplyTypeR\DLEresetReapplyTypeB\132\SOH\n\
    \\CANio.temporal.api.batch.v1B\fMessageProtoP\SOHZ!go.temporal.io/api/batch/v1;batch\170\STX\ETBTemporalio.Api.Batch.V1\234\STX\SUBTemporalio::Api::Batch::V1J\192 \n\
    \\ACK\DC2\EOT\SYN\NULg\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL\RS\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL8\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL8\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL1\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL1\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\FS\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NUL-\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\GS\NUL-\n\
    \\b\n\
    \\SOH\b\DC2\ETX\RS\NUL3\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL3\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL4\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL4\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL)\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX#\NUL.\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX$\NUL5\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX%\NUL+\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT'\NUL0\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX'\b\SUB\n\
    \\ESC\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX)\STX\DC4\SUB\SO Batch job ID\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX)\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX)\t\SI\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX)\DC2\DC3\n\
    \$\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX+\STX6\SUB\ETB Batch operation state\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX+\STX+\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX+,1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX+45\n\
    \)\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX-\STX+\SUB\FS Batch operation start time\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX-\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX-\FS&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX-)*\n\
    \)\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX/\STX+\SUB\FS Batch operation close time\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ACK\DC2\ETX/\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX/\FS&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX/)*\n\
    \\140\STX\n\
    \\STX\EOT\SOH\DC2\EOT5\NUL:\SOH\SUB\255\SOH BatchOperationTermination sends terminate requests to batch workflows.\n\
    \ Keep the parameter in sync with temporal.api.workflowservice.v1.TerminateWorkflowExecutionRequest.\n\
    \ Ignore first_execution_run_id because this is used for single workflow operation.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX5\b!\n\
    \F\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX7\STX.\SUB9 Serialized value(s) to provide to the termination event\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX7\STX!\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX7\")\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX7,-\n\
    \0\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX9\STX\SYN\SUB# The identity of the worker/client\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX9\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX9\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX9\DC4\NAK\n\
    \\166\SOH\n\
    \\STX\EOT\STX\DC2\EOT>\NULH\SOH\SUB\153\SOH BatchOperationSignal sends signals to batch workflows.\n\
    \ Keep the parameter in sync with temporal.api.workflowservice.v1.SignalWorkflowExecutionRequest.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX>\b\FS\n\
    \U\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX@\STX\DC4\SUBH The workflow author-defined name of the signal to send to the workflow\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX@\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX@\t\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX@\DC2\DC3\n\
    \=\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXB\STX,\SUB0 Serialized value(s) to provide with the signal\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETXB\STX!\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXB\"'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXB*+\n\
    \\137\SOH\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETXE\STX+\SUB| Headers that are passed with the signal to the processing workflow.\n\
    \ These can include things like auth or tracing tokens.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ACK\DC2\ETXE\STX\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETXE &\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETXE)*\n\
    \0\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETXG\STX\SYN\SUB# The identity of the worker/client\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ENQ\DC2\ETXG\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETXG\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETXG\DC4\NAK\n\
    \\142\STX\n\
    \\STX\EOT\ETX\DC2\EOTM\NULP\SOH\SUB\129\STX BatchOperationCancellation sends cancel requests to batch workflows.\n\
    \ Keep the parameter in sync with temporal.api.workflowservice.v1.RequestCancelWorkflowExecutionRequest.\n\
    \ Ignore first_execution_run_id because this is used for single workflow operation.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXM\b\"\n\
    \0\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXO\STX\SYN\SUB# The identity of the worker/client\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXO\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXO\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXO\DC4\NAK\n\
    \\178\SOH\n\
    \\STX\EOT\EOT\DC2\EOTT\NULW\SOH\SUB\165\SOH BatchOperationDeletion sends deletion requests to batch workflows.\n\
    \ Keep the parameter in sync with temporal.api.workflowservice.v1.DeleteWorkflowExecutionRequest.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXT\b\RS\n\
    \0\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXV\STX\SYN\SUB# The identity of the worker/client\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETXV\STX\b\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXV\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXV\DC4\NAK\n\
    \\171\SOH\n\
    \\STX\EOT\ENQ\DC2\EOT[\NULg\SOH\SUB\158\SOH BatchOperationReset sends reset requests to batch workflows.\n\
    \ Keep the parameter in sync with temporal.api.workflowservice.v1.ResetWorkflowExecutionRequest.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX[\b\ESC\n\
    \1\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX]\STX\SYN\SUB$ The identity of the worker/client.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETX]\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX]\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX]\DC4\NAK\n\
    \m\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETX`\STX2\SUB` Describes what to reset to and how. If set, `reset_type` and `reset_reapply_type` are ignored.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\ETX`\STX%\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETX`&-\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETX`01\n\
    \6\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\ETXc\STX1\SUB) Reset type (deprecated, use `options`).\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ACK\DC2\ETXc\STX!\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\ETXc\",\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\ETXc/0\n\
    \I\n\
    \\EOT\EOT\ENQ\STX\ETX\DC2\ETXe\STX@\SUB< History event reapply options (deprecated, use `options`).\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ACK\DC2\ETXe\STX(\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\SOH\DC2\ETXe);\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\ETX\ETX\DC2\ETXe>?b\ACKproto3"