{- This file was auto-generated from temporal/api/errordetails/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Errordetails.V1.Message (
        CancellationAlreadyRequestedFailure(),
        ClientVersionNotSupportedFailure(),
        MultiOperationExecutionFailure(),
        MultiOperationExecutionFailure'OperationStatus(),
        NamespaceAlreadyExistsFailure(), NamespaceInvalidStateFailure(),
        NamespaceNotActiveFailure(), NamespaceNotFoundFailure(),
        NewerBuildExistsFailure(), NotFoundFailure(),
        PermissionDeniedFailure(), QueryFailedFailure(),
        ResourceExhaustedFailure(), ServerVersionNotSupportedFailure(),
        SystemWorkflowFailure(), WorkflowExecutionAlreadyStartedFailure(),
        WorkflowNotReadyFailure()
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
import qualified Proto.Google.Protobuf.Any
import qualified Proto.Temporal.Api.Common.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.FailedCause
import qualified Proto.Temporal.Api.Enums.V1.Namespace
{- | Fields :
      -}
data CancellationAlreadyRequestedFailure
  = CancellationAlreadyRequestedFailure'_constructor {_CancellationAlreadyRequestedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CancellationAlreadyRequestedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message CancellationAlreadyRequestedFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.CancellationAlreadyRequestedFailure"
  packedMessageDescriptor _
    = "\n\
      \#CancellationAlreadyRequestedFailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _CancellationAlreadyRequestedFailure'_unknownFields
        (\ x__ y__
           -> x__ {_CancellationAlreadyRequestedFailure'_unknownFields = y__})
  defMessage
    = CancellationAlreadyRequestedFailure'_constructor
        {_CancellationAlreadyRequestedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          CancellationAlreadyRequestedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser CancellationAlreadyRequestedFailure
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
          (do loop Data.ProtoLens.defMessage)
          "CancellationAlreadyRequestedFailure"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData CancellationAlreadyRequestedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_CancellationAlreadyRequestedFailure'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.clientVersion' @:: Lens' ClientVersionNotSupportedFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.clientName' @:: Lens' ClientVersionNotSupportedFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.supportedVersions' @:: Lens' ClientVersionNotSupportedFailure Data.Text.Text@ -}
data ClientVersionNotSupportedFailure
  = ClientVersionNotSupportedFailure'_constructor {_ClientVersionNotSupportedFailure'clientVersion :: !Data.Text.Text,
                                                   _ClientVersionNotSupportedFailure'clientName :: !Data.Text.Text,
                                                   _ClientVersionNotSupportedFailure'supportedVersions :: !Data.Text.Text,
                                                   _ClientVersionNotSupportedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ClientVersionNotSupportedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ClientVersionNotSupportedFailure "clientVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClientVersionNotSupportedFailure'clientVersion
           (\ x__ y__
              -> x__ {_ClientVersionNotSupportedFailure'clientVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClientVersionNotSupportedFailure "clientName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClientVersionNotSupportedFailure'clientName
           (\ x__ y__
              -> x__ {_ClientVersionNotSupportedFailure'clientName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ClientVersionNotSupportedFailure "supportedVersions" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ClientVersionNotSupportedFailure'supportedVersions
           (\ x__ y__
              -> x__
                   {_ClientVersionNotSupportedFailure'supportedVersions = y__}))
        Prelude.id
instance Data.ProtoLens.Message ClientVersionNotSupportedFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.ClientVersionNotSupportedFailure"
  packedMessageDescriptor _
    = "\n\
      \ ClientVersionNotSupportedFailure\DC2%\n\
      \\SOclient_version\CAN\SOH \SOH(\tR\rclientVersion\DC2\US\n\
      \\vclient_name\CAN\STX \SOH(\tR\n\
      \clientName\DC2-\n\
      \\DC2supported_versions\CAN\ETX \SOH(\tR\DC1supportedVersions"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        clientVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "client_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"clientVersion")) ::
              Data.ProtoLens.FieldDescriptor ClientVersionNotSupportedFailure
        clientName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "client_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"clientName")) ::
              Data.ProtoLens.FieldDescriptor ClientVersionNotSupportedFailure
        supportedVersions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "supported_versions"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"supportedVersions")) ::
              Data.ProtoLens.FieldDescriptor ClientVersionNotSupportedFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, clientVersion__field_descriptor),
           (Data.ProtoLens.Tag 2, clientName__field_descriptor),
           (Data.ProtoLens.Tag 3, supportedVersions__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ClientVersionNotSupportedFailure'_unknownFields
        (\ x__ y__
           -> x__ {_ClientVersionNotSupportedFailure'_unknownFields = y__})
  defMessage
    = ClientVersionNotSupportedFailure'_constructor
        {_ClientVersionNotSupportedFailure'clientVersion = Data.ProtoLens.fieldDefault,
         _ClientVersionNotSupportedFailure'clientName = Data.ProtoLens.fieldDefault,
         _ClientVersionNotSupportedFailure'supportedVersions = Data.ProtoLens.fieldDefault,
         _ClientVersionNotSupportedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ClientVersionNotSupportedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser ClientVersionNotSupportedFailure
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
                                       "client_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"clientVersion") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "client_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"clientName") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "supported_versions"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"supportedVersions") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ClientVersionNotSupportedFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"clientVersion") _x
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
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"clientName") _x
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
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"supportedVersions") _x
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
instance Control.DeepSeq.NFData ClientVersionNotSupportedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ClientVersionNotSupportedFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ClientVersionNotSupportedFailure'clientVersion x__)
                (Control.DeepSeq.deepseq
                   (_ClientVersionNotSupportedFailure'clientName x__)
                   (Control.DeepSeq.deepseq
                      (_ClientVersionNotSupportedFailure'supportedVersions x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.statuses' @:: Lens' MultiOperationExecutionFailure [MultiOperationExecutionFailure'OperationStatus]@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.vec'statuses' @:: Lens' MultiOperationExecutionFailure (Data.Vector.Vector MultiOperationExecutionFailure'OperationStatus)@ -}
data MultiOperationExecutionFailure
  = MultiOperationExecutionFailure'_constructor {_MultiOperationExecutionFailure'statuses :: !(Data.Vector.Vector MultiOperationExecutionFailure'OperationStatus),
                                                 _MultiOperationExecutionFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show MultiOperationExecutionFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField MultiOperationExecutionFailure "statuses" [MultiOperationExecutionFailure'OperationStatus] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MultiOperationExecutionFailure'statuses
           (\ x__ y__
              -> x__ {_MultiOperationExecutionFailure'statuses = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField MultiOperationExecutionFailure "vec'statuses" (Data.Vector.Vector MultiOperationExecutionFailure'OperationStatus) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MultiOperationExecutionFailure'statuses
           (\ x__ y__
              -> x__ {_MultiOperationExecutionFailure'statuses = y__}))
        Prelude.id
instance Data.ProtoLens.Message MultiOperationExecutionFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.MultiOperationExecutionFailure"
  packedMessageDescriptor _
    = "\n\
      \\RSMultiOperationExecutionFailure\DC2h\n\
      \\bstatuses\CAN\SOH \ETX(\v2L.temporal.api.errordetails.v1.MultiOperationExecutionFailure.OperationStatusR\bstatuses\SUBo\n\
      \\SIOperationStatus\DC2\DC2\n\
      \\EOTcode\CAN\SOH \SOH(\ENQR\EOTcode\DC2\CAN\n\
      \\amessage\CAN\STX \SOH(\tR\amessage\DC2.\n\
      \\adetails\CAN\ETX \ETX(\v2\DC4.google.protobuf.AnyR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        statuses__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "statuses"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor MultiOperationExecutionFailure'OperationStatus)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"statuses")) ::
              Data.ProtoLens.FieldDescriptor MultiOperationExecutionFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, statuses__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _MultiOperationExecutionFailure'_unknownFields
        (\ x__ y__
           -> x__ {_MultiOperationExecutionFailure'_unknownFields = y__})
  defMessage
    = MultiOperationExecutionFailure'_constructor
        {_MultiOperationExecutionFailure'statuses = Data.Vector.Generic.empty,
         _MultiOperationExecutionFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          MultiOperationExecutionFailure
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld MultiOperationExecutionFailure'OperationStatus
             -> Data.ProtoLens.Encoding.Bytes.Parser MultiOperationExecutionFailure
        loop x mutable'statuses
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'statuses <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'statuses)
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
                              (Data.ProtoLens.Field.field @"vec'statuses") frozen'statuses x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "statuses"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'statuses y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'statuses
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'statuses <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'statuses)
          "MultiOperationExecutionFailure"
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
                   (Data.ProtoLens.Field.field @"vec'statuses") _x))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData MultiOperationExecutionFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_MultiOperationExecutionFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_MultiOperationExecutionFailure'statuses x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.code' @:: Lens' MultiOperationExecutionFailure'OperationStatus Data.Int.Int32@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.message' @:: Lens' MultiOperationExecutionFailure'OperationStatus Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.details' @:: Lens' MultiOperationExecutionFailure'OperationStatus [Proto.Google.Protobuf.Any.Any]@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.vec'details' @:: Lens' MultiOperationExecutionFailure'OperationStatus (Data.Vector.Vector Proto.Google.Protobuf.Any.Any)@ -}
data MultiOperationExecutionFailure'OperationStatus
  = MultiOperationExecutionFailure'OperationStatus'_constructor {_MultiOperationExecutionFailure'OperationStatus'code :: !Data.Int.Int32,
                                                                 _MultiOperationExecutionFailure'OperationStatus'message :: !Data.Text.Text,
                                                                 _MultiOperationExecutionFailure'OperationStatus'details :: !(Data.Vector.Vector Proto.Google.Protobuf.Any.Any),
                                                                 _MultiOperationExecutionFailure'OperationStatus'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show MultiOperationExecutionFailure'OperationStatus where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField MultiOperationExecutionFailure'OperationStatus "code" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MultiOperationExecutionFailure'OperationStatus'code
           (\ x__ y__
              -> x__
                   {_MultiOperationExecutionFailure'OperationStatus'code = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField MultiOperationExecutionFailure'OperationStatus "message" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MultiOperationExecutionFailure'OperationStatus'message
           (\ x__ y__
              -> x__
                   {_MultiOperationExecutionFailure'OperationStatus'message = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField MultiOperationExecutionFailure'OperationStatus "details" [Proto.Google.Protobuf.Any.Any] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MultiOperationExecutionFailure'OperationStatus'details
           (\ x__ y__
              -> x__
                   {_MultiOperationExecutionFailure'OperationStatus'details = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField MultiOperationExecutionFailure'OperationStatus "vec'details" (Data.Vector.Vector Proto.Google.Protobuf.Any.Any) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MultiOperationExecutionFailure'OperationStatus'details
           (\ x__ y__
              -> x__
                   {_MultiOperationExecutionFailure'OperationStatus'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message MultiOperationExecutionFailure'OperationStatus where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.MultiOperationExecutionFailure.OperationStatus"
  packedMessageDescriptor _
    = "\n\
      \\SIOperationStatus\DC2\DC2\n\
      \\EOTcode\CAN\SOH \SOH(\ENQR\EOTcode\DC2\CAN\n\
      \\amessage\CAN\STX \SOH(\tR\amessage\DC2.\n\
      \\adetails\CAN\ETX \ETX(\v2\DC4.google.protobuf.AnyR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        code__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "code"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"code")) ::
              Data.ProtoLens.FieldDescriptor MultiOperationExecutionFailure'OperationStatus
        message__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "message"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"message")) ::
              Data.ProtoLens.FieldDescriptor MultiOperationExecutionFailure'OperationStatus
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Any.Any)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"details")) ::
              Data.ProtoLens.FieldDescriptor MultiOperationExecutionFailure'OperationStatus
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, code__field_descriptor),
           (Data.ProtoLens.Tag 2, message__field_descriptor),
           (Data.ProtoLens.Tag 3, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _MultiOperationExecutionFailure'OperationStatus'_unknownFields
        (\ x__ y__
           -> x__
                {_MultiOperationExecutionFailure'OperationStatus'_unknownFields = y__})
  defMessage
    = MultiOperationExecutionFailure'OperationStatus'_constructor
        {_MultiOperationExecutionFailure'OperationStatus'code = Data.ProtoLens.fieldDefault,
         _MultiOperationExecutionFailure'OperationStatus'message = Data.ProtoLens.fieldDefault,
         _MultiOperationExecutionFailure'OperationStatus'details = Data.Vector.Generic.empty,
         _MultiOperationExecutionFailure'OperationStatus'_unknownFields = []}
  parseMessage
    = let
        loop ::
          MultiOperationExecutionFailure'OperationStatus
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Google.Protobuf.Any.Any
             -> Data.ProtoLens.Encoding.Bytes.Parser MultiOperationExecutionFailure'OperationStatus
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
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "code"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"code") y x)
                                  mutable'details
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "message"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"message") y x)
                                  mutable'details
                        26
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
          "OperationStatus"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"code") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"message") _x
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
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'details") _x))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData MultiOperationExecutionFailure'OperationStatus where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_MultiOperationExecutionFailure'OperationStatus'_unknownFields
                x__)
             (Control.DeepSeq.deepseq
                (_MultiOperationExecutionFailure'OperationStatus'code x__)
                (Control.DeepSeq.deepseq
                   (_MultiOperationExecutionFailure'OperationStatus'message x__)
                   (Control.DeepSeq.deepseq
                      (_MultiOperationExecutionFailure'OperationStatus'details x__) ())))
{- | Fields :
      -}
data NamespaceAlreadyExistsFailure
  = NamespaceAlreadyExistsFailure'_constructor {_NamespaceAlreadyExistsFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceAlreadyExistsFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message NamespaceAlreadyExistsFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.NamespaceAlreadyExistsFailure"
  packedMessageDescriptor _
    = "\n\
      \\GSNamespaceAlreadyExistsFailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceAlreadyExistsFailure'_unknownFields
        (\ x__ y__
           -> x__ {_NamespaceAlreadyExistsFailure'_unknownFields = y__})
  defMessage
    = NamespaceAlreadyExistsFailure'_constructor
        {_NamespaceAlreadyExistsFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceAlreadyExistsFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceAlreadyExistsFailure
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
          (do loop Data.ProtoLens.defMessage) "NamespaceAlreadyExistsFailure"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData NamespaceAlreadyExistsFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceAlreadyExistsFailure'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.namespace' @:: Lens' NamespaceInvalidStateFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.state' @:: Lens' NamespaceInvalidStateFailure Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.allowedStates' @:: Lens' NamespaceInvalidStateFailure [Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState]@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.vec'allowedStates' @:: Lens' NamespaceInvalidStateFailure (Data.Vector.Vector Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState)@ -}
data NamespaceInvalidStateFailure
  = NamespaceInvalidStateFailure'_constructor {_NamespaceInvalidStateFailure'namespace :: !Data.Text.Text,
                                               _NamespaceInvalidStateFailure'state :: !Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState,
                                               _NamespaceInvalidStateFailure'allowedStates :: !(Data.Vector.Vector Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState),
                                               _NamespaceInvalidStateFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceInvalidStateFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceInvalidStateFailure "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInvalidStateFailure'namespace
           (\ x__ y__ -> x__ {_NamespaceInvalidStateFailure'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInvalidStateFailure "state" Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInvalidStateFailure'state
           (\ x__ y__ -> x__ {_NamespaceInvalidStateFailure'state = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceInvalidStateFailure "allowedStates" [Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInvalidStateFailure'allowedStates
           (\ x__ y__
              -> x__ {_NamespaceInvalidStateFailure'allowedStates = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField NamespaceInvalidStateFailure "vec'allowedStates" (Data.Vector.Vector Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceInvalidStateFailure'allowedStates
           (\ x__ y__
              -> x__ {_NamespaceInvalidStateFailure'allowedStates = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceInvalidStateFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.NamespaceInvalidStateFailure"
  packedMessageDescriptor _
    = "\n\
      \\FSNamespaceInvalidStateFailure\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2;\n\
      \\ENQstate\CAN\STX \SOH(\SO2%.temporal.api.enums.v1.NamespaceStateR\ENQstate\DC2L\n\
      \\SOallowed_states\CAN\ETX \ETX(\SO2%.temporal.api.enums.v1.NamespaceStateR\rallowedStates"
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
              Data.ProtoLens.FieldDescriptor NamespaceInvalidStateFailure
        state__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "state"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"state")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInvalidStateFailure
        allowedStates__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "allowed_states"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Packed
                 (Data.ProtoLens.Field.field @"allowedStates")) ::
              Data.ProtoLens.FieldDescriptor NamespaceInvalidStateFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, state__field_descriptor),
           (Data.ProtoLens.Tag 3, allowedStates__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceInvalidStateFailure'_unknownFields
        (\ x__ y__
           -> x__ {_NamespaceInvalidStateFailure'_unknownFields = y__})
  defMessage
    = NamespaceInvalidStateFailure'_constructor
        {_NamespaceInvalidStateFailure'namespace = Data.ProtoLens.fieldDefault,
         _NamespaceInvalidStateFailure'state = Data.ProtoLens.fieldDefault,
         _NamespaceInvalidStateFailure'allowedStates = Data.Vector.Generic.empty,
         _NamespaceInvalidStateFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceInvalidStateFailure
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Temporal.Api.Enums.V1.Namespace.NamespaceState
             -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceInvalidStateFailure
        loop x mutable'allowedStates
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'allowedStates <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                   mutable'allowedStates)
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
                              (Data.ProtoLens.Field.field @"vec'allowedStates")
                              frozen'allowedStates x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                                  mutable'allowedStates
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "state"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"state") y x)
                                  mutable'allowedStates
                        24
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (Prelude.fmap
                                           Prelude.toEnum
                                           (Prelude.fmap
                                              Prelude.fromIntegral
                                              Data.ProtoLens.Encoding.Bytes.getVarInt))
                                        "allowed_states"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'allowedStates y)
                                loop x v
                        26
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
                                                                       Prelude.toEnum
                                                                       (Prelude.fmap
                                                                          Prelude.fromIntegral
                                                                          Data.ProtoLens.Encoding.Bytes.getVarInt))
                                                                    "allowed_states"
                                                            qs' <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                                     (Data.ProtoLens.Encoding.Growing.append
                                                                        qs q)
                                                            ploop qs'
                                            in ploop)
                                             mutable'allowedStates)
                                loop x y
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'allowedStates
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'allowedStates <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'allowedStates)
          "NamespaceInvalidStateFailure"
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
                   (let
                      p = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"vec'allowedStates") _x
                    in
                      if Data.Vector.Generic.null p then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                            ((\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                               (Data.ProtoLens.Encoding.Bytes.runBuilder
                                  (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                     ((Prelude..)
                                        ((Prelude..)
                                           Data.ProtoLens.Encoding.Bytes.putVarInt
                                           Prelude.fromIntegral)
                                        Prelude.fromEnum)
                                     p))))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData NamespaceInvalidStateFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceInvalidStateFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceInvalidStateFailure'namespace x__)
                (Control.DeepSeq.deepseq
                   (_NamespaceInvalidStateFailure'state x__)
                   (Control.DeepSeq.deepseq
                      (_NamespaceInvalidStateFailure'allowedStates x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.namespace' @:: Lens' NamespaceNotActiveFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.currentCluster' @:: Lens' NamespaceNotActiveFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.activeCluster' @:: Lens' NamespaceNotActiveFailure Data.Text.Text@ -}
data NamespaceNotActiveFailure
  = NamespaceNotActiveFailure'_constructor {_NamespaceNotActiveFailure'namespace :: !Data.Text.Text,
                                            _NamespaceNotActiveFailure'currentCluster :: !Data.Text.Text,
                                            _NamespaceNotActiveFailure'activeCluster :: !Data.Text.Text,
                                            _NamespaceNotActiveFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceNotActiveFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceNotActiveFailure "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceNotActiveFailure'namespace
           (\ x__ y__ -> x__ {_NamespaceNotActiveFailure'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceNotActiveFailure "currentCluster" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceNotActiveFailure'currentCluster
           (\ x__ y__
              -> x__ {_NamespaceNotActiveFailure'currentCluster = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NamespaceNotActiveFailure "activeCluster" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceNotActiveFailure'activeCluster
           (\ x__ y__
              -> x__ {_NamespaceNotActiveFailure'activeCluster = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceNotActiveFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.NamespaceNotActiveFailure"
  packedMessageDescriptor _
    = "\n\
      \\EMNamespaceNotActiveFailure\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2'\n\
      \\SIcurrent_cluster\CAN\STX \SOH(\tR\SOcurrentCluster\DC2%\n\
      \\SOactive_cluster\CAN\ETX \SOH(\tR\ractiveCluster"
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
              Data.ProtoLens.FieldDescriptor NamespaceNotActiveFailure
        currentCluster__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_cluster"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentCluster")) ::
              Data.ProtoLens.FieldDescriptor NamespaceNotActiveFailure
        activeCluster__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "active_cluster"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activeCluster")) ::
              Data.ProtoLens.FieldDescriptor NamespaceNotActiveFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor),
           (Data.ProtoLens.Tag 2, currentCluster__field_descriptor),
           (Data.ProtoLens.Tag 3, activeCluster__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceNotActiveFailure'_unknownFields
        (\ x__ y__
           -> x__ {_NamespaceNotActiveFailure'_unknownFields = y__})
  defMessage
    = NamespaceNotActiveFailure'_constructor
        {_NamespaceNotActiveFailure'namespace = Data.ProtoLens.fieldDefault,
         _NamespaceNotActiveFailure'currentCluster = Data.ProtoLens.fieldDefault,
         _NamespaceNotActiveFailure'activeCluster = Data.ProtoLens.fieldDefault,
         _NamespaceNotActiveFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceNotActiveFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceNotActiveFailure
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
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "current_cluster"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentCluster") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "active_cluster"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activeCluster") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NamespaceNotActiveFailure"
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
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"currentCluster") _x
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
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"activeCluster") _x
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
instance Control.DeepSeq.NFData NamespaceNotActiveFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceNotActiveFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceNotActiveFailure'namespace x__)
                (Control.DeepSeq.deepseq
                   (_NamespaceNotActiveFailure'currentCluster x__)
                   (Control.DeepSeq.deepseq
                      (_NamespaceNotActiveFailure'activeCluster x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.namespace' @:: Lens' NamespaceNotFoundFailure Data.Text.Text@ -}
data NamespaceNotFoundFailure
  = NamespaceNotFoundFailure'_constructor {_NamespaceNotFoundFailure'namespace :: !Data.Text.Text,
                                           _NamespaceNotFoundFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NamespaceNotFoundFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NamespaceNotFoundFailure "namespace" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NamespaceNotFoundFailure'namespace
           (\ x__ y__ -> x__ {_NamespaceNotFoundFailure'namespace = y__}))
        Prelude.id
instance Data.ProtoLens.Message NamespaceNotFoundFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.NamespaceNotFoundFailure"
  packedMessageDescriptor _
    = "\n\
      \\CANNamespaceNotFoundFailure\DC2\FS\n\
      \\tnamespace\CAN\SOH \SOH(\tR\tnamespace"
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
              Data.ProtoLens.FieldDescriptor NamespaceNotFoundFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, namespace__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NamespaceNotFoundFailure'_unknownFields
        (\ x__ y__ -> x__ {_NamespaceNotFoundFailure'_unknownFields = y__})
  defMessage
    = NamespaceNotFoundFailure'_constructor
        {_NamespaceNotFoundFailure'namespace = Data.ProtoLens.fieldDefault,
         _NamespaceNotFoundFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NamespaceNotFoundFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser NamespaceNotFoundFailure
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
                                       "namespace"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"namespace") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NamespaceNotFoundFailure"
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
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData NamespaceNotFoundFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NamespaceNotFoundFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NamespaceNotFoundFailure'namespace x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.defaultBuildId' @:: Lens' NewerBuildExistsFailure Data.Text.Text@ -}
data NewerBuildExistsFailure
  = NewerBuildExistsFailure'_constructor {_NewerBuildExistsFailure'defaultBuildId :: !Data.Text.Text,
                                          _NewerBuildExistsFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NewerBuildExistsFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NewerBuildExistsFailure "defaultBuildId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NewerBuildExistsFailure'defaultBuildId
           (\ x__ y__ -> x__ {_NewerBuildExistsFailure'defaultBuildId = y__}))
        Prelude.id
instance Data.ProtoLens.Message NewerBuildExistsFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.NewerBuildExistsFailure"
  packedMessageDescriptor _
    = "\n\
      \\ETBNewerBuildExistsFailure\DC2(\n\
      \\DLEdefault_build_id\CAN\SOH \SOH(\tR\SOdefaultBuildId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        defaultBuildId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "default_build_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"defaultBuildId")) ::
              Data.ProtoLens.FieldDescriptor NewerBuildExistsFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, defaultBuildId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NewerBuildExistsFailure'_unknownFields
        (\ x__ y__ -> x__ {_NewerBuildExistsFailure'_unknownFields = y__})
  defMessage
    = NewerBuildExistsFailure'_constructor
        {_NewerBuildExistsFailure'defaultBuildId = Data.ProtoLens.fieldDefault,
         _NewerBuildExistsFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NewerBuildExistsFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser NewerBuildExistsFailure
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
                                       "default_build_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"defaultBuildId") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NewerBuildExistsFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"defaultBuildId") _x
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
instance Control.DeepSeq.NFData NewerBuildExistsFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NewerBuildExistsFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NewerBuildExistsFailure'defaultBuildId x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.currentCluster' @:: Lens' NotFoundFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.activeCluster' @:: Lens' NotFoundFailure Data.Text.Text@ -}
data NotFoundFailure
  = NotFoundFailure'_constructor {_NotFoundFailure'currentCluster :: !Data.Text.Text,
                                  _NotFoundFailure'activeCluster :: !Data.Text.Text,
                                  _NotFoundFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show NotFoundFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField NotFoundFailure "currentCluster" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NotFoundFailure'currentCluster
           (\ x__ y__ -> x__ {_NotFoundFailure'currentCluster = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField NotFoundFailure "activeCluster" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _NotFoundFailure'activeCluster
           (\ x__ y__ -> x__ {_NotFoundFailure'activeCluster = y__}))
        Prelude.id
instance Data.ProtoLens.Message NotFoundFailure where
  messageName _
    = Data.Text.pack "temporal.api.errordetails.v1.NotFoundFailure"
  packedMessageDescriptor _
    = "\n\
      \\SINotFoundFailure\DC2'\n\
      \\SIcurrent_cluster\CAN\SOH \SOH(\tR\SOcurrentCluster\DC2%\n\
      \\SOactive_cluster\CAN\STX \SOH(\tR\ractiveCluster"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        currentCluster__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_cluster"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentCluster")) ::
              Data.ProtoLens.FieldDescriptor NotFoundFailure
        activeCluster__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "active_cluster"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"activeCluster")) ::
              Data.ProtoLens.FieldDescriptor NotFoundFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, currentCluster__field_descriptor),
           (Data.ProtoLens.Tag 2, activeCluster__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _NotFoundFailure'_unknownFields
        (\ x__ y__ -> x__ {_NotFoundFailure'_unknownFields = y__})
  defMessage
    = NotFoundFailure'_constructor
        {_NotFoundFailure'currentCluster = Data.ProtoLens.fieldDefault,
         _NotFoundFailure'activeCluster = Data.ProtoLens.fieldDefault,
         _NotFoundFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          NotFoundFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser NotFoundFailure
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
                                       "current_cluster"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentCluster") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "active_cluster"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activeCluster") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "NotFoundFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"currentCluster") _x
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
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"activeCluster") _x
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
instance Control.DeepSeq.NFData NotFoundFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_NotFoundFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_NotFoundFailure'currentCluster x__)
                (Control.DeepSeq.deepseq (_NotFoundFailure'activeCluster x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.reason' @:: Lens' PermissionDeniedFailure Data.Text.Text@ -}
data PermissionDeniedFailure
  = PermissionDeniedFailure'_constructor {_PermissionDeniedFailure'reason :: !Data.Text.Text,
                                          _PermissionDeniedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show PermissionDeniedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField PermissionDeniedFailure "reason" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _PermissionDeniedFailure'reason
           (\ x__ y__ -> x__ {_PermissionDeniedFailure'reason = y__}))
        Prelude.id
instance Data.ProtoLens.Message PermissionDeniedFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.PermissionDeniedFailure"
  packedMessageDescriptor _
    = "\n\
      \\ETBPermissionDeniedFailure\DC2\SYN\n\
      \\ACKreason\CAN\SOH \SOH(\tR\ACKreason"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        reason__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reason"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"reason")) ::
              Data.ProtoLens.FieldDescriptor PermissionDeniedFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, reason__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _PermissionDeniedFailure'_unknownFields
        (\ x__ y__ -> x__ {_PermissionDeniedFailure'_unknownFields = y__})
  defMessage
    = PermissionDeniedFailure'_constructor
        {_PermissionDeniedFailure'reason = Data.ProtoLens.fieldDefault,
         _PermissionDeniedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          PermissionDeniedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser PermissionDeniedFailure
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
          (do loop Data.ProtoLens.defMessage) "PermissionDeniedFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"reason") _x
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
instance Control.DeepSeq.NFData PermissionDeniedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_PermissionDeniedFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq (_PermissionDeniedFailure'reason x__) ())
{- | Fields :
      -}
data QueryFailedFailure
  = QueryFailedFailure'_constructor {_QueryFailedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show QueryFailedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message QueryFailedFailure where
  messageName _
    = Data.Text.pack "temporal.api.errordetails.v1.QueryFailedFailure"
  packedMessageDescriptor _
    = "\n\
      \\DC2QueryFailedFailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _QueryFailedFailure'_unknownFields
        (\ x__ y__ -> x__ {_QueryFailedFailure'_unknownFields = y__})
  defMessage
    = QueryFailedFailure'_constructor
        {_QueryFailedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          QueryFailedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser QueryFailedFailure
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
          (do loop Data.ProtoLens.defMessage) "QueryFailedFailure"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData QueryFailedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_QueryFailedFailure'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.cause' @:: Lens' ResourceExhaustedFailure Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedCause@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.scope' @:: Lens' ResourceExhaustedFailure Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedScope@ -}
data ResourceExhaustedFailure
  = ResourceExhaustedFailure'_constructor {_ResourceExhaustedFailure'cause :: !Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedCause,
                                           _ResourceExhaustedFailure'scope :: !Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedScope,
                                           _ResourceExhaustedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ResourceExhaustedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ResourceExhaustedFailure "cause" Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedCause where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResourceExhaustedFailure'cause
           (\ x__ y__ -> x__ {_ResourceExhaustedFailure'cause = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ResourceExhaustedFailure "scope" Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedScope where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ResourceExhaustedFailure'scope
           (\ x__ y__ -> x__ {_ResourceExhaustedFailure'scope = y__}))
        Prelude.id
instance Data.ProtoLens.Message ResourceExhaustedFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.ResourceExhaustedFailure"
  packedMessageDescriptor _
    = "\n\
      \\CANResourceExhaustedFailure\DC2C\n\
      \\ENQcause\CAN\SOH \SOH(\SO2-.temporal.api.enums.v1.ResourceExhaustedCauseR\ENQcause\DC2C\n\
      \\ENQscope\CAN\STX \SOH(\SO2-.temporal.api.enums.v1.ResourceExhaustedScopeR\ENQscope"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        cause__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "cause"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedCause)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"cause")) ::
              Data.ProtoLens.FieldDescriptor ResourceExhaustedFailure
        scope__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "scope"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.FailedCause.ResourceExhaustedScope)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"scope")) ::
              Data.ProtoLens.FieldDescriptor ResourceExhaustedFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, cause__field_descriptor),
           (Data.ProtoLens.Tag 2, scope__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ResourceExhaustedFailure'_unknownFields
        (\ x__ y__ -> x__ {_ResourceExhaustedFailure'_unknownFields = y__})
  defMessage
    = ResourceExhaustedFailure'_constructor
        {_ResourceExhaustedFailure'cause = Data.ProtoLens.fieldDefault,
         _ResourceExhaustedFailure'scope = Data.ProtoLens.fieldDefault,
         _ResourceExhaustedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ResourceExhaustedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser ResourceExhaustedFailure
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
                                       "cause"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"cause") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "scope"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"scope") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ResourceExhaustedFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"cause") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"scope") _x
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
instance Control.DeepSeq.NFData ResourceExhaustedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ResourceExhaustedFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ResourceExhaustedFailure'cause x__)
                (Control.DeepSeq.deepseq (_ResourceExhaustedFailure'scope x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.serverVersion' @:: Lens' ServerVersionNotSupportedFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.clientSupportedServerVersions' @:: Lens' ServerVersionNotSupportedFailure Data.Text.Text@ -}
data ServerVersionNotSupportedFailure
  = ServerVersionNotSupportedFailure'_constructor {_ServerVersionNotSupportedFailure'serverVersion :: !Data.Text.Text,
                                                   _ServerVersionNotSupportedFailure'clientSupportedServerVersions :: !Data.Text.Text,
                                                   _ServerVersionNotSupportedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ServerVersionNotSupportedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ServerVersionNotSupportedFailure "serverVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ServerVersionNotSupportedFailure'serverVersion
           (\ x__ y__
              -> x__ {_ServerVersionNotSupportedFailure'serverVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ServerVersionNotSupportedFailure "clientSupportedServerVersions" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ServerVersionNotSupportedFailure'clientSupportedServerVersions
           (\ x__ y__
              -> x__
                   {_ServerVersionNotSupportedFailure'clientSupportedServerVersions = y__}))
        Prelude.id
instance Data.ProtoLens.Message ServerVersionNotSupportedFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.ServerVersionNotSupportedFailure"
  packedMessageDescriptor _
    = "\n\
      \ ServerVersionNotSupportedFailure\DC2%\n\
      \\SOserver_version\CAN\SOH \SOH(\tR\rserverVersion\DC2G\n\
      \ client_supported_server_versions\CAN\STX \SOH(\tR\GSclientSupportedServerVersions"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        serverVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "server_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"serverVersion")) ::
              Data.ProtoLens.FieldDescriptor ServerVersionNotSupportedFailure
        clientSupportedServerVersions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "client_supported_server_versions"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"clientSupportedServerVersions")) ::
              Data.ProtoLens.FieldDescriptor ServerVersionNotSupportedFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, serverVersion__field_descriptor),
           (Data.ProtoLens.Tag 2, 
            clientSupportedServerVersions__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ServerVersionNotSupportedFailure'_unknownFields
        (\ x__ y__
           -> x__ {_ServerVersionNotSupportedFailure'_unknownFields = y__})
  defMessage
    = ServerVersionNotSupportedFailure'_constructor
        {_ServerVersionNotSupportedFailure'serverVersion = Data.ProtoLens.fieldDefault,
         _ServerVersionNotSupportedFailure'clientSupportedServerVersions = Data.ProtoLens.fieldDefault,
         _ServerVersionNotSupportedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ServerVersionNotSupportedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser ServerVersionNotSupportedFailure
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
                                       "server_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"serverVersion") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "client_supported_server_versions"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"clientSupportedServerVersions") y
                                     x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage)
          "ServerVersionNotSupportedFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"serverVersion") _x
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
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"clientSupportedServerVersions") _x
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
instance Control.DeepSeq.NFData ServerVersionNotSupportedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ServerVersionNotSupportedFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ServerVersionNotSupportedFailure'serverVersion x__)
                (Control.DeepSeq.deepseq
                   (_ServerVersionNotSupportedFailure'clientSupportedServerVersions
                      x__)
                   ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.workflowExecution' @:: Lens' SystemWorkflowFailure Proto.Temporal.Api.Common.V1.Message.WorkflowExecution@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.maybe'workflowExecution' @:: Lens' SystemWorkflowFailure (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.workflowError' @:: Lens' SystemWorkflowFailure Data.Text.Text@ -}
data SystemWorkflowFailure
  = SystemWorkflowFailure'_constructor {_SystemWorkflowFailure'workflowExecution :: !(Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution),
                                        _SystemWorkflowFailure'workflowError :: !Data.Text.Text,
                                        _SystemWorkflowFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SystemWorkflowFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SystemWorkflowFailure "workflowExecution" Proto.Temporal.Api.Common.V1.Message.WorkflowExecution where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SystemWorkflowFailure'workflowExecution
           (\ x__ y__
              -> x__ {_SystemWorkflowFailure'workflowExecution = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField SystemWorkflowFailure "maybe'workflowExecution" (Prelude.Maybe Proto.Temporal.Api.Common.V1.Message.WorkflowExecution) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SystemWorkflowFailure'workflowExecution
           (\ x__ y__
              -> x__ {_SystemWorkflowFailure'workflowExecution = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SystemWorkflowFailure "workflowError" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SystemWorkflowFailure'workflowError
           (\ x__ y__ -> x__ {_SystemWorkflowFailure'workflowError = y__}))
        Prelude.id
instance Data.ProtoLens.Message SystemWorkflowFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.SystemWorkflowFailure"
  packedMessageDescriptor _
    = "\n\
      \\NAKSystemWorkflowFailure\DC2X\n\
      \\DC2workflow_execution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\DC1workflowExecution\DC2%\n\
      \\SOworkflow_error\CAN\STX \SOH(\tR\rworkflowError"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowExecution__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_execution"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Common.V1.Message.WorkflowExecution)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowExecution")) ::
              Data.ProtoLens.FieldDescriptor SystemWorkflowFailure
        workflowError__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_error"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowError")) ::
              Data.ProtoLens.FieldDescriptor SystemWorkflowFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowExecution__field_descriptor),
           (Data.ProtoLens.Tag 2, workflowError__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SystemWorkflowFailure'_unknownFields
        (\ x__ y__ -> x__ {_SystemWorkflowFailure'_unknownFields = y__})
  defMessage
    = SystemWorkflowFailure'_constructor
        {_SystemWorkflowFailure'workflowExecution = Prelude.Nothing,
         _SystemWorkflowFailure'workflowError = Data.ProtoLens.fieldDefault,
         _SystemWorkflowFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SystemWorkflowFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser SystemWorkflowFailure
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
                                       "workflow_execution"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowExecution") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "workflow_error"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowError") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SystemWorkflowFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'workflowExecution") _x
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
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"workflowError") _x
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
instance Control.DeepSeq.NFData SystemWorkflowFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SystemWorkflowFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SystemWorkflowFailure'workflowExecution x__)
                (Control.DeepSeq.deepseq
                   (_SystemWorkflowFailure'workflowError x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.startRequestId' @:: Lens' WorkflowExecutionAlreadyStartedFailure Data.Text.Text@
         * 'Proto.Temporal.Api.Errordetails.V1.Message_Fields.runId' @:: Lens' WorkflowExecutionAlreadyStartedFailure Data.Text.Text@ -}
data WorkflowExecutionAlreadyStartedFailure
  = WorkflowExecutionAlreadyStartedFailure'_constructor {_WorkflowExecutionAlreadyStartedFailure'startRequestId :: !Data.Text.Text,
                                                         _WorkflowExecutionAlreadyStartedFailure'runId :: !Data.Text.Text,
                                                         _WorkflowExecutionAlreadyStartedFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowExecutionAlreadyStartedFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowExecutionAlreadyStartedFailure "startRequestId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionAlreadyStartedFailure'startRequestId
           (\ x__ y__
              -> x__
                   {_WorkflowExecutionAlreadyStartedFailure'startRequestId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowExecutionAlreadyStartedFailure "runId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowExecutionAlreadyStartedFailure'runId
           (\ x__ y__
              -> x__ {_WorkflowExecutionAlreadyStartedFailure'runId = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowExecutionAlreadyStartedFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.WorkflowExecutionAlreadyStartedFailure"
  packedMessageDescriptor _
    = "\n\
      \&WorkflowExecutionAlreadyStartedFailure\DC2(\n\
      \\DLEstart_request_id\CAN\SOH \SOH(\tR\SOstartRequestId\DC2\NAK\n\
      \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        startRequestId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_request_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"startRequestId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionAlreadyStartedFailure
        runId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "run_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"runId")) ::
              Data.ProtoLens.FieldDescriptor WorkflowExecutionAlreadyStartedFailure
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, startRequestId__field_descriptor),
           (Data.ProtoLens.Tag 2, runId__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowExecutionAlreadyStartedFailure'_unknownFields
        (\ x__ y__
           -> x__
                {_WorkflowExecutionAlreadyStartedFailure'_unknownFields = y__})
  defMessage
    = WorkflowExecutionAlreadyStartedFailure'_constructor
        {_WorkflowExecutionAlreadyStartedFailure'startRequestId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionAlreadyStartedFailure'runId = Data.ProtoLens.fieldDefault,
         _WorkflowExecutionAlreadyStartedFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowExecutionAlreadyStartedFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowExecutionAlreadyStartedFailure
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
                                       "start_request_id"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startRequestId") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
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
          "WorkflowExecutionAlreadyStartedFailure"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"startRequestId") _x
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"runId") _x
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
instance Control.DeepSeq.NFData WorkflowExecutionAlreadyStartedFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowExecutionAlreadyStartedFailure'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowExecutionAlreadyStartedFailure'startRequestId x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowExecutionAlreadyStartedFailure'runId x__) ()))
{- | Fields :
      -}
data WorkflowNotReadyFailure
  = WorkflowNotReadyFailure'_constructor {_WorkflowNotReadyFailure'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowNotReadyFailure where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message WorkflowNotReadyFailure where
  messageName _
    = Data.Text.pack
        "temporal.api.errordetails.v1.WorkflowNotReadyFailure"
  packedMessageDescriptor _
    = "\n\
      \\ETBWorkflowNotReadyFailure"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowNotReadyFailure'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowNotReadyFailure'_unknownFields = y__})
  defMessage
    = WorkflowNotReadyFailure'_constructor
        {_WorkflowNotReadyFailure'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowNotReadyFailure
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowNotReadyFailure
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
          (do loop Data.ProtoLens.defMessage) "WorkflowNotReadyFailure"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData WorkflowNotReadyFailure where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowNotReadyFailure'_unknownFields x__) ()
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \*temporal/api/errordetails/v1/message.proto\DC2\FStemporal.api.errordetails.v1\SUB\EMgoogle/protobuf/any.proto\SUB$temporal/api/common/v1/message.proto\SUB(temporal/api/enums/v1/failed_cause.proto\SUB%temporal/api/enums/v1/namespace.proto\"a\n\
    \\SINotFoundFailure\DC2'\n\
    \\SIcurrent_cluster\CAN\SOH \SOH(\tR\SOcurrentCluster\DC2%\n\
    \\SOactive_cluster\CAN\STX \SOH(\tR\ractiveCluster\"i\n\
    \&WorkflowExecutionAlreadyStartedFailure\DC2(\n\
    \\DLEstart_request_id\CAN\SOH \SOH(\tR\SOstartRequestId\DC2\NAK\n\
    \\ACKrun_id\CAN\STX \SOH(\tR\ENQrunId\"\137\SOH\n\
    \\EMNamespaceNotActiveFailure\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2'\n\
    \\SIcurrent_cluster\CAN\STX \SOH(\tR\SOcurrentCluster\DC2%\n\
    \\SOactive_cluster\CAN\ETX \SOH(\tR\ractiveCluster\"\199\SOH\n\
    \\FSNamespaceInvalidStateFailure\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\DC2;\n\
    \\ENQstate\CAN\STX \SOH(\SO2%.temporal.api.enums.v1.NamespaceStateR\ENQstate\DC2L\n\
    \\SOallowed_states\CAN\ETX \ETX(\SO2%.temporal.api.enums.v1.NamespaceStateR\rallowedStates\"8\n\
    \\CANNamespaceNotFoundFailure\DC2\FS\n\
    \\tnamespace\CAN\SOH \SOH(\tR\tnamespace\"\US\n\
    \\GSNamespaceAlreadyExistsFailure\"\153\SOH\n\
    \ ClientVersionNotSupportedFailure\DC2%\n\
    \\SOclient_version\CAN\SOH \SOH(\tR\rclientVersion\DC2\US\n\
    \\vclient_name\CAN\STX \SOH(\tR\n\
    \clientName\DC2-\n\
    \\DC2supported_versions\CAN\ETX \SOH(\tR\DC1supportedVersions\"\146\SOH\n\
    \ ServerVersionNotSupportedFailure\DC2%\n\
    \\SOserver_version\CAN\SOH \SOH(\tR\rserverVersion\DC2G\n\
    \ client_supported_server_versions\CAN\STX \SOH(\tR\GSclientSupportedServerVersions\"%\n\
    \#CancellationAlreadyRequestedFailure\"\DC4\n\
    \\DC2QueryFailedFailure\"1\n\
    \\ETBPermissionDeniedFailure\DC2\SYN\n\
    \\ACKreason\CAN\SOH \SOH(\tR\ACKreason\"\164\SOH\n\
    \\CANResourceExhaustedFailure\DC2C\n\
    \\ENQcause\CAN\SOH \SOH(\SO2-.temporal.api.enums.v1.ResourceExhaustedCauseR\ENQcause\DC2C\n\
    \\ENQscope\CAN\STX \SOH(\SO2-.temporal.api.enums.v1.ResourceExhaustedScopeR\ENQscope\"\152\SOH\n\
    \\NAKSystemWorkflowFailure\DC2X\n\
    \\DC2workflow_execution\CAN\SOH \SOH(\v2).temporal.api.common.v1.WorkflowExecutionR\DC1workflowExecution\DC2%\n\
    \\SOworkflow_error\CAN\STX \SOH(\tR\rworkflowError\"\EM\n\
    \\ETBWorkflowNotReadyFailure\"C\n\
    \\ETBNewerBuildExistsFailure\DC2(\n\
    \\DLEdefault_build_id\CAN\SOH \SOH(\tR\SOdefaultBuildId\"\251\SOH\n\
    \\RSMultiOperationExecutionFailure\DC2h\n\
    \\bstatuses\CAN\SOH \ETX(\v2L.temporal.api.errordetails.v1.MultiOperationExecutionFailure.OperationStatusR\bstatuses\SUBo\n\
    \\SIOperationStatus\DC2\DC2\n\
    \\EOTcode\CAN\SOH \SOH(\ENQR\EOTcode\DC2\CAN\n\
    \\amessage\CAN\STX \SOH(\tR\amessage\DC2.\n\
    \\adetails\CAN\ETX \ETX(\v2\DC4.google.protobuf.AnyR\adetailsB\167\SOH\n\
    \\USio.temporal.api.errordetails.v1B\fMessageProtoP\SOHZ/go.temporal.io/api/errordetails/v1;errordetails\170\STX\RSTemporalio.Api.ErrorDetails.V1\234\STX!Temporalio::Api::ErrorDetails::V1J\181$\n\
    \\a\DC2\ENQ\SYN\NUL\132\SOH\SOH\n\
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
    \\177\STX\n\
    \\SOH\STX\DC2\ETX\ESC\NUL%2\166\STX These error details are supplied in google.rpc.Status#details as described in \"Google APIs, Error Model\" (https://cloud.google.com/apis/design/errors#error_model)\n\
    \ and extend standard Error Details defined in https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto\n\
    \\n\
    \\b\n\
    \\SOH\b\DC2\ETX\GS\NULF\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\GS\NULF\n\
    \\b\n\
    \\SOH\b\DC2\ETX\RS\NUL8\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\RS\NUL8\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\US\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX \NUL-\n\
    \\t\n\
    \\STX\b\b\DC2\ETX \NUL-\n\
    \\b\n\
    \\SOH\b\DC2\ETX!\NUL:\n\
    \\t\n\
    \\STX\b-\DC2\ETX!\NUL:\n\
    \\b\n\
    \\SOH\b\DC2\ETX\"\NUL;\n\
    \\t\n\
    \\STX\b%\DC2\ETX\"\NUL;\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX$\NUL#\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX%\NUL.\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX'\NUL2\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX(\NUL/\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT*\NUL-\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX*\b\ETB\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX+\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX+\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX+\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX+\GS\RS\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX,\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX,\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX,\v\EM\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX,\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT/\NUL2\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX/\b.\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX0\EOT \n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX0\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX0\v\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX0\RS\US\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX1\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX1\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX1\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX1\DC4\NAK\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT4\NUL8\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX4\b!\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX5\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX5\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX5\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX5\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX6\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX6\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX6\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX6\GS\RS\n\
    \\v\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETX7\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\ETX7\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETX7\v\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETX7\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT:\NULA\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX:\b$\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX;\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETX;\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX;\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX;\ETB\CAN\n\
    \8\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETX=\EOT3\SUB+ Current state of the requested namespace.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ACK\DC2\ETX=\EOT(\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETX=).\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETX=12\n\
    \\170\SOH\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETX@\EOTE\SUB\156\SOH Allowed namespace states for requested operation.\n\
    \ For example NAMESPACE_STATE_DELETED is forbidden for most operations but allowed for DescribeNamespace.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\EOT\DC2\ETX@\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ACK\DC2\ETX@\r1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETX@2@\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETX@CD\n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOTC\NULE\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETXC\b \n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETXD\EOT\EM\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ENQ\DC2\ETXD\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETXD\v\DC4\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETXD\ETB\CAN\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOTG\NULH\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETXG\b%\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOTJ\NULN\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETXJ\b(\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETXK\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETXK\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETXK\v\EM\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETXK\FS\GS\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXL\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXL\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXL\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXL\EM\SUB\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETXM\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ENQ\DC2\ETXM\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETXM\v\GS\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETXM !\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOTP\NULS\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXP\b(\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXQ\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ENQ\DC2\ETXQ\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXQ\v\EM\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXQ\FS\GS\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETXR\EOT0\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\ETXR\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETXR\v+\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETXR./\n\
    \\n\
    \\n\
    \\STX\EOT\b\DC2\EOTU\NULV\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXU\b+\n\
    \\n\
    \\n\
    \\STX\EOT\t\DC2\EOTX\NULY\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETXX\b\SUB\n\
    \\n\
    \\n\
    \\STX\EOT\n\
    \\DC2\EOT[\NUL]\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETX[\b\US\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETX\\\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETX\\\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETX\\\v\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETX\\\DC4\NAK\n\
    \\n\
    \\n\
    \\STX\EOT\v\DC2\EOT_\NULb\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETX_\b \n\
    \\v\n\
    \\EOT\EOT\v\STX\NUL\DC2\ETX`\EOT;\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ACK\DC2\ETX`\EOT0\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\ETX`16\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\ETX`9:\n\
    \\v\n\
    \\EOT\EOT\v\STX\SOH\DC2\ETXa\EOT;\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\ETXa\EOT0\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\ETXa16\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\ETXa9:\n\
    \\n\
    \\n\
    \\STX\EOT\f\DC2\EOTd\NULj\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\f\SOH\DC2\ETXd\b\GS\n\
    \\202\SOH\n\
    \\EOT\EOT\f\STX\NUL\DC2\ETXg\EOTD\SUB\188\SOH WorkflowId and RunId of the Temporal system workflow performing the underlying operation.\n\
    \ Looking up the info of the system workflow run may help identify the issue causing the failure.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ACK\DC2\ETXg\EOT,\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\SOH\DC2\ETXg-?\n\
    \\f\n\
    \\ENQ\EOT\f\STX\NUL\ETX\DC2\ETXgBC\n\
    \d\n\
    \\EOT\EOT\f\STX\SOH\DC2\ETXi\EOT\RS\SUBW Serialized error returned by the system workflow performing the underlying operation.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ENQ\DC2\ETXi\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\SOH\DC2\ETXi\v\EM\n\
    \\f\n\
    \\ENQ\EOT\f\STX\SOH\ETX\DC2\ETXi\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\r\DC2\EOTl\NULm\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\r\SOH\DC2\ETXl\b\US\n\
    \\n\
    \\n\
    \\STX\EOT\SO\DC2\EOTo\NULr\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SO\SOH\DC2\ETXo\b\US\n\
    \O\n\
    \\EOT\EOT\SO\STX\NUL\DC2\ETXq\EOT \SUBB The current default compatible build ID which will receive tasks\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\ENQ\DC2\ETXq\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\SOH\DC2\ETXq\v\ESC\n\
    \\f\n\
    \\ENQ\EOT\SO\STX\NUL\ETX\DC2\ETXq\RS\US\n\
    \\v\n\
    \\STX\EOT\SI\DC2\ENQt\NUL\132\SOH\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SI\SOH\DC2\ETXt\b&\n\
    \\167\STX\n\
    \\EOT\EOT\SI\STX\NUL\DC2\ETXx\EOT*\SUB\153\STX One status for each requested operation from the failed MultiOperation. The failed\n\
    \ operation(s) have the same error details as if it was executed separately. All other operations have the\n\
    \ status code `Aborted` and `MultiOperationExecutionAborted` is added to the details field.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SI\STX\NUL\EOT\DC2\ETXx\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\SI\STX\NUL\ACK\DC2\ETXx\r\FS\n\
    \\f\n\
    \\ENQ\EOT\SI\STX\NUL\SOH\DC2\ETXx\GS%\n\
    \\f\n\
    \\ENQ\EOT\SI\STX\NUL\ETX\DC2\ETXx()\n\
    \\154\STX\n\
    \\EOT\EOT\SI\ETX\NUL\DC2\ENQ\DEL\EOT\131\SOH\ENQ\SUB\138\STX NOTE: `OperationStatus` is modelled after\n\
    \ [`google.rpc.Status`](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto).\n\
    \\n\
    \ (-- api-linter: core::0146::any=disabled\n\
    \     aip.dev/not-precedent: details are meant to hold arbitrary payloads. --)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SI\ETX\NUL\SOH\DC2\ETX\DEL\f\ESC\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\NUL\DC2\EOT\128\SOH\b\ETB\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\NUL\ENQ\DC2\EOT\128\SOH\b\r\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\NUL\SOH\DC2\EOT\128\SOH\SO\DC2\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\NUL\ETX\DC2\EOT\128\SOH\NAK\SYN\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\SOH\DC2\EOT\129\SOH\b\ESC\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\SOH\ENQ\DC2\EOT\129\SOH\b\SO\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\SOH\SOH\DC2\EOT\129\SOH\SI\SYN\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\SOH\ETX\DC2\EOT\129\SOH\EM\SUB\n\
    \\SO\n\
    \\ACK\EOT\SI\ETX\NUL\STX\STX\DC2\EOT\130\SOH\b1\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\EOT\DC2\EOT\130\SOH\b\DLE\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\ACK\DC2\EOT\130\SOH\DC1$\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\SOH\DC2\EOT\130\SOH%,\n\
    \\SI\n\
    \\a\EOT\SI\ETX\NUL\STX\STX\ETX\DC2\EOT\130\SOH/0b\ACKproto3"
