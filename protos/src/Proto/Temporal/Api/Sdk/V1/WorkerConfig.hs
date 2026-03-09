{- This file was auto-generated from temporal/api/sdk/v1/worker_config.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.WorkerConfig (
        WorkerConfig(), WorkerConfig'PollerBehavior(..),
        _WorkerConfig'SimplePollerBehavior',
        _WorkerConfig'AutoscalingPollerBehavior',
        WorkerConfig'AutoscalingPollerBehavior(),
        WorkerConfig'SimplePollerBehavior()
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
     
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.workflowCacheSize' @:: Lens' WorkerConfig Data.Int.Int32@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.maybe'pollerBehavior' @:: Lens' WorkerConfig (Prelude.Maybe WorkerConfig'PollerBehavior)@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.maybe'simplePollerBehavior' @:: Lens' WorkerConfig (Prelude.Maybe WorkerConfig'SimplePollerBehavior)@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.simplePollerBehavior' @:: Lens' WorkerConfig WorkerConfig'SimplePollerBehavior@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.maybe'autoscalingPollerBehavior' @:: Lens' WorkerConfig (Prelude.Maybe WorkerConfig'AutoscalingPollerBehavior)@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.autoscalingPollerBehavior' @:: Lens' WorkerConfig WorkerConfig'AutoscalingPollerBehavior@ -}
data WorkerConfig
  = WorkerConfig'_constructor {_WorkerConfig'workflowCacheSize :: !Data.Int.Int32,
                               _WorkerConfig'pollerBehavior :: !(Prelude.Maybe WorkerConfig'PollerBehavior),
                               _WorkerConfig'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerConfig where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data WorkerConfig'PollerBehavior
  = WorkerConfig'SimplePollerBehavior' !WorkerConfig'SimplePollerBehavior |
    WorkerConfig'AutoscalingPollerBehavior' !WorkerConfig'AutoscalingPollerBehavior
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField WorkerConfig "workflowCacheSize" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'workflowCacheSize
           (\ x__ y__ -> x__ {_WorkerConfig'workflowCacheSize = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerConfig "maybe'pollerBehavior" (Prelude.Maybe WorkerConfig'PollerBehavior) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'pollerBehavior
           (\ x__ y__ -> x__ {_WorkerConfig'pollerBehavior = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerConfig "maybe'simplePollerBehavior" (Prelude.Maybe WorkerConfig'SimplePollerBehavior) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'pollerBehavior
           (\ x__ y__ -> x__ {_WorkerConfig'pollerBehavior = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkerConfig'SimplePollerBehavior' x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap WorkerConfig'SimplePollerBehavior' y__))
instance Data.ProtoLens.Field.HasField WorkerConfig "simplePollerBehavior" WorkerConfig'SimplePollerBehavior where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'pollerBehavior
           (\ x__ y__ -> x__ {_WorkerConfig'pollerBehavior = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkerConfig'SimplePollerBehavior' x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap WorkerConfig'SimplePollerBehavior' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Field.HasField WorkerConfig "maybe'autoscalingPollerBehavior" (Prelude.Maybe WorkerConfig'AutoscalingPollerBehavior) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'pollerBehavior
           (\ x__ y__ -> x__ {_WorkerConfig'pollerBehavior = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (WorkerConfig'AutoscalingPollerBehavior' x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__
              -> Prelude.fmap WorkerConfig'AutoscalingPollerBehavior' y__))
instance Data.ProtoLens.Field.HasField WorkerConfig "autoscalingPollerBehavior" WorkerConfig'AutoscalingPollerBehavior where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'pollerBehavior
           (\ x__ y__ -> x__ {_WorkerConfig'pollerBehavior = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (WorkerConfig'AutoscalingPollerBehavior' x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__
                 -> Prelude.fmap WorkerConfig'AutoscalingPollerBehavior' y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage))
instance Data.ProtoLens.Message WorkerConfig where
  messageName _ = Data.Text.pack "temporal.api.sdk.v1.WorkerConfig"
  packedMessageDescriptor _
    = "\n\
      \\fWorkerConfig\DC2.\n\
      \\DC3workflow_cache_size\CAN\SOH \SOH(\ENQR\DC1workflowCacheSize\DC2n\n\
      \\SYNsimple_poller_behavior\CAN\STX \SOH(\v26.temporal.api.sdk.v1.WorkerConfig.SimplePollerBehaviorH\NULR\DC4simplePollerBehavior\DC2}\n\
      \\ESCautoscaling_poller_behavior\CAN\ETX \SOH(\v2;.temporal.api.sdk.v1.WorkerConfig.AutoscalingPollerBehaviorH\NULR\EMautoscalingPollerBehavior\SUB7\n\
      \\DC4SimplePollerBehavior\DC2\US\n\
      \\vmax_pollers\CAN\SOH \SOH(\ENQR\n\
      \maxPollers\SUB\134\SOH\n\
      \\EMAutoscalingPollerBehavior\DC2\US\n\
      \\vmin_pollers\CAN\SOH \SOH(\ENQR\n\
      \minPollers\DC2\US\n\
      \\vmax_pollers\CAN\STX \SOH(\ENQR\n\
      \maxPollers\DC2'\n\
      \\SIinitial_pollers\CAN\ETX \SOH(\ENQR\SOinitialPollersB\DC1\n\
      \\SIpoller_behavior"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workflowCacheSize__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_cache_size"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workflowCacheSize")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig
        simplePollerBehavior__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "simple_poller_behavior"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerConfig'SimplePollerBehavior)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'simplePollerBehavior")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig
        autoscalingPollerBehavior__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "autoscaling_poller_behavior"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerConfig'AutoscalingPollerBehavior)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'autoscalingPollerBehavior")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workflowCacheSize__field_descriptor),
           (Data.ProtoLens.Tag 2, simplePollerBehavior__field_descriptor),
           (Data.ProtoLens.Tag 3, 
            autoscalingPollerBehavior__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerConfig'_unknownFields
        (\ x__ y__ -> x__ {_WorkerConfig'_unknownFields = y__})
  defMessage
    = WorkerConfig'_constructor
        {_WorkerConfig'workflowCacheSize = Data.ProtoLens.fieldDefault,
         _WorkerConfig'pollerBehavior = Prelude.Nothing,
         _WorkerConfig'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerConfig -> Data.ProtoLens.Encoding.Bytes.Parser WorkerConfig
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
                                       "workflow_cache_size"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowCacheSize") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "simple_poller_behavior"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"simplePollerBehavior") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "autoscaling_poller_behavior"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"autoscalingPollerBehavior") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerConfig"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"workflowCacheSize") _x
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
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'pollerBehavior") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (WorkerConfig'SimplePollerBehavior' v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v)
                   (Prelude.Just (WorkerConfig'AutoscalingPollerBehavior' v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData WorkerConfig where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerConfig'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerConfig'workflowCacheSize x__)
                (Control.DeepSeq.deepseq (_WorkerConfig'pollerBehavior x__) ()))
instance Control.DeepSeq.NFData WorkerConfig'PollerBehavior where
  rnf (WorkerConfig'SimplePollerBehavior' x__)
    = Control.DeepSeq.rnf x__
  rnf (WorkerConfig'AutoscalingPollerBehavior' x__)
    = Control.DeepSeq.rnf x__
_WorkerConfig'SimplePollerBehavior' ::
  Data.ProtoLens.Prism.Prism' WorkerConfig'PollerBehavior WorkerConfig'SimplePollerBehavior
_WorkerConfig'SimplePollerBehavior'
  = Data.ProtoLens.Prism.prism'
      WorkerConfig'SimplePollerBehavior'
      (\ p__
         -> case p__ of
              (WorkerConfig'SimplePollerBehavior' p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_WorkerConfig'AutoscalingPollerBehavior' ::
  Data.ProtoLens.Prism.Prism' WorkerConfig'PollerBehavior WorkerConfig'AutoscalingPollerBehavior
_WorkerConfig'AutoscalingPollerBehavior'
  = Data.ProtoLens.Prism.prism'
      WorkerConfig'AutoscalingPollerBehavior'
      (\ p__
         -> case p__ of
              (WorkerConfig'AutoscalingPollerBehavior' p__val)
                -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.minPollers' @:: Lens' WorkerConfig'AutoscalingPollerBehavior Data.Int.Int32@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.maxPollers' @:: Lens' WorkerConfig'AutoscalingPollerBehavior Data.Int.Int32@
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.initialPollers' @:: Lens' WorkerConfig'AutoscalingPollerBehavior Data.Int.Int32@ -}
data WorkerConfig'AutoscalingPollerBehavior
  = WorkerConfig'AutoscalingPollerBehavior'_constructor {_WorkerConfig'AutoscalingPollerBehavior'minPollers :: !Data.Int.Int32,
                                                         _WorkerConfig'AutoscalingPollerBehavior'maxPollers :: !Data.Int.Int32,
                                                         _WorkerConfig'AutoscalingPollerBehavior'initialPollers :: !Data.Int.Int32,
                                                         _WorkerConfig'AutoscalingPollerBehavior'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerConfig'AutoscalingPollerBehavior where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerConfig'AutoscalingPollerBehavior "minPollers" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'AutoscalingPollerBehavior'minPollers
           (\ x__ y__
              -> x__ {_WorkerConfig'AutoscalingPollerBehavior'minPollers = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerConfig'AutoscalingPollerBehavior "maxPollers" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'AutoscalingPollerBehavior'maxPollers
           (\ x__ y__
              -> x__ {_WorkerConfig'AutoscalingPollerBehavior'maxPollers = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerConfig'AutoscalingPollerBehavior "initialPollers" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'AutoscalingPollerBehavior'initialPollers
           (\ x__ y__
              -> x__
                   {_WorkerConfig'AutoscalingPollerBehavior'initialPollers = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerConfig'AutoscalingPollerBehavior where
  messageName _
    = Data.Text.pack
        "temporal.api.sdk.v1.WorkerConfig.AutoscalingPollerBehavior"
  packedMessageDescriptor _
    = "\n\
      \\EMAutoscalingPollerBehavior\DC2\US\n\
      \\vmin_pollers\CAN\SOH \SOH(\ENQR\n\
      \minPollers\DC2\US\n\
      \\vmax_pollers\CAN\STX \SOH(\ENQR\n\
      \maxPollers\DC2'\n\
      \\SIinitial_pollers\CAN\ETX \SOH(\ENQR\SOinitialPollers"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        minPollers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "min_pollers"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"minPollers")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig'AutoscalingPollerBehavior
        maxPollers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "max_pollers"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"maxPollers")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig'AutoscalingPollerBehavior
        initialPollers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "initial_pollers"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"initialPollers")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig'AutoscalingPollerBehavior
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, minPollers__field_descriptor),
           (Data.ProtoLens.Tag 2, maxPollers__field_descriptor),
           (Data.ProtoLens.Tag 3, initialPollers__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerConfig'AutoscalingPollerBehavior'_unknownFields
        (\ x__ y__
           -> x__
                {_WorkerConfig'AutoscalingPollerBehavior'_unknownFields = y__})
  defMessage
    = WorkerConfig'AutoscalingPollerBehavior'_constructor
        {_WorkerConfig'AutoscalingPollerBehavior'minPollers = Data.ProtoLens.fieldDefault,
         _WorkerConfig'AutoscalingPollerBehavior'maxPollers = Data.ProtoLens.fieldDefault,
         _WorkerConfig'AutoscalingPollerBehavior'initialPollers = Data.ProtoLens.fieldDefault,
         _WorkerConfig'AutoscalingPollerBehavior'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerConfig'AutoscalingPollerBehavior
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerConfig'AutoscalingPollerBehavior
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
                                       "min_pollers"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"minPollers") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "max_pollers"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"maxPollers") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "initial_pollers"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"initialPollers") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "AutoscalingPollerBehavior"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"minPollers") _x
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
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"maxPollers") _x
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
                      _v
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"initialPollers") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData WorkerConfig'AutoscalingPollerBehavior where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerConfig'AutoscalingPollerBehavior'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerConfig'AutoscalingPollerBehavior'minPollers x__)
                (Control.DeepSeq.deepseq
                   (_WorkerConfig'AutoscalingPollerBehavior'maxPollers x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerConfig'AutoscalingPollerBehavior'initialPollers x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.WorkerConfig_Fields.maxPollers' @:: Lens' WorkerConfig'SimplePollerBehavior Data.Int.Int32@ -}
data WorkerConfig'SimplePollerBehavior
  = WorkerConfig'SimplePollerBehavior'_constructor {_WorkerConfig'SimplePollerBehavior'maxPollers :: !Data.Int.Int32,
                                                    _WorkerConfig'SimplePollerBehavior'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerConfig'SimplePollerBehavior where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerConfig'SimplePollerBehavior "maxPollers" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerConfig'SimplePollerBehavior'maxPollers
           (\ x__ y__
              -> x__ {_WorkerConfig'SimplePollerBehavior'maxPollers = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerConfig'SimplePollerBehavior where
  messageName _
    = Data.Text.pack
        "temporal.api.sdk.v1.WorkerConfig.SimplePollerBehavior"
  packedMessageDescriptor _
    = "\n\
      \\DC4SimplePollerBehavior\DC2\US\n\
      \\vmax_pollers\CAN\SOH \SOH(\ENQR\n\
      \maxPollers"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        maxPollers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "max_pollers"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"maxPollers")) ::
              Data.ProtoLens.FieldDescriptor WorkerConfig'SimplePollerBehavior
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, maxPollers__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerConfig'SimplePollerBehavior'_unknownFields
        (\ x__ y__
           -> x__ {_WorkerConfig'SimplePollerBehavior'_unknownFields = y__})
  defMessage
    = WorkerConfig'SimplePollerBehavior'_constructor
        {_WorkerConfig'SimplePollerBehavior'maxPollers = Data.ProtoLens.fieldDefault,
         _WorkerConfig'SimplePollerBehavior'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerConfig'SimplePollerBehavior
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerConfig'SimplePollerBehavior
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
                                       "max_pollers"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"maxPollers") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SimplePollerBehavior"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"maxPollers") _x
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
instance Control.DeepSeq.NFData WorkerConfig'SimplePollerBehavior where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerConfig'SimplePollerBehavior'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerConfig'SimplePollerBehavior'maxPollers x__) ())
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \'temporal/api/sdk/v1/worker_config.proto\DC2\DC3temporal.api.sdk.v1\"\130\EOT\n\
    \\fWorkerConfig\DC2.\n\
    \\DC3workflow_cache_size\CAN\SOH \SOH(\ENQR\DC1workflowCacheSize\DC2n\n\
    \\SYNsimple_poller_behavior\CAN\STX \SOH(\v26.temporal.api.sdk.v1.WorkerConfig.SimplePollerBehaviorH\NULR\DC4simplePollerBehavior\DC2}\n\
    \\ESCautoscaling_poller_behavior\CAN\ETX \SOH(\v2;.temporal.api.sdk.v1.WorkerConfig.AutoscalingPollerBehaviorH\NULR\EMautoscalingPollerBehavior\SUB7\n\
    \\DC4SimplePollerBehavior\DC2\US\n\
    \\vmax_pollers\CAN\SOH \SOH(\ENQR\n\
    \maxPollers\SUB\134\SOH\n\
    \\EMAutoscalingPollerBehavior\DC2\US\n\
    \\vmin_pollers\CAN\SOH \SOH(\ENQR\n\
    \minPollers\DC2\US\n\
    \\vmax_pollers\CAN\STX \SOH(\ENQR\n\
    \maxPollers\DC2'\n\
    \\SIinitial_pollers\CAN\ETX \SOH(\ENQR\SOinitialPollersB\DC1\n\
    \\SIpoller_behaviorB\DEL\n\
    \\SYNio.temporal.api.sdk.v1B\DC1WorkerConfigProtoP\SOHZ\GSgo.temporal.io/api/sdk/v1;sdk\170\STX\NAKTemporalio.Api.Sdk.V1\234\STX\CANTemporalio::Api::Sdk::V1J\215\a\n\
    \\ACK\DC2\EOT\NUL\NUL#\SOH\n\
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
    \\SOH\b\DC2\ETX\a\NUL2\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\a\NUL2\n\
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
    \\STX\EOT\NUL\DC2\EOT\v\NUL#\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\v\b\DC4\n\
    \\f\n\
    \\EOT\EOT\NUL\ETX\NUL\DC2\EOT\f\EOT\SO\ENQ\n\
    \\f\n\
    \\ENQ\EOT\NUL\ETX\NUL\SOH\DC2\ETX\f\f \n\
    \\r\n\
    \\ACK\EOT\NUL\ETX\NUL\STX\NUL\DC2\ETX\r\b\RS\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\NUL\STX\NUL\ENQ\DC2\ETX\r\b\r\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\NUL\STX\NUL\SOH\DC2\ETX\r\SO\EM\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\NUL\STX\NUL\ETX\DC2\ETX\r\FS\GS\n\
    \\f\n\
    \\EOT\EOT\NUL\ETX\SOH\DC2\EOT\DLE\EOT\ESC\ENQ\n\
    \\f\n\
    \\ENQ\EOT\NUL\ETX\SOH\SOH\DC2\ETX\DLE\f%\n\
    \x\n\
    \\ACK\EOT\NUL\ETX\SOH\STX\NUL\DC2\ETX\DC3\b\RS\SUBi At least this many poll calls will always be attempted (assuming slots are available).\n\
    \ Cannot be zero.\n\
    \\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\NUL\ENQ\DC2\ETX\DC3\b\r\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\NUL\SOH\DC2\ETX\DC3\SO\EM\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\NUL\ETX\DC2\ETX\DC3\FS\GS\n\
    \^\n\
    \\ACK\EOT\NUL\ETX\SOH\STX\SOH\DC2\ETX\SYN\b\RS\SUBO At most this many poll calls will ever be open at once. Must be >= `minimum`.\n\
    \\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\SOH\ENQ\DC2\ETX\SYN\b\r\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\SOH\SOH\DC2\ETX\SYN\SO\EM\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\SOH\ETX\DC2\ETX\SYN\FS\GS\n\
    \\128\SOH\n\
    \\ACK\EOT\NUL\ETX\SOH\STX\STX\DC2\ETX\SUB\b\"\SUBq This many polls will be attempted initially before scaling kicks in. Must be between\n\
    \  `minimum` and `maximum`.\n\
    \\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\STX\ENQ\DC2\ETX\SUB\b\r\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\STX\SOH\DC2\ETX\SUB\SO\GS\n\
    \\SO\n\
    \\a\EOT\NUL\ETX\SOH\STX\STX\ETX\DC2\ETX\SUB !\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\GS\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\GS\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\GS\n\
    \\GS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\GS !\n\
    \\f\n\
    \\EOT\EOT\NUL\b\NUL\DC2\EOT\US\EOT\"\ENQ\n\
    \\f\n\
    \\ENQ\EOT\NUL\b\NUL\SOH\DC2\ETX\US\n\
    \\EM\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX \b8\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX \b\FS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX \GS3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX 67\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX!\bB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX!\b!\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX!\"=\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX!@Ab\ACKproto3"