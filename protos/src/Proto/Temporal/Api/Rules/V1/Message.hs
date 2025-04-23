{- This file was auto-generated from temporal/api/rules/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Rules.V1.Message (
        WorkflowRule(), WorkflowRuleAction(),
        WorkflowRuleAction'Variant(..), _WorkflowRuleAction'ActivityPause,
        WorkflowRuleAction'ActionActivityPause(), WorkflowRuleSpec(),
        WorkflowRuleSpec'Trigger(..), _WorkflowRuleSpec'ActivityStart,
        WorkflowRuleSpec'ActivityStartingTrigger()
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
{- | Fields :
     
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.createTime' @:: Lens' WorkflowRule Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'createTime' @:: Lens' WorkflowRule (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.spec' @:: Lens' WorkflowRule WorkflowRuleSpec@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'spec' @:: Lens' WorkflowRule (Prelude.Maybe WorkflowRuleSpec)@ -}
data WorkflowRule
  = WorkflowRule'_constructor {_WorkflowRule'createTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                               _WorkflowRule'spec :: !(Prelude.Maybe WorkflowRuleSpec),
                               _WorkflowRule'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowRule where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowRule "createTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRule'createTime
           (\ x__ y__ -> x__ {_WorkflowRule'createTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowRule "maybe'createTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRule'createTime
           (\ x__ y__ -> x__ {_WorkflowRule'createTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRule "spec" WorkflowRuleSpec where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRule'spec (\ x__ y__ -> x__ {_WorkflowRule'spec = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowRule "maybe'spec" (Prelude.Maybe WorkflowRuleSpec) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRule'spec (\ x__ y__ -> x__ {_WorkflowRule'spec = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowRule where
  messageName _ = Data.Text.pack "temporal.api.rules.v1.WorkflowRule"
  packedMessageDescriptor _
    = "\n\
      \\fWorkflowRule\DC2;\n\
      \\vcreate_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\n\
      \createTime\DC2;\n\
      \\EOTspec\CAN\STX \SOH(\v2'.temporal.api.rules.v1.WorkflowRuleSpecR\EOTspec"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        createTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "create_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'createTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRule
        spec__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "spec"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowRuleSpec)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'spec")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRule
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, createTime__field_descriptor),
           (Data.ProtoLens.Tag 2, spec__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowRule'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowRule'_unknownFields = y__})
  defMessage
    = WorkflowRule'_constructor
        {_WorkflowRule'createTime = Prelude.Nothing,
         _WorkflowRule'spec = Prelude.Nothing,
         _WorkflowRule'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowRule -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowRule
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
                                       "create_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"createTime") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "spec"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"spec") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowRule"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'createTime") _x
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
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'spec") _x
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
instance Control.DeepSeq.NFData WorkflowRule where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowRule'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowRule'createTime x__)
                (Control.DeepSeq.deepseq (_WorkflowRule'spec x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'variant' @:: Lens' WorkflowRuleAction (Prelude.Maybe WorkflowRuleAction'Variant)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'activityPause' @:: Lens' WorkflowRuleAction (Prelude.Maybe WorkflowRuleAction'ActionActivityPause)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.activityPause' @:: Lens' WorkflowRuleAction WorkflowRuleAction'ActionActivityPause@ -}
data WorkflowRuleAction
  = WorkflowRuleAction'_constructor {_WorkflowRuleAction'variant :: !(Prelude.Maybe WorkflowRuleAction'Variant),
                                     _WorkflowRuleAction'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowRuleAction where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data WorkflowRuleAction'Variant
  = WorkflowRuleAction'ActivityPause !WorkflowRuleAction'ActionActivityPause
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField WorkflowRuleAction "maybe'variant" (Prelude.Maybe WorkflowRuleAction'Variant) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleAction'variant
           (\ x__ y__ -> x__ {_WorkflowRuleAction'variant = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRuleAction "maybe'activityPause" (Prelude.Maybe WorkflowRuleAction'ActionActivityPause) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleAction'variant
           (\ x__ y__ -> x__ {_WorkflowRuleAction'variant = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowRuleAction'ActivityPause x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowRuleAction'ActivityPause y__))
instance Data.ProtoLens.Field.HasField WorkflowRuleAction "activityPause" WorkflowRuleAction'ActionActivityPause where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleAction'variant
           (\ x__ y__ -> x__ {_WorkflowRuleAction'variant = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowRuleAction'ActivityPause x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowRuleAction'ActivityPause y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message WorkflowRuleAction where
  messageName _
    = Data.Text.pack "temporal.api.rules.v1.WorkflowRuleAction"
  packedMessageDescriptor _
    = "\n\
      \\DC2WorkflowRuleAction\DC2f\n\
      \\SOactivity_pause\CAN\SOH \SOH(\v2=.temporal.api.rules.v1.WorkflowRuleAction.ActionActivityPauseH\NULR\ractivityPause\SUB\NAK\n\
      \\DC3ActionActivityPauseB\t\n\
      \\avariant"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        activityPause__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_pause"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowRuleAction'ActionActivityPause)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'activityPause")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleAction
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, activityPause__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowRuleAction'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowRuleAction'_unknownFields = y__})
  defMessage
    = WorkflowRuleAction'_constructor
        {_WorkflowRuleAction'variant = Prelude.Nothing,
         _WorkflowRuleAction'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowRuleAction
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowRuleAction
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
                                       "activity_pause"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityPause") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowRuleAction"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'variant") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just (WorkflowRuleAction'ActivityPause v))
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData WorkflowRuleAction where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowRuleAction'_unknownFields x__)
             (Control.DeepSeq.deepseq (_WorkflowRuleAction'variant x__) ())
instance Control.DeepSeq.NFData WorkflowRuleAction'Variant where
  rnf (WorkflowRuleAction'ActivityPause x__)
    = Control.DeepSeq.rnf x__
_WorkflowRuleAction'ActivityPause ::
  Data.ProtoLens.Prism.Prism' WorkflowRuleAction'Variant WorkflowRuleAction'ActionActivityPause
_WorkflowRuleAction'ActivityPause
  = Data.ProtoLens.Prism.prism'
      WorkflowRuleAction'ActivityPause
      (\ p__
         -> case p__ of
              (WorkflowRuleAction'ActivityPause p__val) -> Prelude.Just p__val)
{- | Fields :
      -}
data WorkflowRuleAction'ActionActivityPause
  = WorkflowRuleAction'ActionActivityPause'_constructor {_WorkflowRuleAction'ActionActivityPause'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowRuleAction'ActionActivityPause where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Message WorkflowRuleAction'ActionActivityPause where
  messageName _
    = Data.Text.pack
        "temporal.api.rules.v1.WorkflowRuleAction.ActionActivityPause"
  packedMessageDescriptor _
    = "\n\
      \\DC3ActionActivityPause"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag = let in Data.Map.fromList []
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowRuleAction'ActionActivityPause'_unknownFields
        (\ x__ y__
           -> x__
                {_WorkflowRuleAction'ActionActivityPause'_unknownFields = y__})
  defMessage
    = WorkflowRuleAction'ActionActivityPause'_constructor
        {_WorkflowRuleAction'ActionActivityPause'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowRuleAction'ActionActivityPause
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowRuleAction'ActionActivityPause
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
          (do loop Data.ProtoLens.defMessage) "ActionActivityPause"
  buildMessage
    = \ _x
        -> Data.ProtoLens.Encoding.Wire.buildFieldSet
             (Lens.Family2.view Data.ProtoLens.unknownFields _x)
instance Control.DeepSeq.NFData WorkflowRuleAction'ActionActivityPause where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowRuleAction'ActionActivityPause'_unknownFields x__) ()
{- | Fields :
     
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.id' @:: Lens' WorkflowRuleSpec Data.Text.Text@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.visibilityQuery' @:: Lens' WorkflowRuleSpec Data.Text.Text@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.actions' @:: Lens' WorkflowRuleSpec [WorkflowRuleAction]@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.vec'actions' @:: Lens' WorkflowRuleSpec (Data.Vector.Vector WorkflowRuleAction)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.expirationTime' @:: Lens' WorkflowRuleSpec Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'expirationTime' @:: Lens' WorkflowRuleSpec (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'trigger' @:: Lens' WorkflowRuleSpec (Prelude.Maybe WorkflowRuleSpec'Trigger)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.maybe'activityStart' @:: Lens' WorkflowRuleSpec (Prelude.Maybe WorkflowRuleSpec'ActivityStartingTrigger)@
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.activityStart' @:: Lens' WorkflowRuleSpec WorkflowRuleSpec'ActivityStartingTrigger@ -}
data WorkflowRuleSpec
  = WorkflowRuleSpec'_constructor {_WorkflowRuleSpec'id :: !Data.Text.Text,
                                   _WorkflowRuleSpec'visibilityQuery :: !Data.Text.Text,
                                   _WorkflowRuleSpec'actions :: !(Data.Vector.Vector WorkflowRuleAction),
                                   _WorkflowRuleSpec'expirationTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                   _WorkflowRuleSpec'trigger :: !(Prelude.Maybe WorkflowRuleSpec'Trigger),
                                   _WorkflowRuleSpec'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowRuleSpec where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data WorkflowRuleSpec'Trigger
  = WorkflowRuleSpec'ActivityStart !WorkflowRuleSpec'ActivityStartingTrigger
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "id" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'id
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'id = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "visibilityQuery" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'visibilityQuery
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'visibilityQuery = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "actions" [WorkflowRuleAction] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'actions
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'actions = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "vec'actions" (Data.Vector.Vector WorkflowRuleAction) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'actions
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'actions = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "expirationTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'expirationTime
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'expirationTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "maybe'expirationTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'expirationTime
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'expirationTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "maybe'trigger" (Prelude.Maybe WorkflowRuleSpec'Trigger) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'trigger
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'trigger = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "maybe'activityStart" (Prelude.Maybe WorkflowRuleSpec'ActivityStartingTrigger) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'trigger
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'trigger = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkflowRuleSpec'ActivityStart x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkflowRuleSpec'ActivityStart y__))
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec "activityStart" WorkflowRuleSpec'ActivityStartingTrigger where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'trigger
           (\ x__ y__ -> x__ {_WorkflowRuleSpec'trigger = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkflowRuleSpec'ActivityStart x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkflowRuleSpec'ActivityStart y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message WorkflowRuleSpec where
  messageName _
    = Data.Text.pack "temporal.api.rules.v1.WorkflowRuleSpec"
  packedMessageDescriptor _
    = "\n\
      \\DLEWorkflowRuleSpec\DC2\SO\n\
      \\STXid\CAN\SOH \SOH(\tR\STXid\DC2h\n\
      \\SOactivity_start\CAN\STX \SOH(\v2?.temporal.api.rules.v1.WorkflowRuleSpec.ActivityStartingTriggerH\NULR\ractivityStart\DC2)\n\
      \\DLEvisibility_query\CAN\ETX \SOH(\tR\SIvisibilityQuery\DC2C\n\
      \\aactions\CAN\EOT \ETX(\v2).temporal.api.rules.v1.WorkflowRuleActionR\aactions\DC2C\n\
      \\SIexpiration_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\SOexpirationTime\SUB7\n\
      \\ETBActivityStartingTrigger\DC2\FS\n\
      \\tpredicate\CAN\SOH \SOH(\tR\tpredicateB\t\n\
      \\atrigger"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        id__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"id")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleSpec
        visibilityQuery__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "visibility_query"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"visibilityQuery")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleSpec
        actions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "actions"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowRuleAction)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"actions")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleSpec
        expirationTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "expiration_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'expirationTime")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleSpec
        activityStart__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_start"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowRuleSpec'ActivityStartingTrigger)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'activityStart")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleSpec
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, id__field_descriptor),
           (Data.ProtoLens.Tag 3, visibilityQuery__field_descriptor),
           (Data.ProtoLens.Tag 4, actions__field_descriptor),
           (Data.ProtoLens.Tag 5, expirationTime__field_descriptor),
           (Data.ProtoLens.Tag 2, activityStart__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowRuleSpec'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowRuleSpec'_unknownFields = y__})
  defMessage
    = WorkflowRuleSpec'_constructor
        {_WorkflowRuleSpec'id = Data.ProtoLens.fieldDefault,
         _WorkflowRuleSpec'visibilityQuery = Data.ProtoLens.fieldDefault,
         _WorkflowRuleSpec'actions = Data.Vector.Generic.empty,
         _WorkflowRuleSpec'expirationTime = Prelude.Nothing,
         _WorkflowRuleSpec'trigger = Prelude.Nothing,
         _WorkflowRuleSpec'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowRuleSpec
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld WorkflowRuleAction
             -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowRuleSpec
        loop x mutable'actions
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'actions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'actions)
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
                              (Data.ProtoLens.Field.field @"vec'actions") frozen'actions x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"id") y x)
                                  mutable'actions
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "visibility_query"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"visibilityQuery") y x)
                                  mutable'actions
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "actions"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'actions y)
                                loop x v
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "expiration_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"expirationTime") y x)
                                  mutable'actions
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "activity_start"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityStart") y x)
                                  mutable'actions
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'actions
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'actions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'actions)
          "WorkflowRuleSpec"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"id") _x
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
                         (Data.ProtoLens.Field.field @"visibilityQuery") _x
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
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'actions") _x))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'expirationTime") _x
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
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'trigger") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just (WorkflowRuleSpec'ActivityStart v))
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData WorkflowRuleSpec where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowRuleSpec'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowRuleSpec'id x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowRuleSpec'visibilityQuery x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowRuleSpec'actions x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowRuleSpec'expirationTime x__)
                         (Control.DeepSeq.deepseq (_WorkflowRuleSpec'trigger x__) ())))))
instance Control.DeepSeq.NFData WorkflowRuleSpec'Trigger where
  rnf (WorkflowRuleSpec'ActivityStart x__) = Control.DeepSeq.rnf x__
_WorkflowRuleSpec'ActivityStart ::
  Data.ProtoLens.Prism.Prism' WorkflowRuleSpec'Trigger WorkflowRuleSpec'ActivityStartingTrigger
_WorkflowRuleSpec'ActivityStart
  = Data.ProtoLens.Prism.prism'
      WorkflowRuleSpec'ActivityStart
      (\ p__
         -> case p__ of
              (WorkflowRuleSpec'ActivityStart p__val) -> Prelude.Just p__val)
{- | Fields :
     
         * 'Proto.Temporal.Api.Rules.V1.Message_Fields.predicate' @:: Lens' WorkflowRuleSpec'ActivityStartingTrigger Data.Text.Text@ -}
data WorkflowRuleSpec'ActivityStartingTrigger
  = WorkflowRuleSpec'ActivityStartingTrigger'_constructor {_WorkflowRuleSpec'ActivityStartingTrigger'predicate :: !Data.Text.Text,
                                                           _WorkflowRuleSpec'ActivityStartingTrigger'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowRuleSpec'ActivityStartingTrigger where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowRuleSpec'ActivityStartingTrigger "predicate" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowRuleSpec'ActivityStartingTrigger'predicate
           (\ x__ y__
              -> x__
                   {_WorkflowRuleSpec'ActivityStartingTrigger'predicate = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowRuleSpec'ActivityStartingTrigger where
  messageName _
    = Data.Text.pack
        "temporal.api.rules.v1.WorkflowRuleSpec.ActivityStartingTrigger"
  packedMessageDescriptor _
    = "\n\
      \\ETBActivityStartingTrigger\DC2\FS\n\
      \\tpredicate\CAN\SOH \SOH(\tR\tpredicate"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        predicate__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "predicate"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"predicate")) ::
              Data.ProtoLens.FieldDescriptor WorkflowRuleSpec'ActivityStartingTrigger
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, predicate__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowRuleSpec'ActivityStartingTrigger'_unknownFields
        (\ x__ y__
           -> x__
                {_WorkflowRuleSpec'ActivityStartingTrigger'_unknownFields = y__})
  defMessage
    = WorkflowRuleSpec'ActivityStartingTrigger'_constructor
        {_WorkflowRuleSpec'ActivityStartingTrigger'predicate = Data.ProtoLens.fieldDefault,
         _WorkflowRuleSpec'ActivityStartingTrigger'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowRuleSpec'ActivityStartingTrigger
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowRuleSpec'ActivityStartingTrigger
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
                                       "predicate"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"predicate") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "ActivityStartingTrigger"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"predicate") _x
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
instance Control.DeepSeq.NFData WorkflowRuleSpec'ActivityStartingTrigger where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowRuleSpec'ActivityStartingTrigger'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowRuleSpec'ActivityStartingTrigger'predicate x__) ())
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \#temporal/api/rules/v1/message.proto\DC2\NAKtemporal.api.rules.v1\SUB\USgoogle/protobuf/timestamp.proto\"\158\SOH\n\
    \\DC2WorkflowRuleAction\DC2f\n\
    \\SOactivity_pause\CAN\SOH \SOH(\v2=.temporal.api.rules.v1.WorkflowRuleAction.ActionActivityPauseH\NULR\ractivityPause\SUB\NAK\n\
    \\DC3ActionActivityPauseB\t\n\
    \\avariant\"\133\ETX\n\
    \\DLEWorkflowRuleSpec\DC2\SO\n\
    \\STXid\CAN\SOH \SOH(\tR\STXid\DC2h\n\
    \\SOactivity_start\CAN\STX \SOH(\v2?.temporal.api.rules.v1.WorkflowRuleSpec.ActivityStartingTriggerH\NULR\ractivityStart\DC2)\n\
    \\DLEvisibility_query\CAN\ETX \SOH(\tR\SIvisibilityQuery\DC2C\n\
    \\aactions\CAN\EOT \ETX(\v2).temporal.api.rules.v1.WorkflowRuleActionR\aactions\DC2C\n\
    \\SIexpiration_time\CAN\ENQ \SOH(\v2\SUB.google.protobuf.TimestampR\SOexpirationTime\SUB7\n\
    \\ETBActivityStartingTrigger\DC2\FS\n\
    \\tpredicate\CAN\SOH \SOH(\tR\tpredicateB\t\n\
    \\atrigger\"\136\SOH\n\
    \\fWorkflowRule\DC2;\n\
    \\vcreate_time\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\n\
    \createTime\DC2;\n\
    \\EOTspec\CAN\STX \SOH(\v2'.temporal.api.rules.v1.WorkflowRuleSpecR\EOTspecB\132\SOH\n\
    \\CANio.temporal.api.rules.v1B\fMessageProtoP\SOHZ!go.temporal.io/api/rules/v1;rules\170\STX\ETBTemporalio.Api.Rules.V1\234\STX\SUBTemporalio::Api::Rules::V1J\228\GS\n\
    \\ACK\DC2\EOT\SYN\NULe\SOH\n\
    \\241\b\n\
    \\SOH\f\DC2\ETX\SYN\NUL\DC22\230\b The MIT License\n\
    \\n\
    \ Copyright (c) 2025 Temporal Technologies Inc.  All rights reserved.\n\
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
    \\STX\ETX\NUL\DC2\ETX\"\NUL)\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT$\NUL,\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX$\b\SUB\n\
    \\f\n\
    \\EOT\EOT\NUL\ETX\NUL\DC2\EOT%\STX&\ETX\n\
    \\f\n\
    \\ENQ\EOT\NUL\ETX\NUL\SOH\DC2\ETX%\n\
    \\GS\n\
    \\"\n\
    \\EOT\EOT\NUL\b\NUL\DC2\EOT)\STX+\ETX\SUB\DC4 Supported actions.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\b\NUL\SOH\DC2\ETX)\b\SI\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX*\EOT+\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX*\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX*\CAN&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX*)*\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT.\NUL\\\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX.\b\CAN\n\
    \\140\SOH\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX1\STX\DLE\SUB\DEL The id of the new workflow rule. Must be unique within the namespace.\n\
    \ Can be set by the user, and can have business meaning.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX1\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX1\t\v\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX1\SO\SI\n\
    \V\n\
    \\EOT\EOT\SOH\ETX\NUL\DC2\EOT4\STXD\ETX\SUBH Activity trigger will be triggered when an activity is about to start.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\ETX\NUL\SOH\DC2\ETX4\n\
    \!\n\
    \\149\ACK\n\
    \\ACK\EOT\SOH\ETX\NUL\STX\NUL\DC2\ETXC\EOT\EM\SUB\133\ACK Activity predicate is a SQL-like string filter parameter.\n\
    \ It is used to match against workflow data.\n\
    \ The following activity attributes are supported as part of the predicate:\n\
    \ - ActivityType: An Activity Type is the mapping of a name to an Activity Definition..\n\
    \ - ActivityId: The ID of the activity.\n\
    \ - ActivityAttempt: The number attempts of the activity.\n\
    \ - BackoffInterval: The current amount of time between scheduled attempts of the activity.\n\
    \ - ActivityStatus: The status of the activity. Can be one of \"Scheduled\", \"Started\", \"Paused\".\n\
    \ - TaskQueue: The name of the task queue the workflow specified that the activity should run on.\n\
    \ Activity predicate support the following operators:\n\
    \  * =, !=, >, >=, <, <=\n\
    \  * AND, OR, ()\n\
    \  * BETWEEN ... AND\n\
    \    STARTS_WITH\n\
    \\n\
    \\SO\n\
    \\a\EOT\SOH\ETX\NUL\STX\NUL\ENQ\DC2\ETXC\EOT\n\
    \\n\
    \\SO\n\
    \\a\EOT\SOH\ETX\NUL\STX\NUL\SOH\DC2\ETXC\v\DC4\n\
    \\SO\n\
    \\a\EOT\SOH\ETX\NUL\STX\NUL\ETX\DC2\ETXC\ETB\CAN\n\
    \~\n\
    \\EOT\EOT\SOH\b\NUL\DC2\EOTH\STXJ\ETX\SUBp Specifies how the rule should be triggered and evaluated.\n\
    \ Currently, only \"activity start\" type is supported.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\b\NUL\SOH\DC2\ETXH\b\SI\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETXI\EOT/\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETXI\EOT\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETXI\FS*\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETXI-.\n\
    \\238\STX\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETXT\STX\RS\SUB\224\STX Restricted Visibility query.\n\
    \ This query is used to filter workflows in this namespace to which this rule should apply.\n\
    \ It is applied to any running workflow each time a triggering event occurs, before the trigger predicate is evaluated.\n\
    \ The following workflow attributes are supported:\n\
    \ - WorkflowType\n\
    \ - WorkflowId\n\
    \ - StartTime\n\
    \ - ExecutionStatus\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ENQ\DC2\ETXT\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETXT\t\EM\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETXT\FS\GS\n\
    \b\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETXW\STX*\SUBU WorkflowRuleAction to be taken when the rule is triggered and predicate is matched.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\EOT\DC2\ETXW\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ACK\DC2\ETXW\v\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETXW\RS%\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETXW()\n\
    \\133\SOH\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX[\STX0\SUBx Expiration time of the rule. After this time, the rule will be deleted.\n\
    \ Can be empty if the rule should never expire.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ACK\DC2\ETX[\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX[\FS+\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX[./\n\
    \b\n\
    \\STX\EOT\STX\DC2\EOT_\NULe\SOH\SUBV WorkflowRule describes a rule that can be applied to any workflow in this namespace.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX_\b\DC4\n\
    \\"\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETXa\STX,\SUB\NAK Rule creation time.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETXa\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETXa\FS'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETXa*+\n\
    \!\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETXd\STX\FS\SUB\DC4 Rule specification\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETXd\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETXd\DC3\ETB\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETXd\SUB\ESCb\ACKproto3"