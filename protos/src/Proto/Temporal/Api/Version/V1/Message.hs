{- This file was auto-generated from temporal/api/version/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Version.V1.Message (
        Alert(), ReleaseInfo(), VersionInfo()
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
import qualified Proto.Google.Protobuf.Timestamp
import qualified Proto.Temporal.Api.Enums.V1.Common
{- | Fields :
     
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.message' @:: Lens' Alert Data.Text.Text@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.severity' @:: Lens' Alert Proto.Temporal.Api.Enums.V1.Common.Severity@ -}
data Alert
  = Alert'_constructor {_Alert'message :: !Data.Text.Text,
                        _Alert'severity :: !Proto.Temporal.Api.Enums.V1.Common.Severity,
                        _Alert'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Alert where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Alert "message" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Alert'message (\ x__ y__ -> x__ {_Alert'message = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Alert "severity" Proto.Temporal.Api.Enums.V1.Common.Severity where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Alert'severity (\ x__ y__ -> x__ {_Alert'severity = y__}))
        Prelude.id
instance Data.ProtoLens.Message Alert where
  messageName _ = Data.Text.pack "temporal.api.version.v1.Alert"
  packedMessageDescriptor _
    = "\n\
      \\ENQAlert\DC2\CAN\n\
      \\amessage\CAN\SOH \SOH(\tR\amessage\DC2;\n\
      \\bseverity\CAN\STX \SOH(\SO2\US.temporal.api.enums.v1.SeverityR\bseverity"
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
              Data.ProtoLens.FieldDescriptor Alert
        severity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "severity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.Severity)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"severity")) ::
              Data.ProtoLens.FieldDescriptor Alert
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, message__field_descriptor),
           (Data.ProtoLens.Tag 2, severity__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Alert'_unknownFields
        (\ x__ y__ -> x__ {_Alert'_unknownFields = y__})
  defMessage
    = Alert'_constructor
        {_Alert'message = Data.ProtoLens.fieldDefault,
         _Alert'severity = Data.ProtoLens.fieldDefault,
         _Alert'_unknownFields = []}
  parseMessage
    = let
        loop :: Alert -> Data.ProtoLens.Encoding.Bytes.Parser Alert
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
                                       "severity"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"severity") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Alert"
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
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"severity") _x
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
instance Control.DeepSeq.NFData Alert where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Alert'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Alert'message x__)
                (Control.DeepSeq.deepseq (_Alert'severity x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.version' @:: Lens' ReleaseInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.releaseTime' @:: Lens' ReleaseInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.maybe'releaseTime' @:: Lens' ReleaseInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.notes' @:: Lens' ReleaseInfo Data.Text.Text@ -}
data ReleaseInfo
  = ReleaseInfo'_constructor {_ReleaseInfo'version :: !Data.Text.Text,
                              _ReleaseInfo'releaseTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                              _ReleaseInfo'notes :: !Data.Text.Text,
                              _ReleaseInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ReleaseInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ReleaseInfo "version" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReleaseInfo'version
           (\ x__ y__ -> x__ {_ReleaseInfo'version = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReleaseInfo "releaseTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReleaseInfo'releaseTime
           (\ x__ y__ -> x__ {_ReleaseInfo'releaseTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ReleaseInfo "maybe'releaseTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReleaseInfo'releaseTime
           (\ x__ y__ -> x__ {_ReleaseInfo'releaseTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReleaseInfo "notes" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReleaseInfo'notes (\ x__ y__ -> x__ {_ReleaseInfo'notes = y__}))
        Prelude.id
instance Data.ProtoLens.Message ReleaseInfo where
  messageName _
    = Data.Text.pack "temporal.api.version.v1.ReleaseInfo"
  packedMessageDescriptor _
    = "\n\
      \\vReleaseInfo\DC2\CAN\n\
      \\aversion\CAN\SOH \SOH(\tR\aversion\DC2C\n\
      \\frelease_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\vreleaseTimeB\EOT\144\223\US\SOH\DC2\DC4\n\
      \\ENQnotes\CAN\ETX \SOH(\tR\ENQnotes"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        version__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"version")) ::
              Data.ProtoLens.FieldDescriptor ReleaseInfo
        releaseTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "release_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'releaseTime")) ::
              Data.ProtoLens.FieldDescriptor ReleaseInfo
        notes__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "notes"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"notes")) ::
              Data.ProtoLens.FieldDescriptor ReleaseInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, version__field_descriptor),
           (Data.ProtoLens.Tag 2, releaseTime__field_descriptor),
           (Data.ProtoLens.Tag 3, notes__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ReleaseInfo'_unknownFields
        (\ x__ y__ -> x__ {_ReleaseInfo'_unknownFields = y__})
  defMessage
    = ReleaseInfo'_constructor
        {_ReleaseInfo'version = Data.ProtoLens.fieldDefault,
         _ReleaseInfo'releaseTime = Prelude.Nothing,
         _ReleaseInfo'notes = Data.ProtoLens.fieldDefault,
         _ReleaseInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ReleaseInfo -> Data.ProtoLens.Encoding.Bytes.Parser ReleaseInfo
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
                                       "version"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"version") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "release_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"releaseTime") y x)
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
                                       "notes"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"notes") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ReleaseInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"version") _x
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
                       (Data.ProtoLens.Field.field @"maybe'releaseTime") _x
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
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"notes") _x
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
instance Control.DeepSeq.NFData ReleaseInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ReleaseInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ReleaseInfo'version x__)
                (Control.DeepSeq.deepseq
                   (_ReleaseInfo'releaseTime x__)
                   (Control.DeepSeq.deepseq (_ReleaseInfo'notes x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.current' @:: Lens' VersionInfo ReleaseInfo@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.maybe'current' @:: Lens' VersionInfo (Prelude.Maybe ReleaseInfo)@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.recommended' @:: Lens' VersionInfo ReleaseInfo@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.maybe'recommended' @:: Lens' VersionInfo (Prelude.Maybe ReleaseInfo)@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.instructions' @:: Lens' VersionInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.alerts' @:: Lens' VersionInfo [Alert]@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.vec'alerts' @:: Lens' VersionInfo (Data.Vector.Vector Alert)@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.lastUpdateTime' @:: Lens' VersionInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Version.V1.Message_Fields.maybe'lastUpdateTime' @:: Lens' VersionInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@ -}
data VersionInfo
  = VersionInfo'_constructor {_VersionInfo'current :: !(Prelude.Maybe ReleaseInfo),
                              _VersionInfo'recommended :: !(Prelude.Maybe ReleaseInfo),
                              _VersionInfo'instructions :: !Data.Text.Text,
                              _VersionInfo'alerts :: !(Data.Vector.Vector Alert),
                              _VersionInfo'lastUpdateTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                              _VersionInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show VersionInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField VersionInfo "current" ReleaseInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'current
           (\ x__ y__ -> x__ {_VersionInfo'current = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField VersionInfo "maybe'current" (Prelude.Maybe ReleaseInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'current
           (\ x__ y__ -> x__ {_VersionInfo'current = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField VersionInfo "recommended" ReleaseInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'recommended
           (\ x__ y__ -> x__ {_VersionInfo'recommended = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField VersionInfo "maybe'recommended" (Prelude.Maybe ReleaseInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'recommended
           (\ x__ y__ -> x__ {_VersionInfo'recommended = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField VersionInfo "instructions" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'instructions
           (\ x__ y__ -> x__ {_VersionInfo'instructions = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField VersionInfo "alerts" [Alert] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'alerts (\ x__ y__ -> x__ {_VersionInfo'alerts = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField VersionInfo "vec'alerts" (Data.Vector.Vector Alert) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'alerts (\ x__ y__ -> x__ {_VersionInfo'alerts = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField VersionInfo "lastUpdateTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'lastUpdateTime
           (\ x__ y__ -> x__ {_VersionInfo'lastUpdateTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField VersionInfo "maybe'lastUpdateTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _VersionInfo'lastUpdateTime
           (\ x__ y__ -> x__ {_VersionInfo'lastUpdateTime = y__}))
        Prelude.id
instance Data.ProtoLens.Message VersionInfo where
  messageName _
    = Data.Text.pack "temporal.api.version.v1.VersionInfo"
  packedMessageDescriptor _
    = "\n\
      \\vVersionInfo\DC2>\n\
      \\acurrent\CAN\SOH \SOH(\v2$.temporal.api.version.v1.ReleaseInfoR\acurrent\DC2F\n\
      \\vrecommended\CAN\STX \SOH(\v2$.temporal.api.version.v1.ReleaseInfoR\vrecommended\DC2\"\n\
      \\finstructions\CAN\ETX \SOH(\tR\finstructions\DC26\n\
      \\ACKalerts\CAN\EOT \ETX(\v2\RS.temporal.api.version.v1.AlertR\ACKalerts\DC2J\n\
      \\DLElast_update_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\SOlastUpdateTimeB\EOT\144\223\US\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        current__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ReleaseInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'current")) ::
              Data.ProtoLens.FieldDescriptor VersionInfo
        recommended__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "recommended"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor ReleaseInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'recommended")) ::
              Data.ProtoLens.FieldDescriptor VersionInfo
        instructions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "instructions"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"instructions")) ::
              Data.ProtoLens.FieldDescriptor VersionInfo
        alerts__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "alerts"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Alert)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"alerts")) ::
              Data.ProtoLens.FieldDescriptor VersionInfo
        lastUpdateTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_update_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastUpdateTime")) ::
              Data.ProtoLens.FieldDescriptor VersionInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, current__field_descriptor),
           (Data.ProtoLens.Tag 2, recommended__field_descriptor),
           (Data.ProtoLens.Tag 3, instructions__field_descriptor),
           (Data.ProtoLens.Tag 4, alerts__field_descriptor),
           (Data.ProtoLens.Tag 5, lastUpdateTime__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _VersionInfo'_unknownFields
        (\ x__ y__ -> x__ {_VersionInfo'_unknownFields = y__})
  defMessage
    = VersionInfo'_constructor
        {_VersionInfo'current = Prelude.Nothing,
         _VersionInfo'recommended = Prelude.Nothing,
         _VersionInfo'instructions = Data.ProtoLens.fieldDefault,
         _VersionInfo'alerts = Data.Vector.Generic.empty,
         _VersionInfo'lastUpdateTime = Prelude.Nothing,
         _VersionInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          VersionInfo
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Alert
             -> Data.ProtoLens.Encoding.Bytes.Parser VersionInfo
        loop x mutable'alerts
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'alerts <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'alerts)
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
                              (Data.ProtoLens.Field.field @"vec'alerts") frozen'alerts x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "current"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"current") y x)
                                  mutable'alerts
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "recommended"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"recommended") y x)
                                  mutable'alerts
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
                                       "instructions"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"instructions") y x)
                                  mutable'alerts
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "alerts"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'alerts y)
                                loop x v
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_update_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastUpdateTime") y x)
                                  mutable'alerts
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'alerts
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'alerts <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'alerts)
          "VersionInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'current") _x
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
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'recommended") _x
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
                        = Lens.Family2.view (Data.ProtoLens.Field.field @"instructions") _x
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
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.ProtoLens.encodeMessage _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'alerts") _x))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'lastUpdateTime") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData VersionInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_VersionInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_VersionInfo'current x__)
                (Control.DeepSeq.deepseq
                   (_VersionInfo'recommended x__)
                   (Control.DeepSeq.deepseq
                      (_VersionInfo'instructions x__)
                      (Control.DeepSeq.deepseq
                         (_VersionInfo'alerts x__)
                         (Control.DeepSeq.deepseq (_VersionInfo'lastUpdateTime x__) ())))))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \%temporal/api/version/v1/message.proto\DC2\ETBtemporal.api.version.v1\SUB\USgoogle/protobuf/timestamp.proto\SUB!dependencies/gogoproto/gogo.proto\SUB\"temporal/api/enums/v1/common.proto\"\130\SOH\n\
    \\vReleaseInfo\DC2\CAN\n\
    \\aversion\CAN\SOH \SOH(\tR\aversion\DC2C\n\
    \\frelease_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\vreleaseTimeB\EOT\144\223\US\SOH\DC2\DC4\n\
    \\ENQnotes\CAN\ETX \SOH(\tR\ENQnotes\"^\n\
    \\ENQAlert\DC2\CAN\n\
    \\amessage\CAN\SOH \SOH(\tR\amessage\DC2;\n\
    \\bseverity\CAN\STX \SOH(\SO2\US.temporal.api.enums.v1.SeverityR\bseverity\"\189\STX\n\
    \\vVersionInfo\DC2>\n\
    \\acurrent\CAN\SOH \SOH(\v2$.temporal.api.version.v1.ReleaseInfoR\acurrent\DC2F\n\
    \\vrecommended\CAN\STX \SOH(\v2$.temporal.api.version.v1.ReleaseInfoR\vrecommended\DC2\"\n\
    \\finstructions\CAN\ETX \SOH(\tR\finstructions\DC26\n\
    \\ACKalerts\CAN\EOT \ETX(\v2\RS.temporal.api.version.v1.AlertR\ACKalerts\DC2J\n\
    \\DLElast_update_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\SOlastUpdateTimeB\EOT\144\223\US\SOHB\142\SOH\n\
    \\SUBio.temporal.api.version.v1B\fMessageProtoP\SOHZ%go.temporal.io/api/version/v1;version\170\STX\EMTemporalio.Api.Version.V1\234\STX\FSTemporalio::Api::Version::V1J\208\DC1\n\
    \\ACK\DC2\EOT\SYN\NUL9\SOH\n\
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
    \\SOH\STX\DC2\ETX\CAN\NUL \n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL<\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\SUB\NUL<\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL3\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL3\n\
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
    \\SOH\b\DC2\ETX\RS\NUL5\n\
    \\t\n\
    \\STX\b-\DC2\ETX\RS\NUL5\n\
    \\b\n\
    \\SOH\b\DC2\ETX\US\NUL6\n\
    \\t\n\
    \\STX\b%\DC2\ETX\US\NUL6\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX!\NUL)\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\"\NUL+\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX#\NUL,\n\
    \R\n\
    \\STX\EOT\NUL\DC2\EOT&\NUL*\SOH\SUBF ReleaseInfo contains information about specific version of temporal.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX&\b\DC3\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX'\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX'\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX'\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX'\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX(\EOTL\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX(\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX(\RS*\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX(-.\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\b\DC2\ETX(/K\n\
    \\SI\n\
    \\b\EOT\NUL\STX\SOH\b\242\251\ETX\DC2\ETX(0J\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX)\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX)\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX)\v\DLE\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX)\DC3\DC4\n\
    \7\n\
    \\STX\EOT\SOH\DC2\EOT-\NUL0\SOH\SUB+ Alert contains notification and severity.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX-\b\r\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX.\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX.\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX.\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX.\NAK\SYN\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX/\EOT0\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX/\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX/#+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX/./\n\
    \\133\SOH\n\
    \\STX\EOT\STX\DC2\EOT3\NUL9\SOH\SUBy VersionInfo contains details about current and recommended release versions as well as alerts and upgrade instructions.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX3\b\DC3\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX4\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX4\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX4\DLE\ETB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX4\SUB\ESC\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX5\EOT \n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETX5\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX5\DLE\ESC\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX5\RS\US\n\
    \\v\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETX6\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\ETX6\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETX6\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETX6\SUB\ESC\n\
    \\v\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETX7\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\EOT\DC2\ETX7\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ACK\DC2\ETX7\r\DC2\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETX7\DC3\EM\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETX7\FS\GS\n\
    \\v\n\
    \\EOT\EOT\STX\STX\EOT\DC2\ETX8\EOTP\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ACK\DC2\ETX8\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\ETX8\RS.\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\ETX812\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\b\DC2\ETX83O\n\
    \\SI\n\
    \\b\EOT\STX\STX\EOT\b\242\251\ETX\DC2\ETX84Nb\ACKproto3"