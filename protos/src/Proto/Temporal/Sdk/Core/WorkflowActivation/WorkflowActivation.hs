{- This file was auto-generated from temporal/sdk/core/workflow_activation/workflow_activation.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation (
        CancelWorkflow(), FireTimer(), NotifyHasPatch(), QueryWorkflow(),
        QueryWorkflow'HeadersEntry(), RemoveFromCache(),
        RemoveFromCache'EvictionReason(..),
        RemoveFromCache'EvictionReason(),
        RemoveFromCache'EvictionReason'UnrecognizedValue,
        ResolveActivity(), ResolveChildWorkflowExecution(),
        ResolveChildWorkflowExecutionStart(),
        ResolveChildWorkflowExecutionStart'Status(..),
        _ResolveChildWorkflowExecutionStart'Succeeded,
        _ResolveChildWorkflowExecutionStart'Failed,
        _ResolveChildWorkflowExecutionStart'Cancelled,
        ResolveChildWorkflowExecutionStartCancelled(),
        ResolveChildWorkflowExecutionStartFailure(),
        ResolveChildWorkflowExecutionStartSuccess(),
        ResolveRequestCancelExternalWorkflow(),
        ResolveSignalExternalWorkflow(), SignalWorkflow(),
        SignalWorkflow'HeadersEntry(), StartWorkflow(),
        StartWorkflow'HeadersEntry(), UpdateRandomSeed(),
        WorkflowActivation(), WorkflowActivationJob(),
        WorkflowActivationJob'Variant(..),
        _WorkflowActivationJob'StartWorkflow,
        _WorkflowActivationJob'FireTimer,
        _WorkflowActivationJob'UpdateRandomSeed,
        _WorkflowActivationJob'QueryWorkflow,
        _WorkflowActivationJob'CancelWorkflow,
        _WorkflowActivationJob'SignalWorkflow,
        _WorkflowActivationJob'ResolveActivity,
        _WorkflowActivationJob'NotifyHasPatch,
        _WorkflowActivationJob'ResolveChildWorkflowExecutionStart,
        _WorkflowActivationJob'ResolveChildWorkflowExecution,
        _WorkflowActivationJob'ResolveSignalExternalWorkflow,
        _WorkflowActivationJob'ResolveRequestCancelExternalWorkflow,
        _WorkflowActivationJob'RemoveFromCache
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
import qualified Proto.Google.Protobuf.Duration
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Workflow
import qualified Proto.Temporal.Api.Failure.V1.Message
import qualified Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult
import qualified Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow
import qualified Proto.Temporal.Sdk.Core.Common.Common
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.details' @:: Lens' CancelWorkflow [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.vec'details' @:: Lens' CancelWorkflow (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data CancelWorkflow
  = CancelWorkflow'_constructor {_CancelWorkflow'details :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                                 _CancelWorkflow'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancelWorkflow where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField CancelWorkflow "details" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelWorkflow'details
           (\ x__ y__ -> x__ {_CancelWorkflow'details = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField CancelWorkflow "vec'details" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _CancelWorkflow'details
           (\ x__ y__ -> x__ {_CancelWorkflow'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message CancelWorkflow where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.CancelWorkflow"
  packedMessageDescriptor _
    = "\n\
      \\SOCancelWorkflow\DC29\n\
      \\adetails\CAN\SOH \ETX(\v2\US.temporal.api.common.v1.PayloadR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"details")) ::
              Data.ProtoLens.FieldDescriptor CancelWorkflow
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancelWorkflow'_unknownFields
        (\ x__ y__ -> x__ {_CancelWorkflow'_unknownFields = y__})
  defMessage
    = CancelWorkflow'_constructor
        {_CancelWorkflow'details = Data.Vector.Generic.empty,
         _CancelWorkflow'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancelWorkflow
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
             -> Data.ProtoLens.Encoding.Bytes.Parser CancelWorkflow
        loop x mutable'details
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'details <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'details)
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
                              (Data.ProtoLens.Field.field @"vec'details") frozen'details x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "details"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'details y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'details
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'details <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'details)
          "CancelWorkflow"
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
                (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'details") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData CancelWorkflow where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancelWorkflow'_unknownFields x__)
             (Control.DeepSeq.deepseq (_CancelWorkflow'details x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.seq' @:: Lens' FireTimer Data.Word.Word32@ -}
data FireTimer
  = FireTimer'_constructor {_FireTimer'seq :: !Data.Word.Word32,
                            _FireTimer'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show FireTimer where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField FireTimer "seq" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _FireTimer'seq (\ x__ y__ -> x__ {_FireTimer'seq = y__}))
        Prelude.id
instance Data.ProtoLens.Message FireTimer where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.FireTimer"
  packedMessageDescriptor _
    = "\n\
      \\tFireTimer\DC2\DLE\n\
      \\ETXseq\CAN\SOH \SOH(\rR\ETXseq"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        seq__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "seq"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"seq")) ::
              Data.ProtoLens.FieldDescriptor FireTimer
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, seq__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _FireTimer'_unknownFields
        (\ x__ y__ -> x__ {_FireTimer'_unknownFields = y__})
  defMessage
    = FireTimer'_constructor
        {_FireTimer'seq = Data.ProtoLens.fieldDefault,
         _FireTimer'_unknownFields = []}
  parseMessage
    = let
        loop :: FireTimer -> Data.ProtoLens.Encoding.Bytes.Parser FireTimer
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
                                       "seq"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"seq") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "FireTimer"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"seq") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData FireTimer where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_FireTimer'_unknownFields x__)
             (Control.DeepSeq.deepseq (_FireTimer'seq x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.patchId' @:: Lens' NotifyHasPatch Data.Text.Text@ -}
data NotifyHasPatch
  = NotifyHasPatch'_constructor {_NotifyHasPatch'patchId :: !Data.Text.Text,
                                 _NotifyHasPatch'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NotifyHasPatch where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NotifyHasPatch "patchId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NotifyHasPatch'patchId
           (\ x__ y__ -> x__ {_NotifyHasPatch'patchId = y__}))
        Prelude.id
instance Data.ProtoLens.Message NotifyHasPatch where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.NotifyHasPatch"
  packedMessageDescriptor _
    = "\n\
      \\SONotifyHasPatch\DC2\EM\n\
      \\bpatch_id\CAN\SOH \SOH(\tR\apatchId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        patchId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "patch_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"patchId")) ::
              Data.ProtoLens.FieldDescriptor NotifyHasPatch
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, patchId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NotifyHasPatch'_unknownFields
        (\ x__ y__ -> x__ {_NotifyHasPatch'_unknownFields = y__})
  defMessage
    = NotifyHasPatch'_constructor
        {_NotifyHasPatch'patchId = Data.ProtoLens.fieldDefault,
         _NotifyHasPatch'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NotifyHasPatch
          -> Data.ProtoLens.Encoding.Bytes.Parser NotifyHasPatch
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "patch_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"patchId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NotifyHasPatch"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"patchId") _x
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
instance Control.DeepSeq.NFData NotifyHasPatch where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NotifyHasPatch'_unknownFields x__)
             (Control.DeepSeq.deepseq (_NotifyHasPatch'patchId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.queryId' @:: Lens' QueryWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.queryType' @:: Lens' QueryWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.arguments' @:: Lens' QueryWorkflow [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.vec'arguments' @:: Lens' QueryWorkflow (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.headers' @:: Lens' QueryWorkflow (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data QueryWorkflow
  = QueryWorkflow'_constructor {_QueryWorkflow'queryId :: !Data.Text.Text,
                                _QueryWorkflow'queryType :: !Data.Text.Text,
                                _QueryWorkflow'arguments :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                                _QueryWorkflow'headers :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload),
                                _QueryWorkflow'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show QueryWorkflow where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField QueryWorkflow "queryId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'queryId
           (\ x__ y__ -> x__ {_QueryWorkflow'queryId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField QueryWorkflow "queryType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'queryType
           (\ x__ y__ -> x__ {_QueryWorkflow'queryType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField QueryWorkflow "arguments" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'arguments
           (\ x__ y__ -> x__ {_QueryWorkflow'arguments = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField QueryWorkflow "vec'arguments" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'arguments
           (\ x__ y__ -> x__ {_QueryWorkflow'arguments = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField QueryWorkflow "headers" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'headers
           (\ x__ y__ -> x__ {_QueryWorkflow'headers = y__}))
        Prelude.id
instance Data.ProtoLens.Message QueryWorkflow where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.QueryWorkflow"
  packedMessageDescriptor _
    = "\n\
      \\rQueryWorkflow\DC2\EM\n\
      \\bquery_id\CAN\SOH \SOH(\tR\aqueryId\DC2\GS\n\
      \\n\
      \query_type\CAN\STX \SOH(\tR\tqueryType\DC2=\n\
      \\targuments\CAN\ETX \ETX(\v2\US.temporal.api.common.v1.PayloadR\targuments\DC2Q\n\
      \\aheaders\CAN\ENQ \ETX(\v27.coresdk.workflow_activation.QueryWorkflow.HeadersEntryR\aheaders\SUB[\n\
      \\fHeadersEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        queryId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "query_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"queryId")) ::
              Data.ProtoLens.FieldDescriptor QueryWorkflow
        queryType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "query_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"queryType")) ::
              Data.ProtoLens.FieldDescriptor QueryWorkflow
        arguments__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "arguments"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"arguments")) ::
              Data.ProtoLens.FieldDescriptor QueryWorkflow
        headers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "headers"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor QueryWorkflow'HeadersEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"headers")) ::
              Data.ProtoLens.FieldDescriptor QueryWorkflow
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, queryId__field_descriptor),
           (Data.ProtoLens.Tag 2, queryType__field_descriptor),
           (Data.ProtoLens.Tag 3, arguments__field_descriptor),
           (Data.ProtoLens.Tag 5, headers__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _QueryWorkflow'_unknownFields
        (\ x__ y__ -> x__ {_QueryWorkflow'_unknownFields = y__})
  defMessage
    = QueryWorkflow'_constructor
        {_QueryWorkflow'queryId = Data.ProtoLens.fieldDefault,
         _QueryWorkflow'queryType = Data.ProtoLens.fieldDefault,
         _QueryWorkflow'arguments = Data.Vector.Generic.empty,
         _QueryWorkflow'headers = Data.Map.empty,
         _QueryWorkflow'_unknownFields = []}
  parseMessage
    = let
        loop ::
          QueryWorkflow
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
             -> Data.ProtoLens.Encoding.Bytes.Parser QueryWorkflow
        loop x mutable'arguments
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'arguments <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                               mutable'arguments)
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
                              (Data.ProtoLens.Field.field @"vec'arguments") frozen'arguments x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "query_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"queryId") y x)
                                  mutable'arguments
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "query_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"queryType") y x)
                                  mutable'arguments
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "arguments"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'arguments y)
                                loop x v
                        42
                          -> do !(entry :: QueryWorkflow'HeadersEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                            (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                Data.ProtoLens.Encoding.Bytes.isolate
                                                                                  (Prelude.fromIntegral
                                                                                     len)
                                                                                  Data.ProtoLens.parseMessage)
                                                                            "headers"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"headers")
                                        (\ !t -> Data.Map.insert key value t) x)
                                     mutable'arguments)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'arguments
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'arguments <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                     Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'arguments)
          "QueryWorkflow"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"queryId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"queryType") _x
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
                      (Lens.Family2.view
                         (Data.ProtoLens.Field.field @"vec'arguments") _x))
                   ((Data.Monoid.<>)
                      (Data.Monoid.mconcat
                         (Prelude.map
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.ProtoLens.encodeMessage
                                       (Lens.Family2.set
                                          (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                          (Lens.Family2.set
                                             (Data.ProtoLens.Field.field @"value") (Prelude.snd _v)
                                             (Data.ProtoLens.defMessage ::
                                                QueryWorkflow'HeadersEntry)))))
                            (Data.Map.toList
                               (Lens.Family2.view (Data.ProtoLens.Field.field @"headers") _x))))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData QueryWorkflow where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_QueryWorkflow'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_QueryWorkflow'queryId x__)
                (Control.DeepSeq.deepseq
                   (_QueryWorkflow'queryType x__)
                   (Control.DeepSeq.deepseq
                      (_QueryWorkflow'arguments x__)
                      (Control.DeepSeq.deepseq (_QueryWorkflow'headers x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.key' @:: Lens' QueryWorkflow'HeadersEntry Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.value' @:: Lens' QueryWorkflow'HeadersEntry Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'value' @:: Lens' QueryWorkflow'HeadersEntry (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data QueryWorkflow'HeadersEntry
  = QueryWorkflow'HeadersEntry'_constructor {_QueryWorkflow'HeadersEntry'key :: !Data.Text.Text,
                                             _QueryWorkflow'HeadersEntry'value :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                                             _QueryWorkflow'HeadersEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show QueryWorkflow'HeadersEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField QueryWorkflow'HeadersEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'HeadersEntry'key
           (\ x__ y__ -> x__ {_QueryWorkflow'HeadersEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField QueryWorkflow'HeadersEntry "value" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'HeadersEntry'value
           (\ x__ y__ -> x__ {_QueryWorkflow'HeadersEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField QueryWorkflow'HeadersEntry "maybe'value" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryWorkflow'HeadersEntry'value
           (\ x__ y__ -> x__ {_QueryWorkflow'HeadersEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message QueryWorkflow'HeadersEntry where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.QueryWorkflow.HeadersEntry"
  packedMessageDescriptor _
    = "\n\
      \\fHeadersEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor QueryWorkflow'HeadersEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor QueryWorkflow'HeadersEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _QueryWorkflow'HeadersEntry'_unknownFields
        (\ x__ y__
           -> x__ {_QueryWorkflow'HeadersEntry'_unknownFields = y__})
  defMessage
    = QueryWorkflow'HeadersEntry'_constructor
        {_QueryWorkflow'HeadersEntry'key = Data.ProtoLens.fieldDefault,
         _QueryWorkflow'HeadersEntry'value = Prelude.Nothing,
         _QueryWorkflow'HeadersEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          QueryWorkflow'HeadersEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser QueryWorkflow'HeadersEntry
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
          (do loop Data.ProtoLens.defMessage) "HeadersEntry"
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
instance Control.DeepSeq.NFData QueryWorkflow'HeadersEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_QueryWorkflow'HeadersEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_QueryWorkflow'HeadersEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_QueryWorkflow'HeadersEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.message' @:: Lens' RemoveFromCache Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.reason' @:: Lens' RemoveFromCache RemoveFromCache'EvictionReason@ -}
data RemoveFromCache
  = RemoveFromCache'_constructor {_RemoveFromCache'message :: !Data.Text.Text,
                                  _RemoveFromCache'reason :: !RemoveFromCache'EvictionReason,
                                  _RemoveFromCache'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show RemoveFromCache where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField RemoveFromCache "message" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RemoveFromCache'message
           (\ x__ y__ -> x__ {_RemoveFromCache'message = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField RemoveFromCache "reason" RemoveFromCache'EvictionReason where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _RemoveFromCache'reason
           (\ x__ y__ -> x__ {_RemoveFromCache'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Message RemoveFromCache where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.RemoveFromCache"
  packedMessageDescriptor _
    = "\n\
      \\SIRemoveFromCache\DC2\CAN\n\
      \\amessage\CAN\SOH \SOH(\tR\amessage\DC2S\n\
      \\ACKreason\CAN\STX \SOH(\SO2;.coresdk.workflow_activation.RemoveFromCache.EvictionReasonR\ACKreason\"\207\SOH\n\
      \\SOEvictionReason\DC2\SI\n\
      \\vUNSPECIFIED\DLE\NUL\DC2\SO\n\
      \\n\
      \CACHE_FULL\DLE\SOH\DC2\SO\n\
      \\n\
      \CACHE_MISS\DLE\STX\DC2\DC2\n\
      \\SONONDETERMINISM\DLE\ETX\DC2\r\n\
      \\tLANG_FAIL\DLE\EOT\DC2\DC2\n\
      \\SOLANG_REQUESTED\DLE\ENQ\DC2\DC2\n\
      \\SOTASK_NOT_FOUND\DLE\ACK\DC2\NAK\n\
      \\DC1UNHANDLED_COMMAND\DLE\a\DC2\t\n\
      \\ENQFATAL\DLE\b\DC2\US\n\
      \\ESCPAGINATION_OR_HISTORY_FETCH\DLE\t"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        message__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "message"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"message")) ::
              Data.ProtoLens.FieldDescriptor RemoveFromCache
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor RemoveFromCache'EvictionReason)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor RemoveFromCache
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, message__field_descriptor),
           (Data.ProtoLens.Tag 2, reason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _RemoveFromCache'_unknownFields
        (\ x__ y__ -> x__ {_RemoveFromCache'_unknownFields = y__})
  defMessage
    = RemoveFromCache'_constructor
        {_RemoveFromCache'message = Data.ProtoLens.fieldDefault,
         _RemoveFromCache'reason = Data.ProtoLens.fieldDefault,
         _RemoveFromCache'_unknownFields = []}
  parseMessage
    = let
        loop ::
          RemoveFromCache
          -> Data.ProtoLens.Encoding.Bytes.Parser RemoveFromCache
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "message"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"message") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "reason"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"reason") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "RemoveFromCache"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"message") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"reason") _x
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
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData RemoveFromCache where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_RemoveFromCache'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_RemoveFromCache'message x__)
                (Control.DeepSeq.deepseq (_RemoveFromCache'reason x__) ()))
newtype RemoveFromCache'EvictionReason'UnrecognizedValue
  = RemoveFromCache'EvictionReason'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data RemoveFromCache'EvictionReason
  = RemoveFromCache'UNSPECIFIED |
    RemoveFromCache'CACHE_FULL |
    RemoveFromCache'CACHE_MISS |
    RemoveFromCache'NONDETERMINISM |
    RemoveFromCache'LANG_FAIL |
    RemoveFromCache'LANG_REQUESTED |
    RemoveFromCache'TASK_NOT_FOUND |
    RemoveFromCache'UNHANDLED_COMMAND |
    RemoveFromCache'FATAL |
    RemoveFromCache'PAGINATION_OR_HISTORY_FETCH |
    RemoveFromCache'EvictionReason'Unrecognized !RemoveFromCache'EvictionReason'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum RemoveFromCache'EvictionReason where
  maybeToEnum 0 = Prelude.Just RemoveFromCache'UNSPECIFIED
  maybeToEnum 1 = Prelude.Just RemoveFromCache'CACHE_FULL
  maybeToEnum 2 = Prelude.Just RemoveFromCache'CACHE_MISS
  maybeToEnum 3 = Prelude.Just RemoveFromCache'NONDETERMINISM
  maybeToEnum 4 = Prelude.Just RemoveFromCache'LANG_FAIL
  maybeToEnum 5 = Prelude.Just RemoveFromCache'LANG_REQUESTED
  maybeToEnum 6 = Prelude.Just RemoveFromCache'TASK_NOT_FOUND
  maybeToEnum 7 = Prelude.Just RemoveFromCache'UNHANDLED_COMMAND
  maybeToEnum 8 = Prelude.Just RemoveFromCache'FATAL
  maybeToEnum 9
    = Prelude.Just RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
  maybeToEnum k
    = Prelude.Just
        (RemoveFromCache'EvictionReason'Unrecognized
           (RemoveFromCache'EvictionReason'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum RemoveFromCache'UNSPECIFIED = "UNSPECIFIED"
  showEnum RemoveFromCache'CACHE_FULL = "CACHE_FULL"
  showEnum RemoveFromCache'CACHE_MISS = "CACHE_MISS"
  showEnum RemoveFromCache'NONDETERMINISM = "NONDETERMINISM"
  showEnum RemoveFromCache'LANG_FAIL = "LANG_FAIL"
  showEnum RemoveFromCache'LANG_REQUESTED = "LANG_REQUESTED"
  showEnum RemoveFromCache'TASK_NOT_FOUND = "TASK_NOT_FOUND"
  showEnum RemoveFromCache'UNHANDLED_COMMAND = "UNHANDLED_COMMAND"
  showEnum RemoveFromCache'FATAL = "FATAL"
  showEnum RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
    = "PAGINATION_OR_HISTORY_FETCH"
  showEnum
    (RemoveFromCache'EvictionReason'Unrecognized (RemoveFromCache'EvictionReason'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "UNSPECIFIED"
    = Prelude.Just RemoveFromCache'UNSPECIFIED
    | (Prelude.==) k "CACHE_FULL"
    = Prelude.Just RemoveFromCache'CACHE_FULL
    | (Prelude.==) k "CACHE_MISS"
    = Prelude.Just RemoveFromCache'CACHE_MISS
    | (Prelude.==) k "NONDETERMINISM"
    = Prelude.Just RemoveFromCache'NONDETERMINISM
    | (Prelude.==) k "LANG_FAIL"
    = Prelude.Just RemoveFromCache'LANG_FAIL
    | (Prelude.==) k "LANG_REQUESTED"
    = Prelude.Just RemoveFromCache'LANG_REQUESTED
    | (Prelude.==) k "TASK_NOT_FOUND"
    = Prelude.Just RemoveFromCache'TASK_NOT_FOUND
    | (Prelude.==) k "UNHANDLED_COMMAND"
    = Prelude.Just RemoveFromCache'UNHANDLED_COMMAND
    | (Prelude.==) k "FATAL" = Prelude.Just RemoveFromCache'FATAL
    | (Prelude.==) k "PAGINATION_OR_HISTORY_FETCH"
    = Prelude.Just RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded RemoveFromCache'EvictionReason where
  minBound = RemoveFromCache'UNSPECIFIED
  maxBound = RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
instance Prelude.Enum RemoveFromCache'EvictionReason where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum EvictionReason: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum RemoveFromCache'UNSPECIFIED = 0
  fromEnum RemoveFromCache'CACHE_FULL = 1
  fromEnum RemoveFromCache'CACHE_MISS = 2
  fromEnum RemoveFromCache'NONDETERMINISM = 3
  fromEnum RemoveFromCache'LANG_FAIL = 4
  fromEnum RemoveFromCache'LANG_REQUESTED = 5
  fromEnum RemoveFromCache'TASK_NOT_FOUND = 6
  fromEnum RemoveFromCache'UNHANDLED_COMMAND = 7
  fromEnum RemoveFromCache'FATAL = 8
  fromEnum RemoveFromCache'PAGINATION_OR_HISTORY_FETCH = 9
  fromEnum
    (RemoveFromCache'EvictionReason'Unrecognized (RemoveFromCache'EvictionReason'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
    = Prelude.error
        "RemoveFromCache'EvictionReason.succ: bad argument RemoveFromCache'PAGINATION_OR_HISTORY_FETCH. This value would be out of bounds."
  succ RemoveFromCache'UNSPECIFIED = RemoveFromCache'CACHE_FULL
  succ RemoveFromCache'CACHE_FULL = RemoveFromCache'CACHE_MISS
  succ RemoveFromCache'CACHE_MISS = RemoveFromCache'NONDETERMINISM
  succ RemoveFromCache'NONDETERMINISM = RemoveFromCache'LANG_FAIL
  succ RemoveFromCache'LANG_FAIL = RemoveFromCache'LANG_REQUESTED
  succ RemoveFromCache'LANG_REQUESTED
    = RemoveFromCache'TASK_NOT_FOUND
  succ RemoveFromCache'TASK_NOT_FOUND
    = RemoveFromCache'UNHANDLED_COMMAND
  succ RemoveFromCache'UNHANDLED_COMMAND = RemoveFromCache'FATAL
  succ RemoveFromCache'FATAL
    = RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
  succ (RemoveFromCache'EvictionReason'Unrecognized _)
    = Prelude.error
        "RemoveFromCache'EvictionReason.succ: bad argument: unrecognized value"
  pred RemoveFromCache'UNSPECIFIED
    = Prelude.error
        "RemoveFromCache'EvictionReason.pred: bad argument RemoveFromCache'UNSPECIFIED. This value would be out of bounds."
  pred RemoveFromCache'CACHE_FULL = RemoveFromCache'UNSPECIFIED
  pred RemoveFromCache'CACHE_MISS = RemoveFromCache'CACHE_FULL
  pred RemoveFromCache'NONDETERMINISM = RemoveFromCache'CACHE_MISS
  pred RemoveFromCache'LANG_FAIL = RemoveFromCache'NONDETERMINISM
  pred RemoveFromCache'LANG_REQUESTED = RemoveFromCache'LANG_FAIL
  pred RemoveFromCache'TASK_NOT_FOUND
    = RemoveFromCache'LANG_REQUESTED
  pred RemoveFromCache'UNHANDLED_COMMAND
    = RemoveFromCache'TASK_NOT_FOUND
  pred RemoveFromCache'FATAL = RemoveFromCache'UNHANDLED_COMMAND
  pred RemoveFromCache'PAGINATION_OR_HISTORY_FETCH
    = RemoveFromCache'FATAL
  pred (RemoveFromCache'EvictionReason'Unrecognized _)
    = Prelude.error
        "RemoveFromCache'EvictionReason.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault RemoveFromCache'EvictionReason where
  fieldDefault = RemoveFromCache'UNSPECIFIED
instance Control.DeepSeq.NFData RemoveFromCache'EvictionReason where
  rnf x__ = Prelude.seq x__ ()
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.seq' @:: Lens' ResolveActivity Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.result' @:: Lens' ResolveActivity Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityResolution@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'result' @:: Lens' ResolveActivity (Prelude.Maybe Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityResolution)@ -}
data ResolveActivity
  = ResolveActivity'_constructor {_ResolveActivity'seq :: !Data.Word.Word32,
                                  _ResolveActivity'result :: !(Prelude.Maybe Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityResolution),
                                  _ResolveActivity'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveActivity where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveActivity "seq" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveActivity'seq
           (\ x__ y__ -> x__ {_ResolveActivity'seq = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveActivity "result" Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityResolution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveActivity'result
           (\ x__ y__ -> x__ {_ResolveActivity'result = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResolveActivity "maybe'result" (Prelude.Maybe Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityResolution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveActivity'result
           (\ x__ y__ -> x__ {_ResolveActivity'result = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveActivity where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.ResolveActivity"
  packedMessageDescriptor _
    = "\n\
      \\SIResolveActivity\DC2\DLE\n\
      \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2C\n\
      \\ACKresult\CAN\STX \SOH(\v2+.coresdk.activity_result.ActivityResolutionR\ACKresult"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        seq__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "seq"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"seq")) ::
              Data.ProtoLens.FieldDescriptor ResolveActivity
        result__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "result"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Sdk.Core.ActivityResult.ActivityResult.ActivityResolution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'result")) ::
              Data.ProtoLens.FieldDescriptor ResolveActivity
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, seq__field_descriptor),
           (Data.ProtoLens.Tag 2, result__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveActivity'_unknownFields
        (\ x__ y__ -> x__ {_ResolveActivity'_unknownFields = y__})
  defMessage
    = ResolveActivity'_constructor
        {_ResolveActivity'seq = Data.ProtoLens.fieldDefault,
         _ResolveActivity'result = Prelude.Nothing,
         _ResolveActivity'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveActivity
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveActivity
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
                                       "seq"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"seq") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "result"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"result") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ResolveActivity"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"seq") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'result") _x
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
instance Control.DeepSeq.NFData ResolveActivity where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveActivity'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveActivity'seq x__)
                (Control.DeepSeq.deepseq (_ResolveActivity'result x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.seq' @:: Lens' ResolveChildWorkflowExecution Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.result' @:: Lens' ResolveChildWorkflowExecution Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.ChildWorkflowResult@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'result' @:: Lens' ResolveChildWorkflowExecution (Prelude.Maybe Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.ChildWorkflowResult)@ -}
data ResolveChildWorkflowExecution
  = ResolveChildWorkflowExecution'_constructor {_ResolveChildWorkflowExecution'seq :: !Data.Word.Word32,
                                                _ResolveChildWorkflowExecution'result :: !(Prelude.Maybe Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.ChildWorkflowResult),
                                                _ResolveChildWorkflowExecution'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveChildWorkflowExecution where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecution "seq" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecution'seq
           (\ x__ y__ -> x__ {_ResolveChildWorkflowExecution'seq = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecution "result" Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.ChildWorkflowResult where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecution'result
           (\ x__ y__ -> x__ {_ResolveChildWorkflowExecution'result = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecution "maybe'result" (Prelude.Maybe Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.ChildWorkflowResult) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecution'result
           (\ x__ y__ -> x__ {_ResolveChildWorkflowExecution'result = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveChildWorkflowExecution where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveChildWorkflowExecution"
  packedMessageDescriptor _
    = "\n\
      \\GSResolveChildWorkflowExecution\DC2\DLE\n\
      \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2C\n\
      \\ACKresult\CAN\STX \SOH(\v2+.coresdk.child_workflow.ChildWorkflowResultR\ACKresult"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        seq__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "seq"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"seq")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecution
        result__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "result"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.ChildWorkflowResult)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'result")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecution
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, seq__field_descriptor),
           (Data.ProtoLens.Tag 2, result__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveChildWorkflowExecution'_unknownFields
        (\ x__ y__
           -> x__ {_ResolveChildWorkflowExecution'_unknownFields = y__})
  defMessage
    = ResolveChildWorkflowExecution'_constructor
        {_ResolveChildWorkflowExecution'seq = Data.ProtoLens.fieldDefault,
         _ResolveChildWorkflowExecution'result = Prelude.Nothing,
         _ResolveChildWorkflowExecution'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveChildWorkflowExecution
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveChildWorkflowExecution
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
                                       "seq"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"seq") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "result"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"result") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ResolveChildWorkflowExecution"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"seq") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'result") _x
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
instance Control.DeepSeq.NFData ResolveChildWorkflowExecution where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveChildWorkflowExecution'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveChildWorkflowExecution'seq x__)
                (Control.DeepSeq.deepseq
                   (_ResolveChildWorkflowExecution'result x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.seq' @:: Lens' ResolveChildWorkflowExecutionStart Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'status' @:: Lens' ResolveChildWorkflowExecutionStart (Prelude.Maybe ResolveChildWorkflowExecutionStart'Status)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'succeeded' @:: Lens' ResolveChildWorkflowExecutionStart (Prelude.Maybe ResolveChildWorkflowExecutionStartSuccess)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.succeeded' @:: Lens' ResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStartSuccess@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'failed' @:: Lens' ResolveChildWorkflowExecutionStart (Prelude.Maybe ResolveChildWorkflowExecutionStartFailure)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.failed' @:: Lens' ResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStartFailure@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'cancelled' @:: Lens' ResolveChildWorkflowExecutionStart (Prelude.Maybe ResolveChildWorkflowExecutionStartCancelled)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.cancelled' @:: Lens' ResolveChildWorkflowExecutionStart ResolveChildWorkflowExecutionStartCancelled@ -}
data ResolveChildWorkflowExecutionStart
  = ResolveChildWorkflowExecutionStart'_constructor {_ResolveChildWorkflowExecutionStart'seq :: !Data.Word.Word32,
                                                     _ResolveChildWorkflowExecutionStart'status :: !(Prelude.Maybe ResolveChildWorkflowExecutionStart'Status),
                                                     _ResolveChildWorkflowExecutionStart'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveChildWorkflowExecutionStart where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data ResolveChildWorkflowExecutionStart'Status
  = ResolveChildWorkflowExecutionStart'Succeeded !ResolveChildWorkflowExecutionStartSuccess |
    ResolveChildWorkflowExecutionStart'Failed !ResolveChildWorkflowExecutionStartFailure |
    ResolveChildWorkflowExecutionStart'Cancelled !ResolveChildWorkflowExecutionStartCancelled
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "seq" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'seq
           (\ x__ y__ -> x__ {_ResolveChildWorkflowExecutionStart'seq = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "maybe'status" (Prelude.Maybe ResolveChildWorkflowExecutionStart'Status) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "maybe'succeeded" (Prelude.Maybe ResolveChildWorkflowExecutionStartSuccess) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResolveChildWorkflowExecutionStart'Succeeded x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap ResolveChildWorkflowExecutionStart'Succeeded y__))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "succeeded" ResolveChildWorkflowExecutionStartSuccess where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResolveChildWorkflowExecutionStart'Succeeded x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap ResolveChildWorkflowExecutionStart'Succeeded y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "maybe'failed" (Prelude.Maybe ResolveChildWorkflowExecutionStartFailure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResolveChildWorkflowExecutionStart'Failed x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap ResolveChildWorkflowExecutionStart'Failed y__))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "failed" ResolveChildWorkflowExecutionStartFailure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResolveChildWorkflowExecutionStart'Failed x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap ResolveChildWorkflowExecutionStart'Failed y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "maybe'cancelled" (Prelude.Maybe ResolveChildWorkflowExecutionStartCancelled) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (ResolveChildWorkflowExecutionStart'Cancelled x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap ResolveChildWorkflowExecutionStart'Cancelled y__))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStart "cancelled" ResolveChildWorkflowExecutionStartCancelled where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStart'status
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStart'status = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (ResolveChildWorkflowExecutionStart'Cancelled x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap ResolveChildWorkflowExecutionStart'Cancelled y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message ResolveChildWorkflowExecutionStart where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveChildWorkflowExecutionStart"
  packedMessageDescriptor _
    = "\n\
      \\"ResolveChildWorkflowExecutionStart\DC2\DLE\n\
      \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2f\n\
      \\tsucceeded\CAN\STX \SOH(\v2F.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartSuccessH\NULR\tsucceeded\DC2`\n\
      \\ACKfailed\CAN\ETX \SOH(\v2F.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartFailureH\NULR\ACKfailed\DC2h\n\
      \\tcancelled\CAN\EOT \SOH(\v2H.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartCancelledH\NULR\tcancelledB\b\n\
      \\ACKstatus"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        seq__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "seq"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"seq")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStart
        succeeded__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "succeeded"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveChildWorkflowExecutionStartSuccess)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'succeeded")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStart
        failed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failed"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveChildWorkflowExecutionStartFailure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failed")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStart
        cancelled__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancelled"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveChildWorkflowExecutionStartCancelled)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancelled")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStart
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, seq__field_descriptor),
           (Data.ProtoLens.Tag 2, succeeded__field_descriptor),
           (Data.ProtoLens.Tag 3, failed__field_descriptor),
           (Data.ProtoLens.Tag 4, cancelled__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveChildWorkflowExecutionStart'_unknownFields
        (\ x__ y__
           -> x__ {_ResolveChildWorkflowExecutionStart'_unknownFields = y__})
  defMessage
    = ResolveChildWorkflowExecutionStart'_constructor
        {_ResolveChildWorkflowExecutionStart'seq = Data.ProtoLens.fieldDefault,
         _ResolveChildWorkflowExecutionStart'status = Prelude.Nothing,
         _ResolveChildWorkflowExecutionStart'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveChildWorkflowExecutionStart
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveChildWorkflowExecutionStart
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
                                       "seq"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"seq") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "succeeded"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"succeeded") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "failed"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failed") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancelled"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"cancelled") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ResolveChildWorkflowExecutionStart"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"seq") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'status") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (ResolveChildWorkflowExecutionStart'Succeeded v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (ResolveChildWorkflowExecutionStart'Failed v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (ResolveChildWorkflowExecutionStart'Cancelled v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData ResolveChildWorkflowExecutionStart where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveChildWorkflowExecutionStart'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveChildWorkflowExecutionStart'seq x__)
                (Control.DeepSeq.deepseq
                   (_ResolveChildWorkflowExecutionStart'status x__) ()))
instance Control.DeepSeq.NFData ResolveChildWorkflowExecutionStart'Status where
  rnf (ResolveChildWorkflowExecutionStart'Succeeded x__)
    = Control.DeepSeq.rnf x__
  rnf (ResolveChildWorkflowExecutionStart'Failed x__)
    = Control.DeepSeq.rnf x__
  rnf (ResolveChildWorkflowExecutionStart'Cancelled x__)
    = Control.DeepSeq.rnf x__
_ResolveChildWorkflowExecutionStart'Succeeded ::
  Data.ProtoLens.Prism.Prism' ResolveChildWorkflowExecutionStart'Status ResolveChildWorkflowExecutionStartSuccess
_ResolveChildWorkflowExecutionStart'Succeeded
  = Data.ProtoLens.Prism.prism'
      ResolveChildWorkflowExecutionStart'Succeeded
      (\ p__
         -> case p__ of
              (ResolveChildWorkflowExecutionStart'Succeeded p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_ResolveChildWorkflowExecutionStart'Failed ::
  Data.ProtoLens.Prism.Prism' ResolveChildWorkflowExecutionStart'Status ResolveChildWorkflowExecutionStartFailure
_ResolveChildWorkflowExecutionStart'Failed
  = Data.ProtoLens.Prism.prism'
      ResolveChildWorkflowExecutionStart'Failed
      (\ p__
         -> case p__ of
              (ResolveChildWorkflowExecutionStart'Failed p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_ResolveChildWorkflowExecutionStart'Cancelled ::
  Data.ProtoLens.Prism.Prism' ResolveChildWorkflowExecutionStart'Status ResolveChildWorkflowExecutionStartCancelled
_ResolveChildWorkflowExecutionStart'Cancelled
  = Data.ProtoLens.Prism.prism'
      ResolveChildWorkflowExecutionStart'Cancelled
      (\ p__
         -> case p__ of
              (ResolveChildWorkflowExecutionStart'Cancelled p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.failure' @:: Lens' ResolveChildWorkflowExecutionStartCancelled Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'failure' @:: Lens' ResolveChildWorkflowExecutionStartCancelled (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@ -}
data ResolveChildWorkflowExecutionStartCancelled
  = ResolveChildWorkflowExecutionStartCancelled'_constructor {_ResolveChildWorkflowExecutionStartCancelled'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                              _ResolveChildWorkflowExecutionStartCancelled'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveChildWorkflowExecutionStartCancelled where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStartCancelled "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStartCancelled'failure
           (\ x__ y__
              -> x__
                   {_ResolveChildWorkflowExecutionStartCancelled'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStartCancelled "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStartCancelled'failure
           (\ x__ y__
              -> x__
                   {_ResolveChildWorkflowExecutionStartCancelled'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveChildWorkflowExecutionStartCancelled where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveChildWorkflowExecutionStartCancelled"
  packedMessageDescriptor _
    = "\n\
      \+ResolveChildWorkflowExecutionStartCancelled\DC2:\n\
      \\afailure\CAN\SOH \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStartCancelled
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveChildWorkflowExecutionStartCancelled'_unknownFields
        (\ x__ y__
           -> x__
                {_ResolveChildWorkflowExecutionStartCancelled'_unknownFields = y__})
  defMessage
    = ResolveChildWorkflowExecutionStartCancelled'_constructor
        {_ResolveChildWorkflowExecutionStartCancelled'failure = Prelude.Nothing,
         _ResolveChildWorkflowExecutionStartCancelled'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveChildWorkflowExecutionStartCancelled
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveChildWorkflowExecutionStartCancelled
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
                                       "failure"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failure") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ResolveChildWorkflowExecutionStartCancelled"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
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
instance Control.DeepSeq.NFData ResolveChildWorkflowExecutionStartCancelled where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveChildWorkflowExecutionStartCancelled'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveChildWorkflowExecutionStartCancelled'failure x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowId' @:: Lens' ResolveChildWorkflowExecutionStartFailure Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowType' @:: Lens' ResolveChildWorkflowExecutionStartFailure Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.cause' @:: Lens' ResolveChildWorkflowExecutionStartFailure Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.StartChildWorkflowExecutionFailedCause@ -}
data ResolveChildWorkflowExecutionStartFailure
  = ResolveChildWorkflowExecutionStartFailure'_constructor {_ResolveChildWorkflowExecutionStartFailure'workflowId :: !Data.Text.Text,
                                                            _ResolveChildWorkflowExecutionStartFailure'workflowType :: !Data.Text.Text,
                                                            _ResolveChildWorkflowExecutionStartFailure'cause :: !Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.StartChildWorkflowExecutionFailedCause,
                                                            _ResolveChildWorkflowExecutionStartFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveChildWorkflowExecutionStartFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStartFailure "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStartFailure'workflowId
           (\ x__ y__
              -> x__
                   {_ResolveChildWorkflowExecutionStartFailure'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStartFailure "workflowType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStartFailure'workflowType
           (\ x__ y__
              -> x__
                   {_ResolveChildWorkflowExecutionStartFailure'workflowType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStartFailure "cause" Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.StartChildWorkflowExecutionFailedCause where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStartFailure'cause
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStartFailure'cause = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveChildWorkflowExecutionStartFailure where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveChildWorkflowExecutionStartFailure"
  packedMessageDescriptor _
    = "\n\
      \)ResolveChildWorkflowExecutionStartFailure\DC2\US\n\
      \\vworkflow_id\CAN\SOH \SOH(\tR\n\
      \workflowId\DC2#\n\
      \\rworkflow_type\CAN\STX \SOH(\tR\fworkflowType\DC2T\n\
      \\ENQcause\CAN\ETX \SOH(\SO2>.coresdk.child_workflow.StartChildWorkflowExecutionFailedCauseR\ENQcause"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStartFailure
        workflowType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowType")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStartFailure
        cause__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cause"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Sdk.Core.ChildWorkflow.ChildWorkflow.StartChildWorkflowExecutionFailedCause)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"cause")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStartFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowType__field_descriptor),
           (Data.ProtoLens.Tag 3, cause__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveChildWorkflowExecutionStartFailure'_unknownFields
        (\ x__ y__
           -> x__
                {_ResolveChildWorkflowExecutionStartFailure'_unknownFields = y__})
  defMessage
    = ResolveChildWorkflowExecutionStartFailure'_constructor
        {_ResolveChildWorkflowExecutionStartFailure'workflowId = Data.ProtoLens.fieldDefault,
         _ResolveChildWorkflowExecutionStartFailure'workflowType = Data.ProtoLens.fieldDefault,
         _ResolveChildWorkflowExecutionStartFailure'cause = Data.ProtoLens.fieldDefault,
         _ResolveChildWorkflowExecutionStartFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveChildWorkflowExecutionStartFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveChildWorkflowExecutionStartFailure
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "workflow_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"workflowId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "workflow_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowType") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "cause"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"cause") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ResolveChildWorkflowExecutionStartFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowId") _x
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
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowType") _x
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
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"cause") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                               Prelude.fromEnum _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData ResolveChildWorkflowExecutionStartFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveChildWorkflowExecutionStartFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveChildWorkflowExecutionStartFailure'workflowId x__)
                (Control.DeepSeq.deepseq
                   (_ResolveChildWorkflowExecutionStartFailure'workflowType x__)
                   (Control.DeepSeq.deepseq
                      (_ResolveChildWorkflowExecutionStartFailure'cause x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.runId' @:: Lens' ResolveChildWorkflowExecutionStartSuccess Data.Text.Text@ -}
data ResolveChildWorkflowExecutionStartSuccess
  = ResolveChildWorkflowExecutionStartSuccess'_constructor {_ResolveChildWorkflowExecutionStartSuccess'runId :: !Data.Text.Text,
                                                            _ResolveChildWorkflowExecutionStartSuccess'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveChildWorkflowExecutionStartSuccess where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveChildWorkflowExecutionStartSuccess "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveChildWorkflowExecutionStartSuccess'runId
           (\ x__ y__
              -> x__ {_ResolveChildWorkflowExecutionStartSuccess'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveChildWorkflowExecutionStartSuccess where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveChildWorkflowExecutionStartSuccess"
  packedMessageDescriptor _
    = "\n\
      \)ResolveChildWorkflowExecutionStartSuccess\DC2\NAK\n\
      \\ACKrun_id\CAN\SOH \SOH(\tR\ENQrunId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor ResolveChildWorkflowExecutionStartSuccess
      in
        Data.Map.fromList [(Data.ProtoLens.Tag 1, runId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveChildWorkflowExecutionStartSuccess'_unknownFields
        (\ x__ y__
           -> x__
                {_ResolveChildWorkflowExecutionStartSuccess'_unknownFields = y__})
  defMessage
    = ResolveChildWorkflowExecutionStartSuccess'_constructor
        {_ResolveChildWorkflowExecutionStartSuccess'runId = Data.ProtoLens.fieldDefault,
         _ResolveChildWorkflowExecutionStartSuccess'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveChildWorkflowExecutionStartSuccess
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveChildWorkflowExecutionStartSuccess
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "run_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"runId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ResolveChildWorkflowExecutionStartSuccess"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"runId") _x
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
instance Control.DeepSeq.NFData ResolveChildWorkflowExecutionStartSuccess where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveChildWorkflowExecutionStartSuccess'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveChildWorkflowExecutionStartSuccess'runId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.seq' @:: Lens' ResolveRequestCancelExternalWorkflow Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.failure' @:: Lens' ResolveRequestCancelExternalWorkflow Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'failure' @:: Lens' ResolveRequestCancelExternalWorkflow (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@ -}
data ResolveRequestCancelExternalWorkflow
  = ResolveRequestCancelExternalWorkflow'_constructor {_ResolveRequestCancelExternalWorkflow'seq :: !Data.Word.Word32,
                                                       _ResolveRequestCancelExternalWorkflow'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                       _ResolveRequestCancelExternalWorkflow'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveRequestCancelExternalWorkflow where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveRequestCancelExternalWorkflow "seq" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveRequestCancelExternalWorkflow'seq
           (\ x__ y__
              -> x__ {_ResolveRequestCancelExternalWorkflow'seq = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveRequestCancelExternalWorkflow "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveRequestCancelExternalWorkflow'failure
           (\ x__ y__
              -> x__ {_ResolveRequestCancelExternalWorkflow'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResolveRequestCancelExternalWorkflow "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveRequestCancelExternalWorkflow'failure
           (\ x__ y__
              -> x__ {_ResolveRequestCancelExternalWorkflow'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveRequestCancelExternalWorkflow where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveRequestCancelExternalWorkflow"
  packedMessageDescriptor _
    = "\n\
      \$ResolveRequestCancelExternalWorkflow\DC2\DLE\n\
      \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2:\n\
      \\afailure\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        seq__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "seq"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"seq")) ::
              Data.ProtoLens.FieldDescriptor ResolveRequestCancelExternalWorkflow
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor ResolveRequestCancelExternalWorkflow
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, seq__field_descriptor),
           (Data.ProtoLens.Tag 2, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveRequestCancelExternalWorkflow'_unknownFields
        (\ x__ y__
           -> x__
                {_ResolveRequestCancelExternalWorkflow'_unknownFields = y__})
  defMessage
    = ResolveRequestCancelExternalWorkflow'_constructor
        {_ResolveRequestCancelExternalWorkflow'seq = Data.ProtoLens.fieldDefault,
         _ResolveRequestCancelExternalWorkflow'failure = Prelude.Nothing,
         _ResolveRequestCancelExternalWorkflow'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveRequestCancelExternalWorkflow
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveRequestCancelExternalWorkflow
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
                                       "seq"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"seq") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "failure"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failure") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ResolveRequestCancelExternalWorkflow"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"seq") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
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
instance Control.DeepSeq.NFData ResolveRequestCancelExternalWorkflow where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveRequestCancelExternalWorkflow'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveRequestCancelExternalWorkflow'seq x__)
                (Control.DeepSeq.deepseq
                   (_ResolveRequestCancelExternalWorkflow'failure x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.seq' @:: Lens' ResolveSignalExternalWorkflow Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.failure' @:: Lens' ResolveSignalExternalWorkflow Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'failure' @:: Lens' ResolveSignalExternalWorkflow (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@ -}
data ResolveSignalExternalWorkflow
  = ResolveSignalExternalWorkflow'_constructor {_ResolveSignalExternalWorkflow'seq :: !Data.Word.Word32,
                                                _ResolveSignalExternalWorkflow'failure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                                _ResolveSignalExternalWorkflow'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResolveSignalExternalWorkflow where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResolveSignalExternalWorkflow "seq" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveSignalExternalWorkflow'seq
           (\ x__ y__ -> x__ {_ResolveSignalExternalWorkflow'seq = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResolveSignalExternalWorkflow "failure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveSignalExternalWorkflow'failure
           (\ x__ y__ -> x__ {_ResolveSignalExternalWorkflow'failure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ResolveSignalExternalWorkflow "maybe'failure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResolveSignalExternalWorkflow'failure
           (\ x__ y__ -> x__ {_ResolveSignalExternalWorkflow'failure = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResolveSignalExternalWorkflow where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.ResolveSignalExternalWorkflow"
  packedMessageDescriptor _
    = "\n\
      \\GSResolveSignalExternalWorkflow\DC2\DLE\n\
      \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2:\n\
      \\afailure\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        seq__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "seq"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"seq")) ::
              Data.ProtoLens.FieldDescriptor ResolveSignalExternalWorkflow
        failure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'failure")) ::
              Data.ProtoLens.FieldDescriptor ResolveSignalExternalWorkflow
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, seq__field_descriptor),
           (Data.ProtoLens.Tag 2, failure__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResolveSignalExternalWorkflow'_unknownFields
        (\ x__ y__
           -> x__ {_ResolveSignalExternalWorkflow'_unknownFields = y__})
  defMessage
    = ResolveSignalExternalWorkflow'_constructor
        {_ResolveSignalExternalWorkflow'seq = Data.ProtoLens.fieldDefault,
         _ResolveSignalExternalWorkflow'failure = Prelude.Nothing,
         _ResolveSignalExternalWorkflow'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResolveSignalExternalWorkflow
          -> Data.ProtoLens.Encoding.Bytes.Parser ResolveSignalExternalWorkflow
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
                                       "seq"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"seq") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "failure"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"failure") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ResolveSignalExternalWorkflow"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"seq") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'failure") _x
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
instance Control.DeepSeq.NFData ResolveSignalExternalWorkflow where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResolveSignalExternalWorkflow'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResolveSignalExternalWorkflow'seq x__)
                (Control.DeepSeq.deepseq
                   (_ResolveSignalExternalWorkflow'failure x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.signalName' @:: Lens' SignalWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.input' @:: Lens' SignalWorkflow [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.vec'input' @:: Lens' SignalWorkflow (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.identity' @:: Lens' SignalWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.headers' @:: Lens' SignalWorkflow (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data SignalWorkflow
  = SignalWorkflow'_constructor {_SignalWorkflow'signalName :: !Data.Text.Text,
                                 _SignalWorkflow'input :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                                 _SignalWorkflow'identity :: !Data.Text.Text,
                                 _SignalWorkflow'headers :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload),
                                 _SignalWorkflow'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SignalWorkflow where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SignalWorkflow "signalName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'signalName
           (\ x__ y__ -> x__ {_SignalWorkflow'signalName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalWorkflow "input" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'input
           (\ x__ y__ -> x__ {_SignalWorkflow'input = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField SignalWorkflow "vec'input" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'input
           (\ x__ y__ -> x__ {_SignalWorkflow'input = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalWorkflow "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'identity
           (\ x__ y__ -> x__ {_SignalWorkflow'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalWorkflow "headers" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'headers
           (\ x__ y__ -> x__ {_SignalWorkflow'headers = y__}))
        Prelude.id
instance Data.ProtoLens.Message SignalWorkflow where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.SignalWorkflow"
  packedMessageDescriptor _
    = "\n\
      \\SOSignalWorkflow\DC2\US\n\
      \\vsignal_name\CAN\SOH \SOH(\tR\n\
      \signalName\DC25\n\
      \\ENQinput\CAN\STX \ETX(\v2\US.temporal.api.common.v1.PayloadR\ENQinput\DC2\SUB\n\
      \\bidentity\CAN\ETX \SOH(\tR\bidentity\DC2R\n\
      \\aheaders\CAN\ENQ \ETX(\v28.coresdk.workflow_activation.SignalWorkflow.HeadersEntryR\aheaders\SUB[\n\
      \\fHeadersEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        signalName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "signal_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"signalName")) ::
              Data.ProtoLens.FieldDescriptor SignalWorkflow
        input__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "input"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"input")) ::
              Data.ProtoLens.FieldDescriptor SignalWorkflow
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor SignalWorkflow
        headers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "headers"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SignalWorkflow'HeadersEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"headers")) ::
              Data.ProtoLens.FieldDescriptor SignalWorkflow
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, signalName__field_descriptor),
           (Data.ProtoLens.Tag 2, input__field_descriptor),
           (Data.ProtoLens.Tag 3, identity__field_descriptor),
           (Data.ProtoLens.Tag 5, headers__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SignalWorkflow'_unknownFields
        (\ x__ y__ -> x__ {_SignalWorkflow'_unknownFields = y__})
  defMessage
    = SignalWorkflow'_constructor
        {_SignalWorkflow'signalName = Data.ProtoLens.fieldDefault,
         _SignalWorkflow'input = Data.Vector.Generic.empty,
         _SignalWorkflow'identity = Data.ProtoLens.fieldDefault,
         _SignalWorkflow'headers = Data.Map.empty,
         _SignalWorkflow'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SignalWorkflow
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
             -> Data.ProtoLens.Encoding.Bytes.Parser SignalWorkflow
        loop x mutable'input
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'input <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'input)
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
                              (Data.ProtoLens.Field.field @"vec'input") frozen'input x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "signal_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"signalName") y x)
                                  mutable'input
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "input"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'input y)
                                loop x v
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                                  mutable'input
                        42
                          -> do !(entry :: SignalWorkflow'HeadersEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                             (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                 Data.ProtoLens.Encoding.Bytes.isolate
                                                                                   (Prelude.fromIntegral
                                                                                      len)
                                                                                   Data.ProtoLens.parseMessage)
                                                                             "headers"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"headers")
                                        (\ !t -> Data.Map.insert key value t) x)
                                     mutable'input)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'input
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'input <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                 Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'input)
          "SignalWorkflow"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"signalName") _x
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
                (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                           ((Prelude..)
                              (\ bs
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                         (Prelude.fromIntegral (Data.ByteString.length bs)))
                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                              Data.ProtoLens.encodeMessage _v))
                   (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'input") _x))
                ((Data.Monoid.<>)
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
                      (Data.Monoid.mconcat
                         (Prelude.map
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.ProtoLens.encodeMessage
                                       (Lens.Family2.set
                                          (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                          (Lens.Family2.set
                                             (Data.ProtoLens.Field.field @"value") (Prelude.snd _v)
                                             (Data.ProtoLens.defMessage ::
                                                SignalWorkflow'HeadersEntry)))))
                            (Data.Map.toList
                               (Lens.Family2.view (Data.ProtoLens.Field.field @"headers") _x))))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData SignalWorkflow where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SignalWorkflow'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SignalWorkflow'signalName x__)
                (Control.DeepSeq.deepseq
                   (_SignalWorkflow'input x__)
                   (Control.DeepSeq.deepseq
                      (_SignalWorkflow'identity x__)
                      (Control.DeepSeq.deepseq (_SignalWorkflow'headers x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.key' @:: Lens' SignalWorkflow'HeadersEntry Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.value' @:: Lens' SignalWorkflow'HeadersEntry Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'value' @:: Lens' SignalWorkflow'HeadersEntry (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data SignalWorkflow'HeadersEntry
  = SignalWorkflow'HeadersEntry'_constructor {_SignalWorkflow'HeadersEntry'key :: !Data.Text.Text,
                                              _SignalWorkflow'HeadersEntry'value :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                                              _SignalWorkflow'HeadersEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SignalWorkflow'HeadersEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SignalWorkflow'HeadersEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'HeadersEntry'key
           (\ x__ y__ -> x__ {_SignalWorkflow'HeadersEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SignalWorkflow'HeadersEntry "value" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'HeadersEntry'value
           (\ x__ y__ -> x__ {_SignalWorkflow'HeadersEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SignalWorkflow'HeadersEntry "maybe'value" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SignalWorkflow'HeadersEntry'value
           (\ x__ y__ -> x__ {_SignalWorkflow'HeadersEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message SignalWorkflow'HeadersEntry where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.SignalWorkflow.HeadersEntry"
  packedMessageDescriptor _
    = "\n\
      \\fHeadersEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor SignalWorkflow'HeadersEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor SignalWorkflow'HeadersEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SignalWorkflow'HeadersEntry'_unknownFields
        (\ x__ y__
           -> x__ {_SignalWorkflow'HeadersEntry'_unknownFields = y__})
  defMessage
    = SignalWorkflow'HeadersEntry'_constructor
        {_SignalWorkflow'HeadersEntry'key = Data.ProtoLens.fieldDefault,
         _SignalWorkflow'HeadersEntry'value = Prelude.Nothing,
         _SignalWorkflow'HeadersEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SignalWorkflow'HeadersEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser SignalWorkflow'HeadersEntry
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
          (do loop Data.ProtoLens.defMessage) "HeadersEntry"
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
instance Control.DeepSeq.NFData SignalWorkflow'HeadersEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SignalWorkflow'HeadersEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SignalWorkflow'HeadersEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_SignalWorkflow'HeadersEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowType' @:: Lens' StartWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowId' @:: Lens' StartWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.arguments' @:: Lens' StartWorkflow [Proto.Temporal.Api.Common.V1.Message.Payload]@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.vec'arguments' @:: Lens' StartWorkflow (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.randomnessSeed' @:: Lens' StartWorkflow Data.Word.Word64@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.headers' @:: Lens' StartWorkflow (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.identity' @:: Lens' StartWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.parentWorkflowInfo' @:: Lens' StartWorkflow Proto.Temporal.Sdk.Core.Common.Common.NamespacedWorkflowExecution@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'parentWorkflowInfo' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Temporal.Sdk.Core.Common.Common.NamespacedWorkflowExecution)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowExecutionTimeout' @:: Lens' StartWorkflow Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'workflowExecutionTimeout' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowRunTimeout' @:: Lens' StartWorkflow Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'workflowRunTimeout' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowTaskTimeout' @:: Lens' StartWorkflow Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'workflowTaskTimeout' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.continuedFromExecutionRunId' @:: Lens' StartWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.continuedInitiator' @:: Lens' StartWorkflow Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.continuedFailure' @:: Lens' StartWorkflow Proto.Temporal.Api.Failure.V1.Message.Failure@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'continuedFailure' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.lastCompletionResult' @:: Lens' StartWorkflow Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'lastCompletionResult' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.firstExecutionRunId' @:: Lens' StartWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.retryPolicy' @:: Lens' StartWorkflow Proto.Temporal.Api.Common.V1.Message.RetryPolicy@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'retryPolicy' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.attempt' @:: Lens' StartWorkflow Data.Int.Int32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.cronSchedule' @:: Lens' StartWorkflow Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.workflowExecutionExpirationTime' @:: Lens' StartWorkflow Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'workflowExecutionExpirationTime' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.cronScheduleToScheduleInterval' @:: Lens' StartWorkflow Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'cronScheduleToScheduleInterval' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.memo' @:: Lens' StartWorkflow Proto.Temporal.Api.Common.V1.Message.Memo@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'memo' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.searchAttributes' @:: Lens' StartWorkflow Proto.Temporal.Api.Common.V1.Message.SearchAttributes@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'searchAttributes' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.startTime' @:: Lens' StartWorkflow Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'startTime' @:: Lens' StartWorkflow (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data StartWorkflow
  = StartWorkflow'_constructor {_StartWorkflow'workflowType :: !Data.Text.Text,
                                _StartWorkflow'workflowId :: !Data.Text.Text,
                                _StartWorkflow'arguments :: !(Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload),
                                _StartWorkflow'randomnessSeed :: !Data.Word.Word64,
                                _StartWorkflow'headers :: !(Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload),
                                _StartWorkflow'identity :: !Data.Text.Text,
                                _StartWorkflow'parentWorkflowInfo :: !(Prelude.Maybe Proto.Temporal.Sdk.Core.Common.Common.NamespacedWorkflowExecution),
                                _StartWorkflow'workflowExecutionTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                _StartWorkflow'workflowRunTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                _StartWorkflow'workflowTaskTimeout :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                _StartWorkflow'continuedFromExecutionRunId :: !Data.Text.Text,
                                _StartWorkflow'continuedInitiator :: !Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator,
                                _StartWorkflow'continuedFailure :: !(Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure),
                                _StartWorkflow'lastCompletionResult :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                _StartWorkflow'firstExecutionRunId :: !Data.Text.Text,
                                _StartWorkflow'retryPolicy :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy),
                                _StartWorkflow'attempt :: !Data.Int.Int32,
                                _StartWorkflow'cronSchedule :: !Data.Text.Text,
                                _StartWorkflow'workflowExecutionExpirationTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                _StartWorkflow'cronScheduleToScheduleInterval :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                _StartWorkflow'memo :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo),
                                _StartWorkflow'searchAttributes :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes),
                                _StartWorkflow'startTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                _StartWorkflow'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartWorkflow where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartWorkflow "workflowType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowType
           (\ x__ y__ -> x__ {_StartWorkflow'workflowType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowId
           (\ x__ y__ -> x__ {_StartWorkflow'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "arguments" [Proto.Temporal.Api.Common.V1.Message.Payload] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'arguments
           (\ x__ y__ -> x__ {_StartWorkflow'arguments = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField StartWorkflow "vec'arguments" (Data.Vector.Vector Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'arguments
           (\ x__ y__ -> x__ {_StartWorkflow'arguments = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "randomnessSeed" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'randomnessSeed
           (\ x__ y__ -> x__ {_StartWorkflow'randomnessSeed = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "headers" (Data.Map.Map Data.Text.Text Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'headers
           (\ x__ y__ -> x__ {_StartWorkflow'headers = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "identity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'identity
           (\ x__ y__ -> x__ {_StartWorkflow'identity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "parentWorkflowInfo" Proto.Temporal.Sdk.Core.Common.Common.NamespacedWorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'parentWorkflowInfo
           (\ x__ y__ -> x__ {_StartWorkflow'parentWorkflowInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'parentWorkflowInfo" (Prelude.Maybe Proto.Temporal.Sdk.Core.Common.Common.NamespacedWorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'parentWorkflowInfo
           (\ x__ y__ -> x__ {_StartWorkflow'parentWorkflowInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "workflowExecutionTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowExecutionTimeout
           (\ x__ y__ -> x__ {_StartWorkflow'workflowExecutionTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'workflowExecutionTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowExecutionTimeout
           (\ x__ y__ -> x__ {_StartWorkflow'workflowExecutionTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "workflowRunTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowRunTimeout
           (\ x__ y__ -> x__ {_StartWorkflow'workflowRunTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'workflowRunTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowRunTimeout
           (\ x__ y__ -> x__ {_StartWorkflow'workflowRunTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "workflowTaskTimeout" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowTaskTimeout
           (\ x__ y__ -> x__ {_StartWorkflow'workflowTaskTimeout = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'workflowTaskTimeout" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowTaskTimeout
           (\ x__ y__ -> x__ {_StartWorkflow'workflowTaskTimeout = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "continuedFromExecutionRunId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'continuedFromExecutionRunId
           (\ x__ y__
              -> x__ {_StartWorkflow'continuedFromExecutionRunId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "continuedInitiator" Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'continuedInitiator
           (\ x__ y__ -> x__ {_StartWorkflow'continuedInitiator = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "continuedFailure" Proto.Temporal.Api.Failure.V1.Message.Failure where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'continuedFailure
           (\ x__ y__ -> x__ {_StartWorkflow'continuedFailure = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'continuedFailure" (Prelude.Maybe Proto.Temporal.Api.Failure.V1.Message.Failure) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'continuedFailure
           (\ x__ y__ -> x__ {_StartWorkflow'continuedFailure = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "lastCompletionResult" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'lastCompletionResult
           (\ x__ y__ -> x__ {_StartWorkflow'lastCompletionResult = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'lastCompletionResult" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'lastCompletionResult
           (\ x__ y__ -> x__ {_StartWorkflow'lastCompletionResult = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "firstExecutionRunId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'firstExecutionRunId
           (\ x__ y__ -> x__ {_StartWorkflow'firstExecutionRunId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "retryPolicy" Proto.Temporal.Api.Common.V1.Message.RetryPolicy where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'retryPolicy
           (\ x__ y__ -> x__ {_StartWorkflow'retryPolicy = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'retryPolicy" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.RetryPolicy) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'retryPolicy
           (\ x__ y__ -> x__ {_StartWorkflow'retryPolicy = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "attempt" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'attempt
           (\ x__ y__ -> x__ {_StartWorkflow'attempt = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "cronSchedule" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'cronSchedule
           (\ x__ y__ -> x__ {_StartWorkflow'cronSchedule = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "workflowExecutionExpirationTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowExecutionExpirationTime
           (\ x__ y__
              -> x__ {_StartWorkflow'workflowExecutionExpirationTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'workflowExecutionExpirationTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'workflowExecutionExpirationTime
           (\ x__ y__
              -> x__ {_StartWorkflow'workflowExecutionExpirationTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "cronScheduleToScheduleInterval" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'cronScheduleToScheduleInterval
           (\ x__ y__
              -> x__ {_StartWorkflow'cronScheduleToScheduleInterval = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'cronScheduleToScheduleInterval" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'cronScheduleToScheduleInterval
           (\ x__ y__
              -> x__ {_StartWorkflow'cronScheduleToScheduleInterval = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "memo" Proto.Temporal.Api.Common.V1.Message.Memo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'memo (\ x__ y__ -> x__ {_StartWorkflow'memo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'memo" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Memo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'memo (\ x__ y__ -> x__ {_StartWorkflow'memo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "searchAttributes" Proto.Temporal.Api.Common.V1.Message.SearchAttributes where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'searchAttributes
           (\ x__ y__ -> x__ {_StartWorkflow'searchAttributes = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'searchAttributes" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.SearchAttributes) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'searchAttributes
           (\ x__ y__ -> x__ {_StartWorkflow'searchAttributes = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow "startTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'startTime
           (\ x__ y__ -> x__ {_StartWorkflow'startTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow "maybe'startTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'startTime
           (\ x__ y__ -> x__ {_StartWorkflow'startTime = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartWorkflow where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.StartWorkflow"
  packedMessageDescriptor _
    = "\n\
      \\rStartWorkflow\DC2#\n\
      \\rworkflow_type\CAN\SOH \SOH(\tR\fworkflowType\DC2\US\n\
      \\vworkflow_id\CAN\STX \SOH(\tR\n\
      \workflowId\DC2=\n\
      \\targuments\CAN\ETX \ETX(\v2\US.temporal.api.common.v1.PayloadR\targuments\DC2'\n\
      \\SIrandomness_seed\CAN\EOT \SOH(\EOTR\SOrandomnessSeed\DC2Q\n\
      \\aheaders\CAN\ENQ \ETX(\v27.coresdk.workflow_activation.StartWorkflow.HeadersEntryR\aheaders\DC2\SUB\n\
      \\bidentity\CAN\ACK \SOH(\tR\bidentity\DC2]\n\
      \\DC4parent_workflow_info\CAN\a \SOH(\v2+.coresdk.common.NamespacedWorkflowExecutionR\DC2parentWorkflowInfo\DC2W\n\
      \\SUBworkflow_execution_timeout\CAN\b \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeout\DC2K\n\
      \\DC4workflow_run_timeout\CAN\t \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeout\DC2M\n\
      \\NAKworkflow_task_timeout\CAN\n\
      \ \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeout\DC2D\n\
      \\UScontinued_from_execution_run_id\CAN\v \SOH(\tR\ESCcontinuedFromExecutionRunId\DC2^\n\
      \\DC3continued_initiator\CAN\f \SOH(\SO2-.temporal.api.enums.v1.ContinueAsNewInitiatorR\DC2continuedInitiator\DC2M\n\
      \\DC1continued_failure\CAN\r \SOH(\v2 .temporal.api.failure.v1.FailureR\DLEcontinuedFailure\DC2V\n\
      \\SYNlast_completion_result\CAN\SO \SOH(\v2 .temporal.api.common.v1.PayloadsR\DC4lastCompletionResult\DC23\n\
      \\SYNfirst_execution_run_id\CAN\SI \SOH(\tR\DC3firstExecutionRunId\DC2F\n\
      \\fretry_policy\CAN\DLE \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2\CAN\n\
      \\aattempt\CAN\DC1 \SOH(\ENQR\aattempt\DC2#\n\
      \\rcron_schedule\CAN\DC2 \SOH(\tR\fcronSchedule\DC2g\n\
      \\"workflow_execution_expiration_time\CAN\DC3 \SOH(\v2\SUB.google.protobuf.TimestampR\USworkflowExecutionExpirationTime\DC2e\n\
      \\"cron_schedule_to_schedule_interval\CAN\DC4 \SOH(\v2\EM.google.protobuf.DurationR\RScronScheduleToScheduleInterval\DC20\n\
      \\EOTmemo\CAN\NAK \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
      \\DC1search_attributes\CAN\SYN \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC29\n\
      \\n\
      \start_time\CAN\ETB \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\SUB[\n\
      \\fHeadersEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowType")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        arguments__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "arguments"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"arguments")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        randomnessSeed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "randomness_seed"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"randomnessSeed")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        headers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "headers"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartWorkflow'HeadersEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"headers")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        identity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"identity")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        parentWorkflowInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "parent_workflow_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Sdk.Core.Common.Common.NamespacedWorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'parentWorkflowInfo")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        workflowExecutionTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecutionTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        workflowRunTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_run_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        workflowTaskTimeout__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_task_timeout"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowTaskTimeout")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        continuedFromExecutionRunId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "continued_from_execution_run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"continuedFromExecutionRunId")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        continuedInitiator__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "continued_initiator"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.ContinueAsNewInitiator)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"continuedInitiator")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        continuedFailure__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "continued_failure"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Failure.V1.Message.Failure)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'continuedFailure")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        lastCompletionResult__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_completion_result"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastCompletionResult")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        firstExecutionRunId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "first_execution_run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"firstExecutionRunId")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        retryPolicy__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "retry_policy"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.RetryPolicy)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'retryPolicy")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        attempt__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "attempt"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"attempt")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        cronSchedule__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cron_schedule"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"cronSchedule")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        workflowExecutionExpirationTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution_expiration_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'workflowExecutionExpirationTime")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        cronScheduleToScheduleInterval__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cron_schedule_to_schedule_interval"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'cronScheduleToScheduleInterval")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        memo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "memo"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Memo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'memo")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        searchAttributes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "search_attributes"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.SearchAttributes)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'searchAttributes")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
        startTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startTime")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowType__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 3, arguments__field_descriptor),
           (Data.ProtoLens.Tag 4, randomnessSeed__field_descriptor),
           (Data.ProtoLens.Tag 5, headers__field_descriptor),
           (Data.ProtoLens.Tag 6, identity__field_descriptor),
           (Data.ProtoLens.Tag 7, parentWorkflowInfo__field_descriptor),
           (Data.ProtoLens.Tag 8, workflowExecutionTimeout__field_descriptor),
           (Data.ProtoLens.Tag 9, workflowRunTimeout__field_descriptor),
           (Data.ProtoLens.Tag 10, workflowTaskTimeout__field_descriptor),
           (Data.ProtoLens.Tag 11, 
            continuedFromExecutionRunId__field_descriptor),
           (Data.ProtoLens.Tag 12, continuedInitiator__field_descriptor),
           (Data.ProtoLens.Tag 13, continuedFailure__field_descriptor),
           (Data.ProtoLens.Tag 14, lastCompletionResult__field_descriptor),
           (Data.ProtoLens.Tag 15, firstExecutionRunId__field_descriptor),
           (Data.ProtoLens.Tag 16, retryPolicy__field_descriptor),
           (Data.ProtoLens.Tag 17, attempt__field_descriptor),
           (Data.ProtoLens.Tag 18, cronSchedule__field_descriptor),
           (Data.ProtoLens.Tag 19, 
            workflowExecutionExpirationTime__field_descriptor),
           (Data.ProtoLens.Tag 20, 
            cronScheduleToScheduleInterval__field_descriptor),
           (Data.ProtoLens.Tag 21, memo__field_descriptor),
           (Data.ProtoLens.Tag 22, searchAttributes__field_descriptor),
           (Data.ProtoLens.Tag 23, startTime__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartWorkflow'_unknownFields
        (\ x__ y__ -> x__ {_StartWorkflow'_unknownFields = y__})
  defMessage
    = StartWorkflow'_constructor
        {_StartWorkflow'workflowType = Data.ProtoLens.fieldDefault,
         _StartWorkflow'workflowId = Data.ProtoLens.fieldDefault,
         _StartWorkflow'arguments = Data.Vector.Generic.empty,
         _StartWorkflow'randomnessSeed = Data.ProtoLens.fieldDefault,
         _StartWorkflow'headers = Data.Map.empty,
         _StartWorkflow'identity = Data.ProtoLens.fieldDefault,
         _StartWorkflow'parentWorkflowInfo = Prelude.Nothing,
         _StartWorkflow'workflowExecutionTimeout = Prelude.Nothing,
         _StartWorkflow'workflowRunTimeout = Prelude.Nothing,
         _StartWorkflow'workflowTaskTimeout = Prelude.Nothing,
         _StartWorkflow'continuedFromExecutionRunId = Data.ProtoLens.fieldDefault,
         _StartWorkflow'continuedInitiator = Data.ProtoLens.fieldDefault,
         _StartWorkflow'continuedFailure = Prelude.Nothing,
         _StartWorkflow'lastCompletionResult = Prelude.Nothing,
         _StartWorkflow'firstExecutionRunId = Data.ProtoLens.fieldDefault,
         _StartWorkflow'retryPolicy = Prelude.Nothing,
         _StartWorkflow'attempt = Data.ProtoLens.fieldDefault,
         _StartWorkflow'cronSchedule = Data.ProtoLens.fieldDefault,
         _StartWorkflow'workflowExecutionExpirationTime = Prelude.Nothing,
         _StartWorkflow'cronScheduleToScheduleInterval = Prelude.Nothing,
         _StartWorkflow'memo = Prelude.Nothing,
         _StartWorkflow'searchAttributes = Prelude.Nothing,
         _StartWorkflow'startTime = Prelude.Nothing,
         _StartWorkflow'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartWorkflow
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Common.V1.Message.Payload
             -> Data.ProtoLens.Encoding.Bytes.Parser StartWorkflow
        loop x mutable'arguments
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'arguments <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                               mutable'arguments)
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
                              (Data.ProtoLens.Field.field @"vec'arguments") frozen'arguments x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "workflow_type"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowType") y x)
                                  mutable'arguments
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "workflow_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"workflowId") y x)
                                  mutable'arguments
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "arguments"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'arguments y)
                                loop x v
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "randomness_seed"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"randomnessSeed") y x)
                                  mutable'arguments
                        42
                          -> do !(entry :: StartWorkflow'HeadersEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                            (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                                Data.ProtoLens.Encoding.Bytes.isolate
                                                                                  (Prelude.fromIntegral
                                                                                     len)
                                                                                  Data.ProtoLens.parseMessage)
                                                                            "headers"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"headers")
                                        (\ !t -> Data.Map.insert key value t) x)
                                     mutable'arguments)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "identity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"identity") y x)
                                  mutable'arguments
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "parent_workflow_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"parentWorkflowInfo") y x)
                                  mutable'arguments
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_execution_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecutionTimeout") y x)
                                  mutable'arguments
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_run_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowRunTimeout") y x)
                                  mutable'arguments
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_task_timeout"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTaskTimeout") y x)
                                  mutable'arguments
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "continued_from_execution_run_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"continuedFromExecutionRunId") y
                                     x)
                                  mutable'arguments
                        96
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "continued_initiator"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"continuedInitiator") y x)
                                  mutable'arguments
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "continued_failure"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"continuedFailure") y x)
                                  mutable'arguments
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_completion_result"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastCompletionResult") y x)
                                  mutable'arguments
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "first_execution_run_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"firstExecutionRunId") y x)
                                  mutable'arguments
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "retry_policy"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"retryPolicy") y x)
                                  mutable'arguments
                        136
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "attempt"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"attempt") y x)
                                  mutable'arguments
                        146
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "cron_schedule"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cronSchedule") y x)
                                  mutable'arguments
                        154
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_execution_expiration_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecutionExpirationTime")
                                     y x)
                                  mutable'arguments
                        162
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cron_schedule_to_schedule_interval"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cronScheduleToScheduleInterval")
                                     y x)
                                  mutable'arguments
                        170
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "memo"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"memo") y x)
                                  mutable'arguments
                        178
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "search_attributes"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"searchAttributes") y x)
                                  mutable'arguments
                        186
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"startTime") y x)
                                  mutable'arguments
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'arguments
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'arguments <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                     Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'arguments)
          "StartWorkflow"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowType") _x
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
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"workflowId") _x
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
                      (Lens.Family2.view
                         (Data.ProtoLens.Field.field @"vec'arguments") _x))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"randomnessSeed") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
                      ((Data.Monoid.<>)
                         (Data.Monoid.mconcat
                            (Prelude.map
                               (\ _v
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                       ((Prelude..)
                                          (\ bs
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                     (Prelude.fromIntegral
                                                        (Data.ByteString.length bs)))
                                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                          Data.ProtoLens.encodeMessage
                                          (Lens.Family2.set
                                             (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                             (Lens.Family2.set
                                                (Data.ProtoLens.Field.field @"value")
                                                (Prelude.snd _v)
                                                (Data.ProtoLens.defMessage ::
                                                   StartWorkflow'HeadersEntry)))))
                               (Data.Map.toList
                                  (Lens.Family2.view (Data.ProtoLens.Field.field @"headers") _x))))
                         ((Data.Monoid.<>)
                            (let
                               _v = Lens.Family2.view (Data.ProtoLens.Field.field @"identity") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                     ((Prelude..)
                                        (\ bs
                                           -> (Data.Monoid.<>)
                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                   (Prelude.fromIntegral
                                                      (Data.ByteString.length bs)))
                                                (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                        Data.Text.Encoding.encodeUtf8 _v))
                            ((Data.Monoid.<>)
                               (case
                                    Lens.Family2.view
                                      (Data.ProtoLens.Field.field @"maybe'parentWorkflowInfo") _x
                                of
                                  Prelude.Nothing -> Data.Monoid.mempty
                                  (Prelude.Just _v)
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                         ((Prelude..)
                                            (\ bs
                                               -> (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                       (Prelude.fromIntegral
                                                          (Data.ByteString.length bs)))
                                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                            Data.ProtoLens.encodeMessage _v))
                               ((Data.Monoid.<>)
                                  (case
                                       Lens.Family2.view
                                         (Data.ProtoLens.Field.field
                                            @"maybe'workflowExecutionTimeout")
                                         _x
                                   of
                                     Prelude.Nothing -> Data.Monoid.mempty
                                     (Prelude.Just _v)
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                                            ((Prelude..)
                                               (\ bs
                                                  -> (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                          (Prelude.fromIntegral
                                                             (Data.ByteString.length bs)))
                                                       (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                               Data.ProtoLens.encodeMessage _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'workflowRunTimeout")
                                            _x
                                      of
                                        Prelude.Nothing -> Data.Monoid.mempty
                                        (Prelude.Just _v)
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                                               ((Prelude..)
                                                  (\ bs
                                                     -> (Data.Monoid.<>)
                                                          (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             (Prelude.fromIntegral
                                                                (Data.ByteString.length bs)))
                                                          (Data.ProtoLens.Encoding.Bytes.putBytes
                                                             bs))
                                                  Data.ProtoLens.encodeMessage _v))
                                     ((Data.Monoid.<>)
                                        (case
                                             Lens.Family2.view
                                               (Data.ProtoLens.Field.field
                                                  @"maybe'workflowTaskTimeout")
                                               _x
                                         of
                                           Prelude.Nothing -> Data.Monoid.mempty
                                           (Prelude.Just _v)
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                                                  ((Prelude..)
                                                     (\ bs
                                                        -> (Data.Monoid.<>)
                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                (Prelude.fromIntegral
                                                                   (Data.ByteString.length bs)))
                                                             (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                bs))
                                                     Data.ProtoLens.encodeMessage _v))
                                        ((Data.Monoid.<>)
                                           (let
                                              _v
                                                = Lens.Family2.view
                                                    (Data.ProtoLens.Field.field
                                                       @"continuedFromExecutionRunId")
                                                    _x
                                            in
                                              if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                  Data.Monoid.mempty
                                              else
                                                  (Data.Monoid.<>)
                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                                                    ((Prelude..)
                                                       (\ bs
                                                          -> (Data.Monoid.<>)
                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                  (Prelude.fromIntegral
                                                                     (Data.ByteString.length bs)))
                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                  bs))
                                                       Data.Text.Encoding.encodeUtf8 _v))
                                           ((Data.Monoid.<>)
                                              (let
                                                 _v
                                                   = Lens.Family2.view
                                                       (Data.ProtoLens.Field.field
                                                          @"continuedInitiator")
                                                       _x
                                               in
                                                 if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                                     Data.Monoid.mempty
                                                 else
                                                     (Data.Monoid.<>)
                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 96)
                                                       ((Prelude..)
                                                          ((Prelude..)
                                                             Data.ProtoLens.Encoding.Bytes.putVarInt
                                                             Prelude.fromIntegral)
                                                          Prelude.fromEnum _v))
                                              ((Data.Monoid.<>)
                                                 (case
                                                      Lens.Family2.view
                                                        (Data.ProtoLens.Field.field
                                                           @"maybe'continuedFailure")
                                                        _x
                                                  of
                                                    Prelude.Nothing -> Data.Monoid.mempty
                                                    (Prelude.Just _v)
                                                      -> (Data.Monoid.<>)
                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                              106)
                                                           ((Prelude..)
                                                              (\ bs
                                                                 -> (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         (Prelude.fromIntegral
                                                                            (Data.ByteString.length
                                                                               bs)))
                                                                      (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                         bs))
                                                              Data.ProtoLens.encodeMessage _v))
                                                 ((Data.Monoid.<>)
                                                    (case
                                                         Lens.Family2.view
                                                           (Data.ProtoLens.Field.field
                                                              @"maybe'lastCompletionResult")
                                                           _x
                                                     of
                                                       Prelude.Nothing -> Data.Monoid.mempty
                                                       (Prelude.Just _v)
                                                         -> (Data.Monoid.<>)
                                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                 114)
                                                              ((Prelude..)
                                                                 (\ bs
                                                                    -> (Data.Monoid.<>)
                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            (Prelude.fromIntegral
                                                                               (Data.ByteString.length
                                                                                  bs)))
                                                                         (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                            bs))
                                                                 Data.ProtoLens.encodeMessage _v))
                                                    ((Data.Monoid.<>)
                                                       (let
                                                          _v
                                                            = Lens.Family2.view
                                                                (Data.ProtoLens.Field.field
                                                                   @"firstExecutionRunId")
                                                                _x
                                                        in
                                                          if (Prelude.==)
                                                               _v Data.ProtoLens.fieldDefault then
                                                              Data.Monoid.mempty
                                                          else
                                                              (Data.Monoid.<>)
                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                   122)
                                                                ((Prelude..)
                                                                   (\ bs
                                                                      -> (Data.Monoid.<>)
                                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                              (Prelude.fromIntegral
                                                                                 (Data.ByteString.length
                                                                                    bs)))
                                                                           (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                              bs))
                                                                   Data.Text.Encoding.encodeUtf8
                                                                   _v))
                                                       ((Data.Monoid.<>)
                                                          (case
                                                               Lens.Family2.view
                                                                 (Data.ProtoLens.Field.field
                                                                    @"maybe'retryPolicy")
                                                                 _x
                                                           of
                                                             Prelude.Nothing -> Data.Monoid.mempty
                                                             (Prelude.Just _v)
                                                               -> (Data.Monoid.<>)
                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                       130)
                                                                    ((Prelude..)
                                                                       (\ bs
                                                                          -> (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  (Prelude.fromIntegral
                                                                                     (Data.ByteString.length
                                                                                        bs)))
                                                                               (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                  bs))
                                                                       Data.ProtoLens.encodeMessage
                                                                       _v))
                                                          ((Data.Monoid.<>)
                                                             (let
                                                                _v
                                                                  = Lens.Family2.view
                                                                      (Data.ProtoLens.Field.field
                                                                         @"attempt")
                                                                      _x
                                                              in
                                                                if (Prelude.==)
                                                                     _v
                                                                     Data.ProtoLens.fieldDefault then
                                                                    Data.Monoid.mempty
                                                                else
                                                                    (Data.Monoid.<>)
                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         136)
                                                                      ((Prelude..)
                                                                         Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                         Prelude.fromIntegral _v))
                                                             ((Data.Monoid.<>)
                                                                (let
                                                                   _v
                                                                     = Lens.Family2.view
                                                                         (Data.ProtoLens.Field.field
                                                                            @"cronSchedule")
                                                                         _x
                                                                 in
                                                                   if (Prelude.==)
                                                                        _v
                                                                        Data.ProtoLens.fieldDefault then
                                                                       Data.Monoid.mempty
                                                                   else
                                                                       (Data.Monoid.<>)
                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                            146)
                                                                         ((Prelude..)
                                                                            (\ bs
                                                                               -> (Data.Monoid.<>)
                                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                       (Prelude.fromIntegral
                                                                                          (Data.ByteString.length
                                                                                             bs)))
                                                                                    (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                       bs))
                                                                            Data.Text.Encoding.encodeUtf8
                                                                            _v))
                                                                ((Data.Monoid.<>)
                                                                   (case
                                                                        Lens.Family2.view
                                                                          (Data.ProtoLens.Field.field
                                                                             @"maybe'workflowExecutionExpirationTime")
                                                                          _x
                                                                    of
                                                                      Prelude.Nothing
                                                                        -> Data.Monoid.mempty
                                                                      (Prelude.Just _v)
                                                                        -> (Data.Monoid.<>)
                                                                             (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                154)
                                                                             ((Prelude..)
                                                                                (\ bs
                                                                                   -> (Data.Monoid.<>)
                                                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                           (Prelude.fromIntegral
                                                                                              (Data.ByteString.length
                                                                                                 bs)))
                                                                                        (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                           bs))
                                                                                Data.ProtoLens.encodeMessage
                                                                                _v))
                                                                   ((Data.Monoid.<>)
                                                                      (case
                                                                           Lens.Family2.view
                                                                             (Data.ProtoLens.Field.field
                                                                                @"maybe'cronScheduleToScheduleInterval")
                                                                             _x
                                                                       of
                                                                         Prelude.Nothing
                                                                           -> Data.Monoid.mempty
                                                                         (Prelude.Just _v)
                                                                           -> (Data.Monoid.<>)
                                                                                (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                   162)
                                                                                ((Prelude..)
                                                                                   (\ bs
                                                                                      -> (Data.Monoid.<>)
                                                                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                              (Prelude.fromIntegral
                                                                                                 (Data.ByteString.length
                                                                                                    bs)))
                                                                                           (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                              bs))
                                                                                   Data.ProtoLens.encodeMessage
                                                                                   _v))
                                                                      ((Data.Monoid.<>)
                                                                         (case
                                                                              Lens.Family2.view
                                                                                (Data.ProtoLens.Field.field
                                                                                   @"maybe'memo")
                                                                                _x
                                                                          of
                                                                            Prelude.Nothing
                                                                              -> Data.Monoid.mempty
                                                                            (Prelude.Just _v)
                                                                              -> (Data.Monoid.<>)
                                                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                      170)
                                                                                   ((Prelude..)
                                                                                      (\ bs
                                                                                         -> (Data.Monoid.<>)
                                                                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                 (Prelude.fromIntegral
                                                                                                    (Data.ByteString.length
                                                                                                       bs)))
                                                                                              (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                 bs))
                                                                                      Data.ProtoLens.encodeMessage
                                                                                      _v))
                                                                         ((Data.Monoid.<>)
                                                                            (case
                                                                                 Lens.Family2.view
                                                                                   (Data.ProtoLens.Field.field
                                                                                      @"maybe'searchAttributes")
                                                                                   _x
                                                                             of
                                                                               Prelude.Nothing
                                                                                 -> Data.Monoid.mempty
                                                                               (Prelude.Just _v)
                                                                                 -> (Data.Monoid.<>)
                                                                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                         178)
                                                                                      ((Prelude..)
                                                                                         (\ bs
                                                                                            -> (Data.Monoid.<>)
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                    (Prelude.fromIntegral
                                                                                                       (Data.ByteString.length
                                                                                                          bs)))
                                                                                                 (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                    bs))
                                                                                         Data.ProtoLens.encodeMessage
                                                                                         _v))
                                                                            ((Data.Monoid.<>)
                                                                               (case
                                                                                    Lens.Family2.view
                                                                                      (Data.ProtoLens.Field.field
                                                                                         @"maybe'startTime")
                                                                                      _x
                                                                                of
                                                                                  Prelude.Nothing
                                                                                    -> Data.Monoid.mempty
                                                                                  (Prelude.Just _v)
                                                                                    -> (Data.Monoid.<>)
                                                                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                            186)
                                                                                         ((Prelude..)
                                                                                            (\ bs
                                                                                               -> (Data.Monoid.<>)
                                                                                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                                       (Prelude.fromIntegral
                                                                                                          (Data.ByteString.length
                                                                                                             bs)))
                                                                                                    (Data.ProtoLens.Encoding.Bytes.putBytes
                                                                                                       bs))
                                                                                            Data.ProtoLens.encodeMessage
                                                                                            _v))
                                                                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                                                  (Lens.Family2.view
                                                                                     Data.ProtoLens.unknownFields
                                                                                     _x))))))))))))))))))))))))
instance Control.DeepSeq.NFData StartWorkflow where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartWorkflow'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartWorkflow'workflowType x__)
                (Control.DeepSeq.deepseq
                   (_StartWorkflow'workflowId x__)
                   (Control.DeepSeq.deepseq
                      (_StartWorkflow'arguments x__)
                      (Control.DeepSeq.deepseq
                         (_StartWorkflow'randomnessSeed x__)
                         (Control.DeepSeq.deepseq
                            (_StartWorkflow'headers x__)
                            (Control.DeepSeq.deepseq
                               (_StartWorkflow'identity x__)
                               (Control.DeepSeq.deepseq
                                  (_StartWorkflow'parentWorkflowInfo x__)
                                  (Control.DeepSeq.deepseq
                                     (_StartWorkflow'workflowExecutionTimeout x__)
                                     (Control.DeepSeq.deepseq
                                        (_StartWorkflow'workflowRunTimeout x__)
                                        (Control.DeepSeq.deepseq
                                           (_StartWorkflow'workflowTaskTimeout x__)
                                           (Control.DeepSeq.deepseq
                                              (_StartWorkflow'continuedFromExecutionRunId x__)
                                              (Control.DeepSeq.deepseq
                                                 (_StartWorkflow'continuedInitiator x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_StartWorkflow'continuedFailure x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_StartWorkflow'lastCompletionResult x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_StartWorkflow'firstExecutionRunId x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_StartWorkflow'retryPolicy x__)
                                                             (Control.DeepSeq.deepseq
                                                                (_StartWorkflow'attempt x__)
                                                                (Control.DeepSeq.deepseq
                                                                   (_StartWorkflow'cronSchedule x__)
                                                                   (Control.DeepSeq.deepseq
                                                                      (_StartWorkflow'workflowExecutionExpirationTime
                                                                         x__)
                                                                      (Control.DeepSeq.deepseq
                                                                         (_StartWorkflow'cronScheduleToScheduleInterval
                                                                            x__)
                                                                         (Control.DeepSeq.deepseq
                                                                            (_StartWorkflow'memo
                                                                               x__)
                                                                            (Control.DeepSeq.deepseq
                                                                               (_StartWorkflow'searchAttributes
                                                                                  x__)
                                                                               (Control.DeepSeq.deepseq
                                                                                  (_StartWorkflow'startTime
                                                                                     x__)
                                                                                  ())))))))))))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.key' @:: Lens' StartWorkflow'HeadersEntry Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.value' @:: Lens' StartWorkflow'HeadersEntry Proto.Temporal.Api.Common.V1.Message.Payload@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'value' @:: Lens' StartWorkflow'HeadersEntry (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload)@ -}
data StartWorkflow'HeadersEntry
  = StartWorkflow'HeadersEntry'_constructor {_StartWorkflow'HeadersEntry'key :: !Data.Text.Text,
                                             _StartWorkflow'HeadersEntry'value :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload),
                                             _StartWorkflow'HeadersEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show StartWorkflow'HeadersEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField StartWorkflow'HeadersEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'HeadersEntry'key
           (\ x__ y__ -> x__ {_StartWorkflow'HeadersEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField StartWorkflow'HeadersEntry "value" Proto.Temporal.Api.Common.V1.Message.Payload where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'HeadersEntry'value
           (\ x__ y__ -> x__ {_StartWorkflow'HeadersEntry'value = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField StartWorkflow'HeadersEntry "maybe'value" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payload) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _StartWorkflow'HeadersEntry'value
           (\ x__ y__ -> x__ {_StartWorkflow'HeadersEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message StartWorkflow'HeadersEntry where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.StartWorkflow.HeadersEntry"
  packedMessageDescriptor _
    = "\n\
      \\fHeadersEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
      \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH"
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
              Data.ProtoLens.FieldDescriptor StartWorkflow'HeadersEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payload)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'value")) ::
              Data.ProtoLens.FieldDescriptor StartWorkflow'HeadersEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _StartWorkflow'HeadersEntry'_unknownFields
        (\ x__ y__
           -> x__ {_StartWorkflow'HeadersEntry'_unknownFields = y__})
  defMessage
    = StartWorkflow'HeadersEntry'_constructor
        {_StartWorkflow'HeadersEntry'key = Data.ProtoLens.fieldDefault,
         _StartWorkflow'HeadersEntry'value = Prelude.Nothing,
         _StartWorkflow'HeadersEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          StartWorkflow'HeadersEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser StartWorkflow'HeadersEntry
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
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
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
          (do loop Data.ProtoLens.defMessage) "HeadersEntry"
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
instance Control.DeepSeq.NFData StartWorkflow'HeadersEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_StartWorkflow'HeadersEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_StartWorkflow'HeadersEntry'key x__)
                (Control.DeepSeq.deepseq
                   (_StartWorkflow'HeadersEntry'value x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.randomnessSeed' @:: Lens' UpdateRandomSeed Data.Word.Word64@ -}
data UpdateRandomSeed
  = UpdateRandomSeed'_constructor {_UpdateRandomSeed'randomnessSeed :: !Data.Word.Word64,
                                   _UpdateRandomSeed'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show UpdateRandomSeed where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField UpdateRandomSeed "randomnessSeed" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _UpdateRandomSeed'randomnessSeed
           (\ x__ y__ -> x__ {_UpdateRandomSeed'randomnessSeed = y__}))
        Prelude.id
instance Data.ProtoLens.Message UpdateRandomSeed where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.UpdateRandomSeed"
  packedMessageDescriptor _
    = "\n\
      \\DLEUpdateRandomSeed\DC2'\n\
      \\SIrandomness_seed\CAN\SOH \SOH(\EOTR\SOrandomnessSeed"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        randomnessSeed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "randomness_seed"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"randomnessSeed")) ::
              Data.ProtoLens.FieldDescriptor UpdateRandomSeed
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, randomnessSeed__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _UpdateRandomSeed'_unknownFields
        (\ x__ y__ -> x__ {_UpdateRandomSeed'_unknownFields = y__})
  defMessage
    = UpdateRandomSeed'_constructor
        {_UpdateRandomSeed'randomnessSeed = Data.ProtoLens.fieldDefault,
         _UpdateRandomSeed'_unknownFields = []}
  parseMessage
    = let
        loop ::
          UpdateRandomSeed
          -> Data.ProtoLens.Encoding.Bytes.Parser UpdateRandomSeed
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
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "randomness_seed"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"randomnessSeed") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "UpdateRandomSeed"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"randomnessSeed") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData UpdateRandomSeed where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_UpdateRandomSeed'_unknownFields x__)
             (Control.DeepSeq.deepseq (_UpdateRandomSeed'randomnessSeed x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.runId' @:: Lens' WorkflowActivation Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.timestamp' @:: Lens' WorkflowActivation Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'timestamp' @:: Lens' WorkflowActivation (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.isReplaying' @:: Lens' WorkflowActivation Prelude.Bool@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.historyLength' @:: Lens' WorkflowActivation Data.Word.Word32@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.jobs' @:: Lens' WorkflowActivation [WorkflowActivationJob]@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.vec'jobs' @:: Lens' WorkflowActivation (Data.Vector.Vector WorkflowActivationJob)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.availableInternalFlags' @:: Lens' WorkflowActivation [Data.Word.Word32]@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.vec'availableInternalFlags' @:: Lens' WorkflowActivation (Data.Vector.Unboxed.Vector Data.Word.Word32)@ -}
data WorkflowActivation
  = WorkflowActivation'_constructor {_WorkflowActivation'runId :: !Data.Text.Text,
                                     _WorkflowActivation'timestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                     _WorkflowActivation'isReplaying :: !Prelude.Bool,
                                     _WorkflowActivation'historyLength :: !Data.Word.Word32,
                                     _WorkflowActivation'jobs :: !(Data.Vector.Vector WorkflowActivationJob),
                                     _WorkflowActivation'availableInternalFlags :: !(Data.Vector.Unboxed.Vector Data.Word.Word32),
                                     _WorkflowActivation'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowActivation where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowActivation "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'runId
           (\ x__ y__ -> x__ {_WorkflowActivation'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowActivation "timestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'timestamp
           (\ x__ y__ -> x__ {_WorkflowActivation'timestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowActivation "maybe'timestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'timestamp
           (\ x__ y__ -> x__ {_WorkflowActivation'timestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowActivation "isReplaying" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'isReplaying
           (\ x__ y__ -> x__ {_WorkflowActivation'isReplaying = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowActivation "historyLength" Data.Word.Word32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'historyLength
           (\ x__ y__ -> x__ {_WorkflowActivation'historyLength = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowActivation "jobs" [WorkflowActivationJob] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'jobs
           (\ x__ y__ -> x__ {_WorkflowActivation'jobs = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowActivation "vec'jobs" (Data.Vector.Vector WorkflowActivationJob) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'jobs
           (\ x__ y__ -> x__ {_WorkflowActivation'jobs = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowActivation "availableInternalFlags" [Data.Word.Word32] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'availableInternalFlags
           (\ x__ y__
              -> x__ {_WorkflowActivation'availableInternalFlags = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowActivation "vec'availableInternalFlags" (Data.Vector.Unboxed.Vector Data.Word.Word32) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivation'availableInternalFlags
           (\ x__ y__
              -> x__ {_WorkflowActivation'availableInternalFlags = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowActivation where
  messageName _
    = Data.Text.pack "coresdk.workflow_activation.WorkflowActivation"
  packedMessageDescriptor _
    = "\n\
      \\DC2WorkflowActivation\DC2\NAK\n\
      \\ACKrun_id\CAN\SOH \SOH(\tR\ENQrunId\DC28\n\
      \\ttimestamp\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\ttimestamp\DC2!\n\
      \\fis_replaying\CAN\ETX \SOH(\bR\visReplaying\DC2%\n\
      \\SOhistory_length\CAN\EOT \SOH(\rR\rhistoryLength\DC2F\n\
      \\EOTjobs\CAN\ENQ \ETX(\v22.coresdk.workflow_activation.WorkflowActivationJobR\EOTjobs\DC28\n\
      \\CANavailable_internal_flags\CAN\ACK \ETX(\rR\SYNavailableInternalFlags"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivation
        timestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'timestamp")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivation
        isReplaying__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_replaying"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isReplaying")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivation
        historyLength__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "history_length"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"historyLength")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivation
        jobs__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "jobs"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowActivationJob)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"jobs")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivation
        availableInternalFlags__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "available_internal_flags"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word32)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Packed
                 (Data.ProtoLens.Field.field @"availableInternalFlags")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivation
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, runId__field_descriptor),
           (Data.ProtoLens.Tag 2, timestamp__field_descriptor),
           (Data.ProtoLens.Tag 3, isReplaying__field_descriptor),
           (Data.ProtoLens.Tag 4, historyLength__field_descriptor),
           (Data.ProtoLens.Tag 5, jobs__field_descriptor),
           (Data.ProtoLens.Tag 6, availableInternalFlags__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowActivation'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowActivation'_unknownFields = y__})
  defMessage
    = WorkflowActivation'_constructor
        {_WorkflowActivation'runId = Data.ProtoLens.fieldDefault,
         _WorkflowActivation'timestamp = Prelude.Nothing,
         _WorkflowActivation'isReplaying = Data.ProtoLens.fieldDefault,
         _WorkflowActivation'historyLength = Data.ProtoLens.fieldDefault,
         _WorkflowActivation'jobs = Data.Vector.Generic.empty,
         _WorkflowActivation'availableInternalFlags = Data.Vector.Generic.empty,
         _WorkflowActivation'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowActivation
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Unboxed.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Word.Word32
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld WorkflowActivationJob
                -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowActivation
        loop x mutable'availableInternalFlags mutable'jobs
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'availableInternalFlags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                            mutable'availableInternalFlags)
                      frozen'jobs <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'jobs)
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
                              (Data.ProtoLens.Field.field @"vec'availableInternalFlags")
                              frozen'availableInternalFlags
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'jobs") frozen'jobs x)))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "run_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"runId") y x)
                                  mutable'availableInternalFlags mutable'jobs
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "timestamp"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"timestamp") y x)
                                  mutable'availableInternalFlags mutable'jobs
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_replaying"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"isReplaying") y x)
                                  mutable'availableInternalFlags mutable'jobs
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "history_length"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"historyLength") y x)
                                  mutable'availableInternalFlags mutable'jobs
                        42
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "jobs"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'jobs y)
                                loop x mutable'availableInternalFlags v
                        48
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (Prelude.fmap
                                           Prelude.fromIntegral
                                           Data.ProtoLens.Encoding.Bytes.getVarInt)
                                        "available_internal_flags"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'availableInternalFlags y)
                                loop x v mutable'jobs
                        50
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
                                                                    "available_internal_flags"
                                                            qs' <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                                     (Data.ProtoLens.Encoding.Growing.append
                                                                        qs q)
                                                            ploop qs'
                                            in ploop)
                                             mutable'availableInternalFlags)
                                loop x y mutable'jobs
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'availableInternalFlags mutable'jobs
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'availableInternalFlags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                  Data.ProtoLens.Encoding.Growing.new
              mutable'jobs <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'availableInternalFlags
                mutable'jobs)
          "WorkflowActivation"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"runId") _x
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
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'timestamp") _x
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
                   (let
                      _v
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"isReplaying") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                               _v))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"historyLength") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                      ((Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.ProtoLens.encodeMessage _v))
                            (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'jobs") _x))
                         ((Data.Monoid.<>)
                            (let
                               p = Lens.Family2.view
                                     (Data.ProtoLens.Field.field @"vec'availableInternalFlags") _x
                             in
                               if Data.Vector.Generic.null p then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                     ((\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                        (Data.ProtoLens.Encoding.Bytes.runBuilder
                                           (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                              ((Prelude..)
                                                 Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 Prelude.fromIntegral)
                                              p))))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData WorkflowActivation where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowActivation'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowActivation'runId x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowActivation'timestamp x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowActivation'isReplaying x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowActivation'historyLength x__)
                         (Control.DeepSeq.deepseq
                            (_WorkflowActivation'jobs x__)
                            (Control.DeepSeq.deepseq
                               (_WorkflowActivation'availableInternalFlags x__) ()))))))
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'variant' @:: Lens' WorkflowActivationJob (Prelude.Maybe WorkflowActivationJob'Variant)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'startWorkflow' @:: Lens' WorkflowActivationJob (Prelude.Maybe StartWorkflow)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.startWorkflow' @:: Lens' WorkflowActivationJob StartWorkflow@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'fireTimer' @:: Lens' WorkflowActivationJob (Prelude.Maybe FireTimer)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.fireTimer' @:: Lens' WorkflowActivationJob FireTimer@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'updateRandomSeed' @:: Lens' WorkflowActivationJob (Prelude.Maybe UpdateRandomSeed)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.updateRandomSeed' @:: Lens' WorkflowActivationJob UpdateRandomSeed@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'queryWorkflow' @:: Lens' WorkflowActivationJob (Prelude.Maybe QueryWorkflow)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.queryWorkflow' @:: Lens' WorkflowActivationJob QueryWorkflow@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'cancelWorkflow' @:: Lens' WorkflowActivationJob (Prelude.Maybe CancelWorkflow)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.cancelWorkflow' @:: Lens' WorkflowActivationJob CancelWorkflow@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'signalWorkflow' @:: Lens' WorkflowActivationJob (Prelude.Maybe SignalWorkflow)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.signalWorkflow' @:: Lens' WorkflowActivationJob SignalWorkflow@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'resolveActivity' @:: Lens' WorkflowActivationJob (Prelude.Maybe ResolveActivity)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.resolveActivity' @:: Lens' WorkflowActivationJob ResolveActivity@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'notifyHasPatch' @:: Lens' WorkflowActivationJob (Prelude.Maybe NotifyHasPatch)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.notifyHasPatch' @:: Lens' WorkflowActivationJob NotifyHasPatch@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'resolveChildWorkflowExecutionStart' @:: Lens' WorkflowActivationJob (Prelude.Maybe ResolveChildWorkflowExecutionStart)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.resolveChildWorkflowExecutionStart' @:: Lens' WorkflowActivationJob ResolveChildWorkflowExecutionStart@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'resolveChildWorkflowExecution' @:: Lens' WorkflowActivationJob (Prelude.Maybe ResolveChildWorkflowExecution)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.resolveChildWorkflowExecution' @:: Lens' WorkflowActivationJob ResolveChildWorkflowExecution@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'resolveSignalExternalWorkflow' @:: Lens' WorkflowActivationJob (Prelude.Maybe ResolveSignalExternalWorkflow)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.resolveSignalExternalWorkflow' @:: Lens' WorkflowActivationJob ResolveSignalExternalWorkflow@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'resolveRequestCancelExternalWorkflow' @:: Lens' WorkflowActivationJob (Prelude.Maybe ResolveRequestCancelExternalWorkflow)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.resolveRequestCancelExternalWorkflow' @:: Lens' WorkflowActivationJob ResolveRequestCancelExternalWorkflow@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.maybe'removeFromCache' @:: Lens' WorkflowActivationJob (Prelude.Maybe RemoveFromCache)@
         * 'Proto.Temporal.Sdk.Core.WorkflowActivation.WorkflowActivation_Fields.removeFromCache' @:: Lens' WorkflowActivationJob RemoveFromCache@ -}
data WorkflowActivationJob
  = WorkflowActivationJob'_constructor {_WorkflowActivationJob'variant :: !(Prelude.Maybe WorkflowActivationJob'Variant),
                                        _WorkflowActivationJob'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowActivationJob where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data WorkflowActivationJob'Variant
  = WorkflowActivationJob'StartWorkflow !StartWorkflow |
    WorkflowActivationJob'FireTimer !FireTimer |
    WorkflowActivationJob'UpdateRandomSeed !UpdateRandomSeed |
    WorkflowActivationJob'QueryWorkflow !QueryWorkflow |
    WorkflowActivationJob'CancelWorkflow !CancelWorkflow |
    WorkflowActivationJob'SignalWorkflow !SignalWorkflow |
    WorkflowActivationJob'ResolveActivity !ResolveActivity |
    WorkflowActivationJob'NotifyHasPatch !NotifyHasPatch |
    WorkflowActivationJob'ResolveChildWorkflowExecutionStart !ResolveChildWorkflowExecutionStart |
    WorkflowActivationJob'ResolveChildWorkflowExecution !ResolveChildWorkflowExecution |
    WorkflowActivationJob'ResolveSignalExternalWorkflow !ResolveSignalExternalWorkflow |
    WorkflowActivationJob'ResolveRequestCancelExternalWorkflow !ResolveRequestCancelExternalWorkflow |
    WorkflowActivationJob'RemoveFromCache !RemoveFromCache
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'variant" (Prelude.Maybe WorkflowActivationJob'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'startWorkflow" (Prelude.Maybe StartWorkflow) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'StartWorkflow x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowActivationJob'StartWorkflow y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "startWorkflow" StartWorkflow where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'StartWorkflow x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowActivationJob'StartWorkflow y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'fireTimer" (Prelude.Maybe FireTimer) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'FireTimer x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowActivationJob'FireTimer y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "fireTimer" FireTimer where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'FireTimer x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowActivationJob'FireTimer y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'updateRandomSeed" (Prelude.Maybe UpdateRandomSeed) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'UpdateRandomSeed x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap WorkflowActivationJob'UpdateRandomSeed y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "updateRandomSeed" UpdateRandomSeed where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'UpdateRandomSeed x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap WorkflowActivationJob'UpdateRandomSeed y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'queryWorkflow" (Prelude.Maybe QueryWorkflow) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'QueryWorkflow x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowActivationJob'QueryWorkflow y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "queryWorkflow" QueryWorkflow where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'QueryWorkflow x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowActivationJob'QueryWorkflow y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'cancelWorkflow" (Prelude.Maybe CancelWorkflow) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'CancelWorkflow x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowActivationJob'CancelWorkflow y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "cancelWorkflow" CancelWorkflow where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'CancelWorkflow x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowActivationJob'CancelWorkflow y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'signalWorkflow" (Prelude.Maybe SignalWorkflow) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'SignalWorkflow x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowActivationJob'SignalWorkflow y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "signalWorkflow" SignalWorkflow where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'SignalWorkflow x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowActivationJob'SignalWorkflow y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'resolveActivity" (Prelude.Maybe ResolveActivity) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'ResolveActivity x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap WorkflowActivationJob'ResolveActivity y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "resolveActivity" ResolveActivity where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'ResolveActivity x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap WorkflowActivationJob'ResolveActivity y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'notifyHasPatch" (Prelude.Maybe NotifyHasPatch) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'NotifyHasPatch x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowActivationJob'NotifyHasPatch y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "notifyHasPatch" NotifyHasPatch where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'NotifyHasPatch x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowActivationJob'NotifyHasPatch y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'resolveChildWorkflowExecutionStart" (Prelude.Maybe ResolveChildWorkflowExecutionStart) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'ResolveChildWorkflowExecutionStart x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   WorkflowActivationJob'ResolveChildWorkflowExecutionStart y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "resolveChildWorkflowExecutionStart" ResolveChildWorkflowExecutionStart where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'ResolveChildWorkflowExecutionStart x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      WorkflowActivationJob'ResolveChildWorkflowExecutionStart y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'resolveChildWorkflowExecution" (Prelude.Maybe ResolveChildWorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'ResolveChildWorkflowExecution x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   WorkflowActivationJob'ResolveChildWorkflowExecution y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "resolveChildWorkflowExecution" ResolveChildWorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'ResolveChildWorkflowExecution x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      WorkflowActivationJob'ResolveChildWorkflowExecution y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'resolveSignalExternalWorkflow" (Prelude.Maybe ResolveSignalExternalWorkflow) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'ResolveSignalExternalWorkflow x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   WorkflowActivationJob'ResolveSignalExternalWorkflow y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "resolveSignalExternalWorkflow" ResolveSignalExternalWorkflow where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'ResolveSignalExternalWorkflow x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      WorkflowActivationJob'ResolveSignalExternalWorkflow y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'resolveRequestCancelExternalWorkflow" (Prelude.Maybe ResolveRequestCancelExternalWorkflow) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap
                   WorkflowActivationJob'ResolveRequestCancelExternalWorkflow y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "resolveRequestCancelExternalWorkflow" ResolveRequestCancelExternalWorkflow where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap
                      WorkflowActivationJob'ResolveRequestCancelExternalWorkflow y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "maybe'removeFromCache" (Prelude.Maybe RemoveFromCache) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowActivationJob'RemoveFromCache x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap WorkflowActivationJob'RemoveFromCache y__))
instance Data.ProtoLens.Field.HasField WorkflowActivationJob "removeFromCache" RemoveFromCache where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowActivationJob'variant
           (\ x__ y__ -> x__ {_WorkflowActivationJob'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowActivationJob'RemoveFromCache x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap WorkflowActivationJob'RemoveFromCache y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message WorkflowActivationJob where
  messageName _
    = Data.Text.pack
        "coresdk.workflow_activation.WorkflowActivationJob"
  packedMessageDescriptor _
    = "\n\
      \\NAKWorkflowActivationJob\DC2S\n\
      \\SOstart_workflow\CAN\SOH \SOH(\v2*.coresdk.workflow_activation.StartWorkflowH\NULR\rstartWorkflow\DC2G\n\
      \\n\
      \fire_timer\CAN\STX \SOH(\v2&.coresdk.workflow_activation.FireTimerH\NULR\tfireTimer\DC2]\n\
      \\DC2update_random_seed\CAN\EOT \SOH(\v2-.coresdk.workflow_activation.UpdateRandomSeedH\NULR\DLEupdateRandomSeed\DC2S\n\
      \\SOquery_workflow\CAN\ENQ \SOH(\v2*.coresdk.workflow_activation.QueryWorkflowH\NULR\rqueryWorkflow\DC2V\n\
      \\SIcancel_workflow\CAN\ACK \SOH(\v2+.coresdk.workflow_activation.CancelWorkflowH\NULR\SOcancelWorkflow\DC2V\n\
      \\SIsignal_workflow\CAN\a \SOH(\v2+.coresdk.workflow_activation.SignalWorkflowH\NULR\SOsignalWorkflow\DC2Y\n\
      \\DLEresolve_activity\CAN\b \SOH(\v2,.coresdk.workflow_activation.ResolveActivityH\NULR\SIresolveActivity\DC2W\n\
      \\DLEnotify_has_patch\CAN\t \SOH(\v2+.coresdk.workflow_activation.NotifyHasPatchH\NULR\SOnotifyHasPatch\DC2\149\SOH\n\
      \&resolve_child_workflow_execution_start\CAN\n\
      \ \SOH(\v2?.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartH\NULR\"resolveChildWorkflowExecutionStart\DC2\133\SOH\n\
      \ resolve_child_workflow_execution\CAN\v \SOH(\v2:.coresdk.workflow_activation.ResolveChildWorkflowExecutionH\NULR\GSresolveChildWorkflowExecution\DC2\133\SOH\n\
      \ resolve_signal_external_workflow\CAN\f \SOH(\v2:.coresdk.workflow_activation.ResolveSignalExternalWorkflowH\NULR\GSresolveSignalExternalWorkflow\DC2\155\SOH\n\
      \(resolve_request_cancel_external_workflow\CAN\r \SOH(\v2A.coresdk.workflow_activation.ResolveRequestCancelExternalWorkflowH\NULR$resolveRequestCancelExternalWorkflow\DC2Z\n\
      \\DC1remove_from_cache\CAN2 \SOH(\v2,.coresdk.workflow_activation.RemoveFromCacheH\NULR\SIremoveFromCacheB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        startWorkflow__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_workflow"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor StartWorkflow)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startWorkflow")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        fireTimer__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "fire_timer"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor FireTimer)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'fireTimer")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        updateRandomSeed__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "update_random_seed"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor UpdateRandomSeed)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'updateRandomSeed")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        queryWorkflow__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "query_workflow"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor QueryWorkflow)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'queryWorkflow")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        cancelWorkflow__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cancel_workflow"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor CancelWorkflow)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'cancelWorkflow")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        signalWorkflow__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "signal_workflow"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SignalWorkflow)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'signalWorkflow")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        resolveActivity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "resolve_activity"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveActivity)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'resolveActivity")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        notifyHasPatch__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "notify_has_patch"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor NotifyHasPatch)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'notifyHasPatch")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        resolveChildWorkflowExecutionStart__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "resolve_child_workflow_execution_start"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveChildWorkflowExecutionStart)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'resolveChildWorkflowExecutionStart")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        resolveChildWorkflowExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "resolve_child_workflow_execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveChildWorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'resolveChildWorkflowExecution")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        resolveSignalExternalWorkflow__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "resolve_signal_external_workflow"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveSignalExternalWorkflow)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'resolveSignalExternalWorkflow")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        resolveRequestCancelExternalWorkflow__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "resolve_request_cancel_external_workflow"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ResolveRequestCancelExternalWorkflow)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field
                    @"maybe'resolveRequestCancelExternalWorkflow")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
        removeFromCache__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "remove_from_cache"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor RemoveFromCache)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'removeFromCache")) ::
              Data.ProtoLens.FieldDescriptor WorkflowActivationJob
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, startWorkflow__field_descriptor),
           (Data.ProtoLens.Tag 2, fireTimer__field_descriptor),
           (Data.ProtoLens.Tag 4, updateRandomSeed__field_descriptor),
           (Data.ProtoLens.Tag 5, queryWorkflow__field_descriptor),
           (Data.ProtoLens.Tag 6, cancelWorkflow__field_descriptor),
           (Data.ProtoLens.Tag 7, signalWorkflow__field_descriptor),
           (Data.ProtoLens.Tag 8, resolveActivity__field_descriptor),
           (Data.ProtoLens.Tag 9, notifyHasPatch__field_descriptor),
           (Data.ProtoLens.Tag 10, 
            resolveChildWorkflowExecutionStart__field_descriptor),
           (Data.ProtoLens.Tag 11, 
            resolveChildWorkflowExecution__field_descriptor),
           (Data.ProtoLens.Tag 12, 
            resolveSignalExternalWorkflow__field_descriptor),
           (Data.ProtoLens.Tag 13, 
            resolveRequestCancelExternalWorkflow__field_descriptor),
           (Data.ProtoLens.Tag 50, removeFromCache__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowActivationJob'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowActivationJob'_unknownFields = y__})
  defMessage
    = WorkflowActivationJob'_constructor
        {_WorkflowActivationJob'variant = Prelude.Nothing,
         _WorkflowActivationJob'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowActivationJob
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowActivationJob
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
                                       "start_workflow"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startWorkflow") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "fire_timer"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"fireTimer") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "update_random_seed"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"updateRandomSeed") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "query_workflow"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"queryWorkflow") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "cancel_workflow"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"cancelWorkflow") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "signal_workflow"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"signalWorkflow") y x)
                        66
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "resolve_activity"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"resolveActivity") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "notify_has_patch"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"notifyHasPatch") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "resolve_child_workflow_execution_start"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"resolveChildWorkflowExecutionStart")
                                     y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "resolve_child_workflow_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"resolveChildWorkflowExecution") y
                                     x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "resolve_signal_external_workflow"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"resolveSignalExternalWorkflow") y
                                     x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "resolve_request_cancel_external_workflow"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field
                                        @"resolveRequestCancelExternalWorkflow")
                                     y x)
                        402
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "remove_from_cache"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"removeFromCache") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowActivationJob"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (WorkflowActivationJob'StartWorkflow v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'FireTimer v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'UpdateRandomSeed v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'QueryWorkflow v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'CancelWorkflow v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'SignalWorkflow v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'ResolveActivity v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 66)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'NotifyHasPatch v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 74)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'ResolveChildWorkflowExecutionStart v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 82)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'ResolveChildWorkflowExecution v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'ResolveSignalExternalWorkflow v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 106)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v)
                (Prelude.Just (WorkflowActivationJob'RemoveFromCache v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 402)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData WorkflowActivationJob where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowActivationJob'_unknownFields x__)
             (Control.DeepSeq.deepseq (_WorkflowActivationJob'variant x__) ())
instance Control.DeepSeq.NFData WorkflowActivationJob'Variant where
  rnf (WorkflowActivationJob'StartWorkflow x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'FireTimer x__) = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'UpdateRandomSeed x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'QueryWorkflow x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'CancelWorkflow x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'SignalWorkflow x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'ResolveActivity x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'NotifyHasPatch x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'ResolveChildWorkflowExecutionStart x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'ResolveChildWorkflowExecution x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'ResolveSignalExternalWorkflow x__)
    = Control.DeepSeq.rnf x__
  rnf
    (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkflowActivationJob'RemoveFromCache x__)
    = Control.DeepSeq.rnf x__
_WorkflowActivationJob'StartWorkflow ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant StartWorkflow
_WorkflowActivationJob'StartWorkflow
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'StartWorkflow
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'StartWorkflow p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'FireTimer ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant FireTimer
_WorkflowActivationJob'FireTimer
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'FireTimer
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'FireTimer p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'UpdateRandomSeed ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant UpdateRandomSeed
_WorkflowActivationJob'UpdateRandomSeed
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'UpdateRandomSeed
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'UpdateRandomSeed p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'QueryWorkflow ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant QueryWorkflow
_WorkflowActivationJob'QueryWorkflow
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'QueryWorkflow
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'QueryWorkflow p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'CancelWorkflow ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant CancelWorkflow
_WorkflowActivationJob'CancelWorkflow
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'CancelWorkflow
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'CancelWorkflow p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'SignalWorkflow ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant SignalWorkflow
_WorkflowActivationJob'SignalWorkflow
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'SignalWorkflow
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'SignalWorkflow p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'ResolveActivity ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant ResolveActivity
_WorkflowActivationJob'ResolveActivity
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'ResolveActivity
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'ResolveActivity p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'NotifyHasPatch ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant NotifyHasPatch
_WorkflowActivationJob'NotifyHasPatch
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'NotifyHasPatch
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'NotifyHasPatch p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'ResolveChildWorkflowExecutionStart ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant ResolveChildWorkflowExecutionStart
_WorkflowActivationJob'ResolveChildWorkflowExecutionStart
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'ResolveChildWorkflowExecutionStart
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'ResolveChildWorkflowExecutionStart p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'ResolveChildWorkflowExecution ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant ResolveChildWorkflowExecution
_WorkflowActivationJob'ResolveChildWorkflowExecution
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'ResolveChildWorkflowExecution
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'ResolveChildWorkflowExecution p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'ResolveSignalExternalWorkflow ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant ResolveSignalExternalWorkflow
_WorkflowActivationJob'ResolveSignalExternalWorkflow
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'ResolveSignalExternalWorkflow
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'ResolveSignalExternalWorkflow p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'ResolveRequestCancelExternalWorkflow ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant ResolveRequestCancelExternalWorkflow
_WorkflowActivationJob'ResolveRequestCancelExternalWorkflow
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'ResolveRequestCancelExternalWorkflow
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'ResolveRequestCancelExternalWorkflow p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkflowActivationJob'RemoveFromCache ::
  Data.ProtoLens.Prism.Prism' WorkflowActivationJob'Variant RemoveFromCache
_WorkflowActivationJob'RemoveFromCache
  = Data.ProtoLens.Prism.prism'
      WorkflowActivationJob'RemoveFromCache
      (\ p__
         -> case p__ of
              (WorkflowActivationJob'RemoveFromCache p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \?temporal/sdk/core/workflow_activation/workflow_activation.proto\DC2\ESCcoresdk.workflow_activation\SUB\USgoogle/protobuf/timestamp.proto\SUB\RSgoogle/protobuf/duration.proto\SUB%temporal/api/failure/v1/message.proto\SUB$temporal/api/common/v1/message.proto\SUB$temporal/api/enums/v1/workflow.proto\SUB7temporal/sdk/core/activity_result/activity_result.proto\SUB5temporal/sdk/core/child_workflow/child_workflow.proto\SUB%temporal/sdk/core/common/common.proto\"\177\STX\n\
    \\DC2WorkflowActivation\DC2\NAK\n\
    \\ACKrun_id\CAN\SOH \SOH(\tR\ENQrunId\DC28\n\
    \\ttimestamp\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\ttimestamp\DC2!\n\
    \\fis_replaying\CAN\ETX \SOH(\bR\visReplaying\DC2%\n\
    \\SOhistory_length\CAN\EOT \SOH(\rR\rhistoryLength\DC2F\n\
    \\EOTjobs\CAN\ENQ \ETX(\v22.coresdk.workflow_activation.WorkflowActivationJobR\EOTjobs\DC28\n\
    \\CANavailable_internal_flags\CAN\ACK \ETX(\rR\SYNavailableInternalFlags\"\250\n\
    \\n\
    \\NAKWorkflowActivationJob\DC2S\n\
    \\SOstart_workflow\CAN\SOH \SOH(\v2*.coresdk.workflow_activation.StartWorkflowH\NULR\rstartWorkflow\DC2G\n\
    \\n\
    \fire_timer\CAN\STX \SOH(\v2&.coresdk.workflow_activation.FireTimerH\NULR\tfireTimer\DC2]\n\
    \\DC2update_random_seed\CAN\EOT \SOH(\v2-.coresdk.workflow_activation.UpdateRandomSeedH\NULR\DLEupdateRandomSeed\DC2S\n\
    \\SOquery_workflow\CAN\ENQ \SOH(\v2*.coresdk.workflow_activation.QueryWorkflowH\NULR\rqueryWorkflow\DC2V\n\
    \\SIcancel_workflow\CAN\ACK \SOH(\v2+.coresdk.workflow_activation.CancelWorkflowH\NULR\SOcancelWorkflow\DC2V\n\
    \\SIsignal_workflow\CAN\a \SOH(\v2+.coresdk.workflow_activation.SignalWorkflowH\NULR\SOsignalWorkflow\DC2Y\n\
    \\DLEresolve_activity\CAN\b \SOH(\v2,.coresdk.workflow_activation.ResolveActivityH\NULR\SIresolveActivity\DC2W\n\
    \\DLEnotify_has_patch\CAN\t \SOH(\v2+.coresdk.workflow_activation.NotifyHasPatchH\NULR\SOnotifyHasPatch\DC2\149\SOH\n\
    \&resolve_child_workflow_execution_start\CAN\n\
    \ \SOH(\v2?.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartH\NULR\"resolveChildWorkflowExecutionStart\DC2\133\SOH\n\
    \ resolve_child_workflow_execution\CAN\v \SOH(\v2:.coresdk.workflow_activation.ResolveChildWorkflowExecutionH\NULR\GSresolveChildWorkflowExecution\DC2\133\SOH\n\
    \ resolve_signal_external_workflow\CAN\f \SOH(\v2:.coresdk.workflow_activation.ResolveSignalExternalWorkflowH\NULR\GSresolveSignalExternalWorkflow\DC2\155\SOH\n\
    \(resolve_request_cancel_external_workflow\CAN\r \SOH(\v2A.coresdk.workflow_activation.ResolveRequestCancelExternalWorkflowH\NULR$resolveRequestCancelExternalWorkflow\DC2Z\n\
    \\DC1remove_from_cache\CAN2 \SOH(\v2,.coresdk.workflow_activation.RemoveFromCacheH\NULR\SIremoveFromCacheB\t\n\
    \\avariant\"\250\f\n\
    \\rStartWorkflow\DC2#\n\
    \\rworkflow_type\CAN\SOH \SOH(\tR\fworkflowType\DC2\US\n\
    \\vworkflow_id\CAN\STX \SOH(\tR\n\
    \workflowId\DC2=\n\
    \\targuments\CAN\ETX \ETX(\v2\US.temporal.api.common.v1.PayloadR\targuments\DC2'\n\
    \\SIrandomness_seed\CAN\EOT \SOH(\EOTR\SOrandomnessSeed\DC2Q\n\
    \\aheaders\CAN\ENQ \ETX(\v27.coresdk.workflow_activation.StartWorkflow.HeadersEntryR\aheaders\DC2\SUB\n\
    \\bidentity\CAN\ACK \SOH(\tR\bidentity\DC2]\n\
    \\DC4parent_workflow_info\CAN\a \SOH(\v2+.coresdk.common.NamespacedWorkflowExecutionR\DC2parentWorkflowInfo\DC2W\n\
    \\SUBworkflow_execution_timeout\CAN\b \SOH(\v2\EM.google.protobuf.DurationR\CANworkflowExecutionTimeout\DC2K\n\
    \\DC4workflow_run_timeout\CAN\t \SOH(\v2\EM.google.protobuf.DurationR\DC2workflowRunTimeout\DC2M\n\
    \\NAKworkflow_task_timeout\CAN\n\
    \ \SOH(\v2\EM.google.protobuf.DurationR\DC3workflowTaskTimeout\DC2D\n\
    \\UScontinued_from_execution_run_id\CAN\v \SOH(\tR\ESCcontinuedFromExecutionRunId\DC2^\n\
    \\DC3continued_initiator\CAN\f \SOH(\SO2-.temporal.api.enums.v1.ContinueAsNewInitiatorR\DC2continuedInitiator\DC2M\n\
    \\DC1continued_failure\CAN\r \SOH(\v2 .temporal.api.failure.v1.FailureR\DLEcontinuedFailure\DC2V\n\
    \\SYNlast_completion_result\CAN\SO \SOH(\v2 .temporal.api.common.v1.PayloadsR\DC4lastCompletionResult\DC23\n\
    \\SYNfirst_execution_run_id\CAN\SI \SOH(\tR\DC3firstExecutionRunId\DC2F\n\
    \\fretry_policy\CAN\DLE \SOH(\v2#.temporal.api.common.v1.RetryPolicyR\vretryPolicy\DC2\CAN\n\
    \\aattempt\CAN\DC1 \SOH(\ENQR\aattempt\DC2#\n\
    \\rcron_schedule\CAN\DC2 \SOH(\tR\fcronSchedule\DC2g\n\
    \\"workflow_execution_expiration_time\CAN\DC3 \SOH(\v2\SUB.google.protobuf.TimestampR\USworkflowExecutionExpirationTime\DC2e\n\
    \\"cron_schedule_to_schedule_interval\CAN\DC4 \SOH(\v2\EM.google.protobuf.DurationR\RScronScheduleToScheduleInterval\DC20\n\
    \\EOTmemo\CAN\NAK \SOH(\v2\FS.temporal.api.common.v1.MemoR\EOTmemo\DC2U\n\
    \\DC1search_attributes\CAN\SYN \SOH(\v2(.temporal.api.common.v1.SearchAttributesR\DLEsearchAttributes\DC29\n\
    \\n\
    \start_time\CAN\ETB \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\SUB[\n\
    \\fHeadersEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"\GS\n\
    \\tFireTimer\DC2\DLE\n\
    \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\"h\n\
    \\SIResolveActivity\DC2\DLE\n\
    \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2C\n\
    \\ACKresult\CAN\STX \SOH(\v2+.coresdk.activity_result.ActivityResolutionR\ACKresult\"\244\STX\n\
    \\"ResolveChildWorkflowExecutionStart\DC2\DLE\n\
    \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2f\n\
    \\tsucceeded\CAN\STX \SOH(\v2F.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartSuccessH\NULR\tsucceeded\DC2`\n\
    \\ACKfailed\CAN\ETX \SOH(\v2F.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartFailureH\NULR\ACKfailed\DC2h\n\
    \\tcancelled\CAN\EOT \SOH(\v2H.coresdk.workflow_activation.ResolveChildWorkflowExecutionStartCancelledH\NULR\tcancelledB\b\n\
    \\ACKstatus\"B\n\
    \)ResolveChildWorkflowExecutionStartSuccess\DC2\NAK\n\
    \\ACKrun_id\CAN\SOH \SOH(\tR\ENQrunId\"\199\SOH\n\
    \)ResolveChildWorkflowExecutionStartFailure\DC2\US\n\
    \\vworkflow_id\CAN\SOH \SOH(\tR\n\
    \workflowId\DC2#\n\
    \\rworkflow_type\CAN\STX \SOH(\tR\fworkflowType\DC2T\n\
    \\ENQcause\CAN\ETX \SOH(\SO2>.coresdk.child_workflow.StartChildWorkflowExecutionFailedCauseR\ENQcause\"i\n\
    \+ResolveChildWorkflowExecutionStartCancelled\DC2:\n\
    \\afailure\CAN\SOH \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\"v\n\
    \\GSResolveChildWorkflowExecution\DC2\DLE\n\
    \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2C\n\
    \\ACKresult\CAN\STX \SOH(\v2+.coresdk.child_workflow.ChildWorkflowResultR\ACKresult\";\n\
    \\DLEUpdateRandomSeed\DC2'\n\
    \\SIrandomness_seed\CAN\SOH \SOH(\EOTR\SOrandomnessSeed\"\184\STX\n\
    \\rQueryWorkflow\DC2\EM\n\
    \\bquery_id\CAN\SOH \SOH(\tR\aqueryId\DC2\GS\n\
    \\n\
    \query_type\CAN\STX \SOH(\tR\tqueryType\DC2=\n\
    \\targuments\CAN\ETX \ETX(\v2\US.temporal.api.common.v1.PayloadR\targuments\DC2Q\n\
    \\aheaders\CAN\ENQ \ETX(\v27.coresdk.workflow_activation.QueryWorkflow.HeadersEntryR\aheaders\SUB[\n\
    \\fHeadersEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"K\n\
    \\SOCancelWorkflow\DC29\n\
    \\adetails\CAN\SOH \ETX(\v2\US.temporal.api.common.v1.PayloadR\adetails\"\181\STX\n\
    \\SOSignalWorkflow\DC2\US\n\
    \\vsignal_name\CAN\SOH \SOH(\tR\n\
    \signalName\DC25\n\
    \\ENQinput\CAN\STX \ETX(\v2\US.temporal.api.common.v1.PayloadR\ENQinput\DC2\SUB\n\
    \\bidentity\CAN\ETX \SOH(\tR\bidentity\DC2R\n\
    \\aheaders\CAN\ENQ \ETX(\v28.coresdk.workflow_activation.SignalWorkflow.HeadersEntryR\aheaders\SUB[\n\
    \\fHeadersEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC25\n\
    \\ENQvalue\CAN\STX \SOH(\v2\US.temporal.api.common.v1.PayloadR\ENQvalue:\STX8\SOH\"+\n\
    \\SONotifyHasPatch\DC2\EM\n\
    \\bpatch_id\CAN\SOH \SOH(\tR\apatchId\"m\n\
    \\GSResolveSignalExternalWorkflow\DC2\DLE\n\
    \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2:\n\
    \\afailure\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\"t\n\
    \$ResolveRequestCancelExternalWorkflow\DC2\DLE\n\
    \\ETXseq\CAN\SOH \SOH(\rR\ETXseq\DC2:\n\
    \\afailure\CAN\STX \SOH(\v2 .temporal.api.failure.v1.FailureR\afailure\"\210\STX\n\
    \\SIRemoveFromCache\DC2\CAN\n\
    \\amessage\CAN\SOH \SOH(\tR\amessage\DC2S\n\
    \\ACKreason\CAN\STX \SOH(\SO2;.coresdk.workflow_activation.RemoveFromCache.EvictionReasonR\ACKreason\"\207\SOH\n\
    \\SOEvictionReason\DC2\SI\n\
    \\vUNSPECIFIED\DLE\NUL\DC2\SO\n\
    \\n\
    \CACHE_FULL\DLE\SOH\DC2\SO\n\
    \\n\
    \CACHE_MISS\DLE\STX\DC2\DC2\n\
    \\SONONDETERMINISM\DLE\ETX\DC2\r\n\
    \\tLANG_FAIL\DLE\EOT\DC2\DC2\n\
    \\SOLANG_REQUESTED\DLE\ENQ\DC2\DC2\n\
    \\SOTASK_NOT_FOUND\DLE\ACK\DC2\NAK\n\
    \\DC1UNHANDLED_COMMAND\DLE\a\DC2\t\n\
    \\ENQFATAL\DLE\b\DC2\US\n\
    \\ESCPAGINATION_OR_HISTORY_FETCH\DLE\tB.\234\STX+Temporalio::Bridge::Api::WorkflowActivationJ\230`\n\
    \\a\DC2\ENQ\NUL\NUL\141\STX\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\172\SOH\n\
    \\SOH\STX\DC2\ETX\ACK\NUL$\SUB\161\SOH*\n\
    \ Definitions of the different workflow activation jobs returned from [crate::Core::poll_task]. The\n\
    \ lang SDK applies these activation jobs to drive workflows.\n\
    \\n\
    \\b\n\
    \\SOH\b\DC2\ETX\a\NULD\n\
    \\t\n\
    \\STX\b-\DC2\ETX\a\NULD\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\t\NUL)\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\n\
    \\NUL(\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX\v\NUL/\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX\f\NUL.\n\
    \\t\n\
    \\STX\ETX\EOT\DC2\ETX\r\NUL.\n\
    \\t\n\
    \\STX\ETX\ENQ\DC2\ETX\SO\NULA\n\
    \\t\n\
    \\STX\ETX\ACK\DC2\ETX\SI\NUL?\n\
    \\t\n\
    \\STX\ETX\a\DC2\ETX\DLE\NUL/\n\
    \{\n\
    \\STX\EOT\NUL\DC2\EOT\DC4\NUL%\SOH\SUBo An instruction to the lang sdk to run some workflow code, whether for the first time or from\n\
    \ a cached state.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\DC4\b\SUB\n\
    \\187\SOH\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\ETB\EOT\SYN\SUB\173\SOH The id of the currently active run of the workflow. Also used as a cache key. There may\n\
    \ only ever be one active workflow task (and hence activation) of a run at one time.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\ETB\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\ETB\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\ETB\DC4\NAK\n\
    \k\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\EM\EOT,\SUB^ The current time as understood by the workflow, which is set by workflow task started events\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX\EM\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\EM\RS'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\EM*+\n\
    \E\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\ESC\EOT\SUB\SUB8 Whether or not the activation is replaying past events\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX\ESC\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\ESC\t\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\ESC\CAN\EM\n\
    \\160\SOH\n\
    \\EOT\EOT\NUL\STX\ETX\DC2\ETX\RS\EOT\RS\SUB\146\SOH Current history length as determined by the event id of the most recently processed event.\n\
    \ This ensures that the number is always deterministic\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ENQ\DC2\ETX\RS\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\SOH\DC2\ETX\RS\v\EM\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ETX\ETX\DC2\ETX\RS\FS\GS\n\
    \<\n\
    \\EOT\EOT\NUL\STX\EOT\DC2\ETX \EOT,\SUB/ The things to do upon activating the workflow\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\EOT\DC2\ETX \EOT\f\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ACK\DC2\ETX \r\"\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\SOH\DC2\ETX #'\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\EOT\ETX\DC2\ETX *+\n\
    \\227\SOH\n\
    \\EOT\EOT\NUL\STX\ENQ\DC2\ETX$\EOT1\SUB\213\SOH Internal flags which are available for use by lang. If `is_replaying` is false, all\n\
    \ internal flags may be used. This is not a delta - all previously used flags always\n\
    \ appear since this representation is cheap.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\EOT\DC2\ETX$\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ENQ\DC2\ETX$\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\SOH\DC2\ETX$\DC4,\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\ENQ\ETX\DC2\ETX$/0\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT'\NULJ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX'\b\GS\n\
    \\f\n\
    \\EOT\EOT\SOH\b\NUL\DC2\EOT(\EOTI\ENQ\n\
    \\f\n\
    \\ENQ\EOT\SOH\b\NUL\SOH\DC2\ETX(\n\
    \\DC1\n\
    \2\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX*\b)\SUB% Begin a workflow for the first time\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX*\b\NAK\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX*\SYN$\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX*'(\n\
    \^\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX,\b!\SUBQ A timer has fired, allowing whatever was waiting on it (if anything) to proceed\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX,\b\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX,\DC2\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX,\US \n\
    \G\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX.\b0\SUB: Workflow was reset. The randomness seed must be updated.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETX.\b\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX.\EM+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX../\n\
    \<\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX0\b)\SUB/ A request to query the workflow was received.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ACK\DC2\ETX0\b\NAK\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX0\SYN$\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX0'(\n\
    \=\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX2\b+\SUB0 A request to cancel the workflow was received.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ACK\DC2\ETX2\b\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX2\ETB&\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX2)*\n\
    \=\n\
    \\EOT\EOT\SOH\STX\ENQ\DC2\ETX4\b+\SUB0 A request to signal the workflow was received.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ACK\DC2\ETX4\b\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\SOH\DC2\ETX4\ETB&\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ETX\DC2\ETX4)*\n\
    \W\n\
    \\EOT\EOT\SOH\STX\ACK\DC2\ETX6\b-\SUBJ An activity was resolved, result could be completed, failed or cancelled\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ACK\DC2\ETX6\b\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\SOH\DC2\ETX6\CAN(\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ETX\DC2\ETX6+,\n\
    \\206\SOH\n\
    \\EOT\EOT\SOH\STX\a\DC2\ETX:\b,\SUB\192\SOH A patch marker has been detected and lang is being told that change exists. This\n\
    \ job is strange in that it is sent pre-emptively to lang without any corresponding\n\
    \ command being sent first.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\ACK\DC2\ETX:\b\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\SOH\DC2\ETX:\ETB'\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\a\ETX\DC2\ETX:*+\n\
    \H\n\
    \\EOT\EOT\SOH\STX\b\DC2\ETX<\bW\SUB; A child workflow execution has started or failed to start\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\b\ACK\DC2\ETX<\b*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\b\SOH\DC2\ETX<+Q\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\b\ETX\DC2\ETX<TV\n\
    \Q\n\
    \\EOT\EOT\SOH\STX\t\DC2\ETX>\bL\SUBD A child workflow was resolved, result could be completed or failed\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\t\ACK\DC2\ETX>\b%\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\t\SOH\DC2\ETX>&F\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\t\ETX\DC2\ETX>IK\n\
    \A\n\
    \\EOT\EOT\SOH\STX\n\
    \\DC2\ETX@\bL\SUB4 An attempt to signal an external workflow resolved\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\n\
    \\ACK\DC2\ETX@\b%\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\n\
    \\SOH\DC2\ETX@&F\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\n\
    \\ETX\DC2\ETX@IK\n\
    \A\n\
    \\EOT\EOT\SOH\STX\v\DC2\ETXB\b[\SUB4 An attempt to cancel an external workflow resolved\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\v\ACK\DC2\ETXB\b,\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\v\SOH\DC2\ETXB-U\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\v\ETX\DC2\ETXBXZ\n\
    \\158\STX\n\
    \\EOT\EOT\SOH\STX\f\DC2\ETXH\b/\SUB\144\STX Remove the workflow identified by the [WorkflowActivation] containing this job from the cache\n\
    \ after performing the activation.\n\
    \\n\
    \ If other job variant are present in the list, this variant will be the last job in the\n\
    \ job list. The string value is a reason for eviction.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\f\ACK\DC2\ETXH\b\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\f\SOH\DC2\ETXH\CAN)\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\f\ETX\DC2\ETXH,.\n\
    \#\n\
    \\STX\EOT\STX\DC2\ENQM\NUL\128\SOH\SOH\SUB\SYN Start a new workflow\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETXM\b\NAK\n\
    \Q\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETXO\EOT\GS\SUBD The identifier the lang-specific sdk uses to execute workflow code\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETXO\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETXO\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETXO\ESC\FS\n\
    \:\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXQ\EOT\ESC\SUB- The workflow id used on the temporal server\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETXQ\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXQ\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXQ\EM\SUB\n\
    \*\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETXS\EOT:\SUB\GS Inputs to the workflow code\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\EOT\DC2\ETXS\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ACK\DC2\ETXS\r+\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETXS,5\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETXS89\n\
    \\148\SOH\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETXV\EOT\US\SUB\134\SOH The seed must be used to initialize the random generator used by SDK.\n\
    \ RandomSeedUpdatedAttributes are used to deliver seed updates.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ENQ\DC2\ETXV\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETXV\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETXV\GS\RS\n\
    \o\n\
    \\EOT\EOT\STX\STX\EOT\DC2\ETXX\EOT<\SUBb Used to add metadata e.g. for tracing and auth, meant to be read and written to by interceptors.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ACK\DC2\ETXX\EOT/\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\ETXX07\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\ETXX:;\n\
    \B\n\
    \\EOT\EOT\STX\STX\ENQ\DC2\ETXZ\EOT\CAN\SUB5 Identity of the client who requested this execution\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\ENQ\DC2\ETXZ\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\SOH\DC2\ETXZ\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ENQ\ETX\DC2\ETXZ\SYN\ETB\n\
    \H\n\
    \\EOT\EOT\STX\STX\ACK\DC2\ETX\\\EOT@\SUB; If this workflow is a child, information about the parent\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ACK\ACK\DC2\ETX\\\EOT&\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ACK\SOH\DC2\ETX\\';\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ACK\ETX\DC2\ETX\\>?\n\
    \V\n\
    \\EOT\EOT\STX\STX\a\DC2\ETX^\EOT<\SUBI Total workflow execution timeout including retries and continue as new.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\a\ACK\DC2\ETX^\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\a\SOH\DC2\ETX^\GS7\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\a\ETX\DC2\ETX^:;\n\
    \0\n\
    \\EOT\EOT\STX\STX\b\DC2\ETX`\EOT6\SUB# Timeout of a single workflow run.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\ACK\DC2\ETX`\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\SOH\DC2\ETX`\GS1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\b\ETX\DC2\ETX`45\n\
    \1\n\
    \\EOT\EOT\STX\STX\t\DC2\ETXb\EOT8\SUB$ Timeout of a single workflow task.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\ACK\DC2\ETXb\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\SOH\DC2\ETXb\GS2\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\t\ETX\DC2\ETXb57\n\
    \~\n\
    \\EOT\EOT\STX\STX\n\
    \\DC2\ETXe\EOT0\SUBq Run id of the previous workflow which continued-as-new or retired or cron executed into this\n\
    \ workflow, if any.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\n\
    \\ENQ\DC2\ETXe\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\n\
    \\SOH\DC2\ETXe\v*\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\n\
    \\ETX\DC2\ETXe-/\n\
    \W\n\
    \\EOT\EOT\STX\STX\v\DC2\ETXg\EOTJ\SUBJ If this workflow was a continuation, indicates the type of continuation.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\v\ACK\DC2\ETXg\EOT0\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\v\SOH\DC2\ETXg1D\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\v\ETX\DC2\ETXgGI\n\
    \e\n\
    \\EOT\EOT\STX\STX\f\DC2\ETXi\EOT;\SUBX If this workflow was a continuation and that continuation failed, the details of that.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\f\ACK\DC2\ETXi\EOT#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\f\SOH\DC2\ETXi$5\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\f\ETX\DC2\ETXi8:\n\
    \h\n\
    \\EOT\EOT\STX\STX\r\DC2\ETXk\EOT@\SUB[ If this workflow was a continuation and that continuation completed, the details of that.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\r\ACK\DC2\ETXk\EOT#\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\r\SOH\DC2\ETXk$:\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\r\ETX\DC2\ETXk=?\n\
    \b\n\
    \\EOT\EOT\STX\STX\SO\DC2\ETXm\EOT'\SUBU This is the very first run id the workflow ever had, following continuation chains.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SO\ENQ\DC2\ETXm\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SO\SOH\DC2\ETXm\v!\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SO\ETX\DC2\ETXm$&\n\
    \+\n\
    \\EOT\EOT\STX\STX\SI\DC2\ETXo\EOT9\SUB\RS This workflow's retry policy\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SI\ACK\DC2\ETXo\EOT&\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SI\SOH\DC2\ETXo'3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SI\ETX\DC2\ETXo68\n\
    \X\n\
    \\EOT\EOT\STX\STX\DLE\DC2\ETXq\EOT\ETB\SUBK Starting at 1, the number of times we have tried to execute this workflow\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DLE\ENQ\DC2\ETXq\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DLE\SOH\DC2\ETXq\n\
    \\DC1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DLE\ETX\DC2\ETXq\DC4\SYN\n\
    \L\n\
    \\EOT\EOT\STX\STX\DC1\DC2\ETXs\EOT\RS\SUB? If this workflow runs on a cron schedule, it will appear here\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC1\ENQ\DC2\ETXs\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC1\SOH\DC2\ETXs\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC1\ETX\DC2\ETXs\ESC\GS\n\
    \\142\SOH\n\
    \\EOT\EOT\STX\STX\DC2\DC2\ETXv\EOTF\SUB\128\SOH The absolute time at which the workflow will be timed out.\n\
    \ This is passed without change to the next run/retry of a workflow.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC2\ACK\DC2\ETXv\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC2\SOH\DC2\ETXv\RS@\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC2\ETX\DC2\ETXvCE\n\
    \\184\SOH\n\
    \\EOT\EOT\STX\STX\DC3\DC2\ETXy\EOTE\SUB\170\SOH For a cron workflow, this contains the amount of time between when this iteration of\n\
    \ the cron workflow was scheduled and when it should run next per its cron_schedule.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC3\ACK\DC2\ETXy\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC3\SOH\DC2\ETXy\GS?\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC3\ETX\DC2\ETXyBD\n\
    \ \n\
    \\EOT\EOT\STX\STX\DC4\DC2\ETX{\EOT*\SUB\DC3 User-defined memo\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC4\ACK\DC2\ETX{\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC4\SOH\DC2\ETX{ $\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\DC4\ETX\DC2\ETX{')\n\
    \O\n\
    \\EOT\EOT\STX\STX\NAK\DC2\ETX}\EOTC\SUBB Search attributes created/updated when this workflow was started\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NAK\ACK\DC2\ETX}\EOT+\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NAK\SOH\DC2\ETX},=\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NAK\ETX\DC2\ETX}@B\n\
    \J\n\
    \\EOT\EOT\STX\STX\SYN\DC2\ETX\DEL\EOT.\SUB= When the workflow execution started event was first written\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SYN\ACK\DC2\ETX\DEL\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SYN\SOH\DC2\ETX\DEL\RS(\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SYN\ETX\DC2\ETX\DEL+-\n\
    \8\n\
    \\STX\EOT\ETX\DC2\ACK\131\SOH\NUL\134\SOH\SOH\SUB* Notify a workflow that a timer has fired\n\
    \\n\
    \\v\n\
    \\ETX\EOT\ETX\SOH\DC2\EOT\131\SOH\b\DC1\n\
    \[\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\EOT\133\SOH\EOT\DC3\SUBM Sequence number as provided by lang in the corresponding StartTimer command\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\EOT\133\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\EOT\133\SOH\v\SO\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\EOT\133\SOH\DC1\DC2\n\
    \D\n\
    \\STX\EOT\EOT\DC2\ACK\137\SOH\NUL\141\SOH\SOH\SUB6 Notify a workflow that an activity has been resolved\n\
    \\n\
    \\v\n\
    \\ETX\EOT\EOT\SOH\DC2\EOT\137\SOH\b\ETB\n\
    \a\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\EOT\139\SOH\EOT\DC3\SUBS Sequence number as provided by lang in the corresponding ScheduleActivity command\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\EOT\139\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\EOT\139\SOH\v\SO\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\EOT\139\SOH\DC1\DC2\n\
    \\f\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\EOT\140\SOH\EOT2\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\SOH\ACK\DC2\EOT\140\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\EOT\140\SOH'-\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\EOT\140\SOH01\n\
    \x\n\
    \\STX\EOT\ENQ\DC2\ACK\145\SOH\NUL\153\SOH\SOH\SUBj Notify a workflow that a start child workflow execution request has succeeded, failed or was\n\
    \ cancelled.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\ENQ\SOH\DC2\EOT\145\SOH\b*\n\
    \l\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\EOT\147\SOH\EOT\DC3\SUB^ Sequence number as provided by lang in the corresponding StartChildWorkflowExecution command\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\EOT\147\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\EOT\147\SOH\v\SO\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\EOT\147\SOH\DC1\DC2\n\
    \\SO\n\
    \\EOT\EOT\ENQ\b\NUL\DC2\ACK\148\SOH\EOT\152\SOH\ENQ\n\
    \\r\n\
    \\ENQ\EOT\ENQ\b\NUL\SOH\DC2\EOT\148\SOH\n\
    \\DLE\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\EOT\149\SOH\b@\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\EOT\149\SOH\b1\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\EOT\149\SOH2;\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\EOT\149\SOH>?\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\STX\DC2\EOT\150\SOH\b=\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\STX\ACK\DC2\EOT\150\SOH\b1\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\STX\SOH\DC2\EOT\150\SOH28\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\STX\ETX\DC2\EOT\150\SOH;<\n\
    \\f\n\
    \\EOT\EOT\ENQ\STX\ETX\DC2\EOT\151\SOH\bB\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\ETX\ACK\DC2\EOT\151\SOH\b3\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\ETX\SOH\DC2\EOT\151\SOH4=\n\
    \\r\n\
    \\ENQ\EOT\ENQ\STX\ETX\ETX\DC2\EOT\151\SOH@A\n\
    \.\n\
    \\STX\EOT\ACK\DC2\ACK\156\SOH\NUL\158\SOH\SOH\SUB  Simply pass the run_id to lang\n\
    \\n\
    \\v\n\
    \\ETX\EOT\ACK\SOH\DC2\EOT\156\SOH\b1\n\
    \\f\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\EOT\157\SOH\EOT\SYN\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\EOT\157\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\EOT\157\SOH\v\DC1\n\
    \\r\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\EOT\157\SOH\DC4\NAK\n\
    \1\n\
    \\STX\EOT\a\DC2\ACK\161\SOH\NUL\167\SOH\SOH\SUB# Provide lang the cause of failure\n\
    \\n\
    \\v\n\
    \\ETX\EOT\a\SOH\DC2\EOT\161\SOH\b1\n\
    \\132\SOH\n\
    \\EOT\EOT\a\STX\NUL\DC2\EOT\164\SOH\EOT\ESC\SUBv Lang should have this information but it's more convenient to pass it back\n\
    \ for error construction on the lang side.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\EOT\164\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\EOT\164\SOH\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\EOT\164\SOH\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\a\STX\SOH\DC2\EOT\165\SOH\EOT\GS\n\
    \\r\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\EOT\165\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\EOT\165\SOH\v\CAN\n\
    \\r\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\EOT\165\SOH\ESC\FS\n\
    \\f\n\
    \\EOT\EOT\a\STX\STX\DC2\EOT\166\SOH\EOTD\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\ACK\DC2\EOT\166\SOH\EOT9\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\EOT\166\SOH:?\n\
    \\r\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\EOT\166\SOHBC\n\
    \\153\SOH\n\
    \\STX\EOT\b\DC2\ACK\171\SOH\NUL\173\SOH\SOH\SUB\138\SOH `failure` should be ChildWorkflowFailure with cause set to CancelledFailure.\n\
    \ The failure is constructed in core for lang's convenience.\n\
    \\n\
    \\v\n\
    \\ETX\EOT\b\SOH\DC2\EOT\171\SOH\b3\n\
    \\f\n\
    \\EOT\EOT\b\STX\NUL\DC2\EOT\172\SOH\STX.\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\ACK\DC2\EOT\172\SOH\STX!\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\EOT\172\SOH\")\n\
    \\r\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\EOT\172\SOH,-\n\
    \S\n\
    \\STX\EOT\t\DC2\ACK\176\SOH\NUL\180\SOH\SOH\SUBE Notify a workflow that a child workflow execution has been resolved\n\
    \\n\
    \\v\n\
    \\ETX\EOT\t\SOH\DC2\EOT\176\SOH\b%\n\
    \l\n\
    \\EOT\EOT\t\STX\NUL\DC2\EOT\178\SOH\EOT\DC3\SUB^ Sequence number as provided by lang in the corresponding StartChildWorkflowExecution command\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ENQ\DC2\EOT\178\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\EOT\178\SOH\v\SO\n\
    \\r\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\EOT\178\SOH\DC1\DC2\n\
    \\f\n\
    \\EOT\EOT\t\STX\SOH\DC2\EOT\179\SOH\EOT2\n\
    \\r\n\
    \\ENQ\EOT\t\STX\SOH\ACK\DC2\EOT\179\SOH\EOT&\n\
    \\r\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\EOT\179\SOH'-\n\
    \\r\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\EOT\179\SOH01\n\
    \1\n\
    \\STX\EOT\n\
    \\DC2\ACK\183\SOH\NUL\185\SOH\SOH\SUB# Update the workflow's random seed\n\
    \\n\
    \\v\n\
    \\ETX\EOT\n\
    \\SOH\DC2\EOT\183\SOH\b\CAN\n\
    \\f\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\EOT\184\SOH\EOT\US\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\EOT\184\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\EOT\184\SOH\v\SUB\n\
    \\r\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\EOT\184\SOH\GS\RS\n\
    \ \n\
    \\STX\EOT\v\DC2\ACK\188\SOH\NUL\198\SOH\SOH\SUB\DC2 Query a workflow\n\
    \\n\
    \\v\n\
    \\ETX\EOT\v\SOH\DC2\EOT\188\SOH\b\NAK\n\
    \\137\STX\n\
    \\EOT\EOT\v\STX\NUL\DC2\EOT\192\SOH\EOT\CAN\SUB\250\SOH For PollWFTResp `query` field, this will be set to the special value `legacy`. For the\n\
    \ `queries` field, the server provides a unique identifier. If it is a `legacy` query,\n\
    \ lang cannot issue any commands in response other than to answer the query.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ENQ\DC2\EOT\192\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\EOT\192\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\EOT\192\SOH\SYN\ETB\n\
    \4\n\
    \\EOT\EOT\v\STX\SOH\DC2\EOT\194\SOH\EOT\SUB\SUB& The query's function/method/etc name\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ENQ\DC2\EOT\194\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\EOT\194\SOH\v\NAK\n\
    \\r\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\EOT\194\SOH\CAN\EM\n\
    \\f\n\
    \\EOT\EOT\v\STX\STX\DC2\EOT\195\SOH\EOT:\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\EOT\DC2\EOT\195\SOH\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ACK\DC2\EOT\195\SOH\r+\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\SOH\DC2\EOT\195\SOH,5\n\
    \\r\n\
    \\ENQ\EOT\v\STX\STX\ETX\DC2\EOT\195\SOH89\n\
    \-\n\
    \\EOT\EOT\v\STX\ETX\DC2\EOT\197\SOH\EOT<\SUB\US Headers attached to the query\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\ACK\DC2\EOT\197\SOH\EOT/\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\SOH\DC2\EOT\197\SOH07\n\
    \\r\n\
    \\ENQ\EOT\v\STX\ETX\ETX\DC2\EOT\197\SOH:;\n\
    \)\n\
    \\STX\EOT\f\DC2\ACK\201\SOH\NUL\204\SOH\SOH\SUB\ESC Cancel a running workflow\n\
    \\n\
    \\v\n\
    \\ETX\EOT\f\SOH\DC2\EOT\201\SOH\b\SYN\n\
    \9\n\
    \\EOT\EOT\f\STX\NUL\DC2\EOT\203\SOH\EOT8\SUB+ Information from the cancellation request\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\EOT\DC2\EOT\203\SOH\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ACK\DC2\EOT\203\SOH\r+\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\EOT\203\SOH,3\n\
    \\r\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\EOT\203\SOH67\n\
    \+\n\
    \\STX\EOT\r\DC2\ACK\207\SOH\NUL\214\SOH\SOH\SUB\GS Send a signal to a workflow\n\
    \\n\
    \\v\n\
    \\ETX\EOT\r\SOH\DC2\EOT\207\SOH\b\SYN\n\
    \\f\n\
    \\EOT\EOT\r\STX\NUL\DC2\EOT\208\SOH\EOT\ESC\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ENQ\DC2\EOT\208\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\SOH\DC2\EOT\208\SOH\v\SYN\n\
    \\r\n\
    \\ENQ\EOT\r\STX\NUL\ETX\DC2\EOT\208\SOH\EM\SUB\n\
    \\f\n\
    \\EOT\EOT\r\STX\SOH\DC2\EOT\209\SOH\EOT6\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\EOT\DC2\EOT\209\SOH\EOT\f\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ACK\DC2\EOT\209\SOH\r+\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\SOH\DC2\EOT\209\SOH,1\n\
    \\r\n\
    \\ENQ\EOT\r\STX\SOH\ETX\DC2\EOT\209\SOH45\n\
    \4\n\
    \\EOT\EOT\r\STX\STX\DC2\EOT\211\SOH\EOT\CAN\SUB& Identity of the sender of the signal\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ENQ\DC2\EOT\211\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\SOH\DC2\EOT\211\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\r\STX\STX\ETX\DC2\EOT\211\SOH\SYN\ETB\n\
    \.\n\
    \\EOT\EOT\r\STX\ETX\DC2\EOT\213\SOH\EOT<\SUB  Headers attached to the signal\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ACK\DC2\EOT\213\SOH\EOT/\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\SOH\DC2\EOT\213\SOH07\n\
    \\r\n\
    \\ENQ\EOT\r\STX\ETX\ETX\DC2\EOT\213\SOH:;\n\
    \\176\SOH\n\
    \\STX\EOT\SO\DC2\ACK\218\SOH\NUL\220\SOH\SOH\SUB\161\SOH Inform lang what the result of a call to `patched` or similar API should be -- this is always\n\
    \ sent pre-emptively, so any time it is sent the change is present\n\
    \\n\
    \\v\n\
    \\ETX\EOT\SO\SOH\DC2\EOT\218\SOH\b\SYN\n\
    \\f\n\
    \\EOT\EOT\SO\STX\NUL\DC2\EOT\219\SOH\EOT\CAN\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ENQ\DC2\EOT\219\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\EOT\219\SOH\v\DC3\n\
    \\r\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\EOT\219\SOH\SYN\ETB\n\
    \\f\n\
    \\STX\EOT\SI\DC2\ACK\222\SOH\NUL\229\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\SI\SOH\DC2\EOT\222\SOH\b%\n\
    \q\n\
    \\EOT\EOT\SI\STX\NUL\DC2\EOT\225\SOH\EOT\DC3\SUBc Sequence number as provided by lang in the corresponding SignalExternalWorkflowExecution\n\
    \ command\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ENQ\DC2\EOT\225\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\EOT\225\SOH\v\SO\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\EOT\225\SOH\DC1\DC2\n\
    \v\n\
    \\EOT\EOT\SI\STX\SOH\DC2\EOT\228\SOH\EOT0\SUBh If populated, this signal either failed to be sent or was cancelled depending on failure\n\
    \ type / info.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ACK\DC2\EOT\228\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\SOH\DC2\EOT\228\SOH$+\n\
    \\r\n\
    \\ENQ\EOT\SI\STX\SOH\ETX\DC2\EOT\228\SOH./\n\
    \\f\n\
    \\STX\EOT\DLE\DC2\ACK\231\SOH\NUL\238\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\DLE\SOH\DC2\EOT\231\SOH\b,\n\
    \x\n\
    \\EOT\EOT\DLE\STX\NUL\DC2\EOT\234\SOH\EOT\DC3\SUBj Sequence number as provided by lang in the corresponding\n\
    \ RequestCancelExternalWorkflowExecution command\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ENQ\DC2\EOT\234\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\SOH\DC2\EOT\234\SOH\v\SO\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\NUL\ETX\DC2\EOT\234\SOH\DC1\DC2\n\
    \v\n\
    \\EOT\EOT\DLE\STX\SOH\DC2\EOT\237\SOH\EOT0\SUBh If populated, this signal either failed to be sent or was cancelled depending on failure\n\
    \ type / info.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\ACK\DC2\EOT\237\SOH\EOT#\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\SOH\DC2\EOT\237\SOH$+\n\
    \\r\n\
    \\ENQ\EOT\DLE\STX\SOH\ETX\DC2\EOT\237\SOH./\n\
    \\f\n\
    \\STX\EOT\DC1\DC2\ACK\240\SOH\NUL\141\STX\SOH\n\
    \\v\n\
    \\ETX\EOT\DC1\SOH\DC2\EOT\240\SOH\b\ETB\n\
    \\f\n\
    \\EOT\EOT\DC1\STX\NUL\DC2\EOT\241\SOH\EOT\ETB\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ENQ\DC2\EOT\241\SOH\EOT\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\SOH\DC2\EOT\241\SOH\v\DC2\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\NUL\ETX\DC2\EOT\241\SOH\NAK\SYN\n\
    \\SO\n\
    \\EOT\EOT\DC1\EOT\NUL\DC2\ACK\243\SOH\EOT\139\STX\ENQ\n\
    \\r\n\
    \\ENQ\EOT\DC1\EOT\NUL\SOH\DC2\EOT\243\SOH\t\ETB\n\
    \\SO\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\NUL\DC2\EOT\244\SOH\b\CAN\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\NUL\SOH\DC2\EOT\244\SOH\b\DC3\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\NUL\STX\DC2\EOT\244\SOH\SYN\ETB\n\
    \(\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\SOH\DC2\EOT\246\SOH\b\ETB\SUB\CAN Workflow cache is full\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\SOH\SOH\DC2\EOT\246\SOH\b\DC2\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\SOH\STX\DC2\EOT\246\SOH\NAK\SYN\n\
    \\176\SOH\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\STX\DC2\EOT\249\SOH\b\ETB\SUB\159\SOH Workflow received a partial task but was not in the cache. Typically it won't be in the\n\
    \ lang cache either at this point, but we send an eviction to be sure.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\STX\SOH\DC2\EOT\249\SOH\b\DC2\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\STX\STX\DC2\EOT\249\SOH\NAK\SYN\n\
    \J\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\ETX\DC2\EOT\251\SOH\b\ESC\SUB: The workflow produced results inconsistent with history.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\ETX\SOH\DC2\EOT\251\SOH\b\SYN\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\ETX\STX\DC2\EOT\251\SOH\EM\SUB\n\
    \Q\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\EOT\DC2\EOT\253\SOH\b\SYN\SUBA The lang side completed the workflow activation with a failure.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\EOT\SOH\DC2\EOT\253\SOH\b\DC1\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\EOT\STX\DC2\EOT\253\SOH\DC4\NAK\n\
    \N\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\ENQ\DC2\EOT\255\SOH\b\ESC\SUB> The lang side explicitly requested this workflow be evicted.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\ENQ\SOH\DC2\EOT\255\SOH\b\SYN\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\ENQ\STX\DC2\EOT\255\SOH\EM\SUB\n\
    \\173\SOH\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\ACK\DC2\EOT\130\STX\b\ESC\SUB\156\SOH The workflow task we tried to respond to didn't exist. The workflow might have already\n\
    \ finished, or the WFT timed out but we didn't learn about that yet.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\ACK\SOH\DC2\EOT\130\STX\b\SYN\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\ACK\STX\DC2\EOT\130\STX\EM\SUB\n\
    \\163\SOH\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\a\DC2\EOT\133\STX\b\RS\SUB\146\SOH There was new work that must be handled while we attempted to complete the WFT. Ex:\n\
    \ a new signal came in while trying to complete the workflow.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\a\SOH\DC2\EOT\133\STX\b\EM\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\a\STX\DC2\EOT\133\STX\FS\GS\n\
    \\186\SOH\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\b\DC2\EOT\136\STX\b\DC2\SUB\169\SOH There was some fatal error processing the workflow, typically an internal error, but\n\
    \ can also happen if then network drops out while paginating. Check message string.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\b\SOH\DC2\EOT\136\STX\b\r\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\b\STX\DC2\EOT\136\STX\DLE\DC1\n\
    \O\n\
    \\ACK\EOT\DC1\EOT\NUL\STX\t\DC2\EOT\138\STX\b(\SUB? Something went wrong attempting to fetch more history events.\n\
    \\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\t\SOH\DC2\EOT\138\STX\b#\n\
    \\SI\n\
    \\a\EOT\DC1\EOT\NUL\STX\t\STX\DC2\EOT\138\STX&'\n\
    \\f\n\
    \\EOT\EOT\DC1\STX\SOH\DC2\EOT\140\STX\EOT\RS\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\ACK\DC2\EOT\140\STX\EOT\DC2\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\SOH\DC2\EOT\140\STX\DC3\EM\n\
    \\r\n\
    \\ENQ\EOT\DC1\STX\SOH\ETX\DC2\EOT\140\STX\FS\GSb\ACKproto3"