{- This file was auto-generated from temporal/api/query/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Query.V1.Message (
        QueryRejected(), WorkflowQuery(), WorkflowQueryResult()
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
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Query
import qualified Proto.Temporal.Api.Enums.V1.Workflow
{- | Fields :
     
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.status' @:: Lens' QueryRejected Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus@ -}
data QueryRejected
  = QueryRejected'_constructor {_QueryRejected'status :: !Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus,
                                _QueryRejected'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show QueryRejected where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField QueryRejected "status" Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _QueryRejected'status
           (\ x__ y__ -> x__ {_QueryRejected'status = y__}))
        Prelude.id
instance Data.ProtoLens.Message QueryRejected where
  messageName _
    = Data.Text.pack "temporal.api.query.v1.QueryRejected"
  packedMessageDescriptor _
    = "\n\
      \\rQueryRejected\DC2F\n\
      \\ACKstatus\CAN\SOH \SOH(\SO2..temporal.api.enums.v1.WorkflowExecutionStatusR\ACKstatus"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        status__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "status"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Workflow.WorkflowExecutionStatus)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"status")) ::
              Data.ProtoLens.FieldDescriptor QueryRejected
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, status__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _QueryRejected'_unknownFields
        (\ x__ y__ -> x__ {_QueryRejected'_unknownFields = y__})
  defMessage
    = QueryRejected'_constructor
        {_QueryRejected'status = Data.ProtoLens.fieldDefault,
         _QueryRejected'_unknownFields = []}
  parseMessage
    = let
        loop ::
          QueryRejected -> Data.ProtoLens.Encoding.Bytes.Parser QueryRejected
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
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "status"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"status") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "QueryRejected"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"status") _x
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData QueryRejected where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_QueryRejected'_unknownFields x__)
             (Control.DeepSeq.deepseq (_QueryRejected'status x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.queryType' @:: Lens' WorkflowQuery Data.Text.Text@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.queryArgs' @:: Lens' WorkflowQuery Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.maybe'queryArgs' @:: Lens' WorkflowQuery (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.header' @:: Lens' WorkflowQuery Proto.Temporal.Api.Common.V1.Message.Header@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.maybe'header' @:: Lens' WorkflowQuery (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header)@ -}
data WorkflowQuery
  = WorkflowQuery'_constructor {_WorkflowQuery'queryType :: !Data.Text.Text,
                                _WorkflowQuery'queryArgs :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                _WorkflowQuery'header :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header),
                                _WorkflowQuery'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowQuery where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowQuery "queryType" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQuery'queryType
           (\ x__ y__ -> x__ {_WorkflowQuery'queryType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowQuery "queryArgs" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQuery'queryArgs
           (\ x__ y__ -> x__ {_WorkflowQuery'queryArgs = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowQuery "maybe'queryArgs" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQuery'queryArgs
           (\ x__ y__ -> x__ {_WorkflowQuery'queryArgs = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowQuery "header" Proto.Temporal.Api.Common.V1.Message.Header where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQuery'header
           (\ x__ y__ -> x__ {_WorkflowQuery'header = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowQuery "maybe'header" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Header) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQuery'header
           (\ x__ y__ -> x__ {_WorkflowQuery'header = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowQuery where
  messageName _
    = Data.Text.pack "temporal.api.query.v1.WorkflowQuery"
  packedMessageDescriptor _
    = "\n\
      \\rWorkflowQuery\DC2\GS\n\
      \\n\
      \query_type\CAN\SOH \SOH(\tR\tqueryType\DC2?\n\
      \\n\
      \query_args\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\tqueryArgs\DC26\n\
      \\ACKheader\CAN\ETX \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        queryType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "query_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"queryType")) ::
              Data.ProtoLens.FieldDescriptor WorkflowQuery
        queryArgs__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "query_args"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'queryArgs")) ::
              Data.ProtoLens.FieldDescriptor WorkflowQuery
        header__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "header"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Header)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'header")) ::
              Data.ProtoLens.FieldDescriptor WorkflowQuery
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, queryType__field_descriptor),
           (Data.ProtoLens.Tag 2, queryArgs__field_descriptor),
           (Data.ProtoLens.Tag 3, header__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowQuery'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowQuery'_unknownFields = y__})
  defMessage
    = WorkflowQuery'_constructor
        {_WorkflowQuery'queryType = Data.ProtoLens.fieldDefault,
         _WorkflowQuery'queryArgs = Prelude.Nothing,
         _WorkflowQuery'header = Prelude.Nothing,
         _WorkflowQuery'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowQuery -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowQuery
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
                                       "query_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"queryType") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "query_args"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"queryArgs") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "header"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"header") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowQuery"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"queryType") _x
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
                       (Data.ProtoLens.Field.field @"maybe'queryArgs") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData WorkflowQuery where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowQuery'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowQuery'queryType x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowQuery'queryArgs x__)
                   (Control.DeepSeq.deepseq (_WorkflowQuery'header x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.resultType' @:: Lens' WorkflowQueryResult Proto.Temporal.Api.Enums.V1.Query.QueryResultType@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.answer' @:: Lens' WorkflowQueryResult Proto.Temporal.Api.Common.V1.Message.Payloads@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.maybe'answer' @:: Lens' WorkflowQueryResult (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads)@
         * 'Proto.Temporal.Api.Query.V1.Message_Fields.errorMessage' @:: Lens' WorkflowQueryResult Data.Text.Text@ -}
data WorkflowQueryResult
  = WorkflowQueryResult'_constructor {_WorkflowQueryResult'resultType :: !Proto.Temporal.Api.Enums.V1.Query.QueryResultType,
                                      _WorkflowQueryResult'answer :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads),
                                      _WorkflowQueryResult'errorMessage :: !Data.Text.Text,
                                      _WorkflowQueryResult'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowQueryResult where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowQueryResult "resultType" Proto.Temporal.Api.Enums.V1.Query.QueryResultType where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQueryResult'resultType
           (\ x__ y__ -> x__ {_WorkflowQueryResult'resultType = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowQueryResult "answer" Proto.Temporal.Api.Common.V1.Message.Payloads where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQueryResult'answer
           (\ x__ y__ -> x__ {_WorkflowQueryResult'answer = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowQueryResult "maybe'answer" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.Payloads) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQueryResult'answer
           (\ x__ y__ -> x__ {_WorkflowQueryResult'answer = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowQueryResult "errorMessage" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowQueryResult'errorMessage
           (\ x__ y__ -> x__ {_WorkflowQueryResult'errorMessage = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowQueryResult where
  messageName _
    = Data.Text.pack "temporal.api.query.v1.WorkflowQueryResult"
  packedMessageDescriptor _
    = "\n\
      \\DC3WorkflowQueryResult\DC2G\n\
      \\vresult_type\CAN\SOH \SOH(\SO2&.temporal.api.enums.v1.QueryResultTypeR\n\
      \resultType\DC28\n\
      \\ACKanswer\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ACKanswer\DC2#\n\
      \\rerror_message\CAN\ETX \SOH(\tR\ferrorMessage"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        resultType__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "result_type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Query.QueryResultType)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"resultType")) ::
              Data.ProtoLens.FieldDescriptor WorkflowQueryResult
        answer__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "answer"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.Payloads)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'answer")) ::
              Data.ProtoLens.FieldDescriptor WorkflowQueryResult
        errorMessage__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "error_message"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"errorMessage")) ::
              Data.ProtoLens.FieldDescriptor WorkflowQueryResult
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, resultType__field_descriptor),
           (Data.ProtoLens.Tag 2, answer__field_descriptor),
           (Data.ProtoLens.Tag 3, errorMessage__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowQueryResult'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowQueryResult'_unknownFields = y__})
  defMessage
    = WorkflowQueryResult'_constructor
        {_WorkflowQueryResult'resultType = Data.ProtoLens.fieldDefault,
         _WorkflowQueryResult'answer = Prelude.Nothing,
         _WorkflowQueryResult'errorMessage = Data.ProtoLens.fieldDefault,
         _WorkflowQueryResult'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowQueryResult
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowQueryResult
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
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "result_type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"resultType") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "answer"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"answer") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "error_message"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"errorMessage") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowQueryResult"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"resultType") _x
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
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'answer") _x
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
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"errorMessage") _x
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
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData WorkflowQueryResult where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowQueryResult'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowQueryResult'resultType x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowQueryResult'answer x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowQueryResult'errorMessage x__) ())))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \#temporal/api/query/v1/message.proto\DC2\NAKtemporal.api.query.v1\SUB!temporal/api/enums/v1/query.proto\SUB$temporal/api/enums/v1/workflow.proto\SUB$temporal/api/common/v1/message.proto\"\167\SOH\n\
    \\rWorkflowQuery\DC2\GS\n\
    \\n\
    \query_type\CAN\SOH \SOH(\tR\tqueryType\DC2?\n\
    \\n\
    \query_args\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\tqueryArgs\DC26\n\
    \\ACKheader\CAN\ETX \SOH(\v2\RS.temporal.api.common.v1.HeaderR\ACKheader\"\189\SOH\n\
    \\DC3WorkflowQueryResult\DC2G\n\
    \\vresult_type\CAN\SOH \SOH(\SO2&.temporal.api.enums.v1.QueryResultTypeR\n\
    \resultType\DC28\n\
    \\ACKanswer\CAN\STX \SOH(\v2 .temporal.api.common.v1.PayloadsR\ACKanswer\DC2#\n\
    \\rerror_message\CAN\ETX \SOH(\tR\ferrorMessage\"W\n\
    \\rQueryRejected\DC2F\n\
    \\ACKstatus\CAN\SOH \SOH(\SO2..temporal.api.enums.v1.WorkflowExecutionStatusR\ACKstatusB\132\SOH\n\
    \\CANio.temporal.api.query.v1B\fMessageProtoP\SOHZ!go.temporal.io/api/query/v1;query\170\STX\ETBTemporalio.Api.Query.V1\234\STX\SUBTemporalio::Api::Query::V1J\219\DC1\n\
    \\ACK\DC2\EOT\SYN\NUL<\SOH\n\
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
    \\STX\ETX\NUL\DC2\ETX!\NUL+\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL.\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX#\NUL.\n\
    \A\n\
    \\STX\EOT\NUL\DC2\EOT&\NUL.\SOH\SUB5 See https://docs.temporal.io/docs/concepts/queries/\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX&\b\NAK\n\
    \^\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX(\EOT\SUB\SUBQ The workflow-author-defined identifier of the query. Typically a function name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX(\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX(\v\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX(\CAN\EM\n\
    \O\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX*\EOT3\SUBB Serialized arguments that will be provided to the query handler.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX*\EOT#\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX*$.\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX*12\n\
    \z\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX-\EOT-\SUBm Headers that were passed by the caller of the query and copied by temporal \n\
    \ server into the workflow task.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX-\EOT!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX-\"(\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX-+,\n\
    \)\n\
    \\STX\EOT\SOH\DC2\EOT1\NUL8\SOH\SUB\GS Answer to a `WorkflowQuery`\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX1\b\ESC\n\
    \-\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX3\EOT:\SUB  Did the query succeed or fail?\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ACK\DC2\ETX3\EOT)\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX3*5\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX389\n\
    \;\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX5\EOT/\SUB. Set when the query succeeds with the results\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX5\EOT#\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX5$*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX5-.\n\
    \J\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX7\EOT\GS\SUB= Mutually exclusive with `answer`. Set when the query fails.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ENQ\DC2\ETX7\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX7\v\CAN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX7\ESC\FS\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT:\NUL<\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX:\b\NAK\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX;\EOT=\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX;\EOT1\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX;28\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX;;<b\ACKproto3"