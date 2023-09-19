{- This file was auto-generated from temporal/sdk/core/common/common.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Sdk.Core.Common.Common (
        NamespacedWorkflowExecution(), VersioningIntent(..),
        VersioningIntent(), VersioningIntent'UnrecognizedValue
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
{- | Fields :
     
         * 'Proto.Temporal.Sdk.Core.Common.Common_Fields.namespace' @:: Lens' NamespacedWorkflowExecution Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.Common.Common_Fields.workflowId' @:: Lens' NamespacedWorkflowExecution Data.Text.Text@
         * 'Proto.Temporal.Sdk.Core.Common.Common_Fields.runId' @:: Lens' NamespacedWorkflowExecution Data.Text.Text@ -}
data NamespacedWorkflowExecution
  = NamespacedWorkflowExecution'_constructor {_NamespacedWorkflowExecution'namespace :: !Data.Text.Text,
                                              _NamespacedWorkflowExecution'workflowId :: !Data.Text.Text,
                                              _NamespacedWorkflowExecution'runId :: !Data.Text.Text,
                                              _NamespacedWorkflowExecution'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespacedWorkflowExecution where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespacedWorkflowExecution "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespacedWorkflowExecution'namespace
           (\ x__ y__ -> x__ {_NamespacedWorkflowExecution'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespacedWorkflowExecution "workflowId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespacedWorkflowExecution'workflowId
           (\ x__ y__ -> x__ {_NamespacedWorkflowExecution'workflowId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespacedWorkflowExecution "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespacedWorkflowExecution'runId
           (\ x__ y__ -> x__ {_NamespacedWorkflowExecution'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespacedWorkflowExecution where
  messageName _
    = Data.Text.pack "coresdk.common.NamespacedWorkflowExecution"
  packedMessageDescriptor _
    = "\n\
      \\ESCNamespacedWorkflowExecution\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
      \\vworkflow_id\CAN\STX \SOH(\tR\n\
      \workflowId\DC2\NAK\n\
      \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        namespace__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "namespace"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"namespace")) ::
              Data.ProtoLens.FieldDescriptor NamespacedWorkflowExecution
        workflowId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowId")) ::
              Data.ProtoLens.FieldDescriptor NamespacedWorkflowExecution
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor NamespacedWorkflowExecution
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowId__field_descriptor),
           (Data.ProtoLens.Tag 3, runId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespacedWorkflowExecution'_unknownFields
        (\ x__ y__
           -> x__ {_NamespacedWorkflowExecution'_unknownFields = y__})
  defMessage
    = NamespacedWorkflowExecution'_constructor
        {_NamespacedWorkflowExecution'namespace = Data.ProtoLens.fieldDefault,
         _NamespacedWorkflowExecution'workflowId = Data.ProtoLens.fieldDefault,
         _NamespacedWorkflowExecution'runId = Data.ProtoLens.fieldDefault,
         _NamespacedWorkflowExecution'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespacedWorkflowExecution
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespacedWorkflowExecution
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
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
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
          (do loop Data.ProtoLens.defMessage) "NamespacedWorkflowExecution"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"namespace") _x
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
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"runId") _x
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
instance Control.DeepSeq.NFData NamespacedWorkflowExecution where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespacedWorkflowExecution'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespacedWorkflowExecution'namespace x__)
                (Control.DeepSeq.deepseq
                   (_NamespacedWorkflowExecution'workflowId x__)
                   (Control.DeepSeq.deepseq
                      (_NamespacedWorkflowExecution'runId x__) ())))
newtype VersioningIntent'UnrecognizedValue
  = VersioningIntent'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data VersioningIntent
  = UNSPECIFIED |
    COMPATIBLE |
    DEFAULT |
    VersioningIntent'Unrecognized !VersioningIntent'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum VersioningIntent where
  maybeToEnum 0 = Prelude.Just UNSPECIFIED
  maybeToEnum 1 = Prelude.Just COMPATIBLE
  maybeToEnum 2 = Prelude.Just DEFAULT
  maybeToEnum k
    = Prelude.Just
        (VersioningIntent'Unrecognized
           (VersioningIntent'UnrecognizedValue (Prelude.fromIntegral k)))
  showEnum UNSPECIFIED = "UNSPECIFIED"
  showEnum COMPATIBLE = "COMPATIBLE"
  showEnum DEFAULT = "DEFAULT"
  showEnum
    (VersioningIntent'Unrecognized (VersioningIntent'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "UNSPECIFIED" = Prelude.Just UNSPECIFIED
    | (Prelude.==) k "COMPATIBLE" = Prelude.Just COMPATIBLE
    | (Prelude.==) k "DEFAULT" = Prelude.Just DEFAULT
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded VersioningIntent where
  minBound = UNSPECIFIED
  maxBound = DEFAULT
instance Prelude.Enum VersioningIntent where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum VersioningIntent: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum UNSPECIFIED = 0
  fromEnum COMPATIBLE = 1
  fromEnum DEFAULT = 2
  fromEnum
    (VersioningIntent'Unrecognized (VersioningIntent'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ DEFAULT
    = Prelude.error
        "VersioningIntent.succ: bad argument DEFAULT. This value would be out of bounds."
  succ UNSPECIFIED = COMPATIBLE
  succ COMPATIBLE = DEFAULT
  succ (VersioningIntent'Unrecognized _)
    = Prelude.error
        "VersioningIntent.succ: bad argument: unrecognized value"
  pred UNSPECIFIED
    = Prelude.error
        "VersioningIntent.pred: bad argument UNSPECIFIED. This value would be out of bounds."
  pred COMPATIBLE = UNSPECIFIED
  pred DEFAULT = COMPATIBLE
  pred (VersioningIntent'Unrecognized _)
    = Prelude.error
        "VersioningIntent.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault VersioningIntent where
  fieldDefault = UNSPECIFIED
instance Control.DeepSeq.NFData VersioningIntent where
  rnf x__ = Prelude.seq x__ ()
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \%temporal/sdk/core/common/common.proto\DC2\SOcoresdk.common\SUB\RSgoogle/protobuf/duration.proto\"s\n\
    \\ESCNamespacedWorkflowExecution\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2\US\n\
    \\vworkflow_id\CAN\STX \SOH(\tR\n\
    \workflowId\DC2\NAK\n\
    \\ACKrun_id\CAN\ETX \SOH(\tR\ENQrunId*@\n\
    \\DLEVersioningIntent\DC2\SI\n\
    \\vUNSPECIFIED\DLE\NUL\DC2\SO\n\
    \\n\
    \COMPATIBLE\DLE\SOH\DC2\v\n\
    \\aDEFAULT\DLE\STXB\"\234\STX\USTemporalio::Bridge::Api::CommonJ\236\t\n\
    \\ACK\DC2\EOT\NUL\NUL\US\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\ETB\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ETX\NUL8\n\
    \\t\n\
    \\STX\b-\DC2\ETX\ETX\NUL8\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\ENQ\NUL(\n\
    \`\n\
    \\STX\EOT\NUL\DC2\EOT\b\NUL\SI\SOH\SUBT Identifying information about a particular workflow execution, including namespace\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\b\b#\n\
    \7\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\n\
    \\EOT\EM\SUB* Namespace the workflow run is located in\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\n\
    \\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\n\
    \\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\n\
    \\ETB\CAN\n\
    \!\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\f\EOT\ESC\SUB\DC4 Can never be empty\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX\f\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\f\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\f\EM\SUB\n\
    \f\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\SO\EOT\SYN\SUBY May be empty if the most recent run of the workflow with the given ID is being targeted\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX\SO\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\SO\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\SO\DC4\NAK\n\
    \\128\SOH\n\
    \\STX\ENQ\NUL\DC2\EOT\DC3\NUL\US\SOH\SUBt An indication of user's intent concerning what Build ID versioning approach should be used for\n\
    \ a specific command\n\
    \\n\
    \\n\
    \\n\
    \\ETX\ENQ\NUL\SOH\DC2\ETX\DC3\ENQ\NAK\n\
    \\204\SOH\n\
    \\EOT\ENQ\NUL\STX\NUL\DC2\ETX\ETB\EOT\DC4\SUB\190\SOH Indicates that core should choose the most sensible default behavior for the type of\n\
    \ command, accounting for whether the command will be run on the same task queue as the current\n\
    \ worker.\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\SOH\DC2\ETX\ETB\EOT\SI\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\NUL\STX\DC2\ETX\ETB\DC2\DC3\n\
    \\215\SOH\n\
    \\EOT\ENQ\NUL\STX\SOH\DC2\ETX\ESC\EOT\DC3\SUB\201\SOH Indicates that the command should run on a worker with compatible version if possible. It may\n\
    \ not be possible if the target task queue does not also have knowledge of the current worker's\n\
    \ build ID.\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\SOH\DC2\ETX\ESC\EOT\SO\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\SOH\STX\DC2\ETX\ESC\DC1\DC2\n\
    \r\n\
    \\EOT\ENQ\NUL\STX\STX\DC2\ETX\RS\EOT\DLE\SUBe Indicates that the command should run on the target task queue's current overall-default\n\
    \ build ID.\n\
    \\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\STX\SOH\DC2\ETX\RS\EOT\v\n\
    \\f\n\
    \\ENQ\ENQ\NUL\STX\STX\STX\DC2\ETX\RS\SO\SIb\ACKproto3"