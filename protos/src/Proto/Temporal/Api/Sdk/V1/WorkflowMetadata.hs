{- This file was auto-generated from temporal/api/sdk/v1/workflow_metadata.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Sdk.V1.WorkflowMetadata (
        WorkflowDefinition(), WorkflowInteractionDefinition(),
        WorkflowMetadata()
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
     
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.type'' @:: Lens' WorkflowDefinition Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.queryDefinitions' @:: Lens' WorkflowDefinition [WorkflowInteractionDefinition]@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.vec'queryDefinitions' @:: Lens' WorkflowDefinition (Data.Vector.Vector WorkflowInteractionDefinition)@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.signalDefinitions' @:: Lens' WorkflowDefinition [WorkflowInteractionDefinition]@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.vec'signalDefinitions' @:: Lens' WorkflowDefinition (Data.Vector.Vector WorkflowInteractionDefinition)@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.updateDefinitions' @:: Lens' WorkflowDefinition [WorkflowInteractionDefinition]@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.vec'updateDefinitions' @:: Lens' WorkflowDefinition (Data.Vector.Vector WorkflowInteractionDefinition)@ -}
data WorkflowDefinition
  = WorkflowDefinition'_constructor {_WorkflowDefinition'type' :: !Data.Text.Text,
                                     _WorkflowDefinition'queryDefinitions :: !(Data.Vector.Vector WorkflowInteractionDefinition),
                                     _WorkflowDefinition'signalDefinitions :: !(Data.Vector.Vector WorkflowInteractionDefinition),
                                     _WorkflowDefinition'updateDefinitions :: !(Data.Vector.Vector WorkflowInteractionDefinition),
                                     _WorkflowDefinition'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowDefinition where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowDefinition "type'" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'type'
           (\ x__ y__ -> x__ {_WorkflowDefinition'type' = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowDefinition "queryDefinitions" [WorkflowInteractionDefinition] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'queryDefinitions
           (\ x__ y__ -> x__ {_WorkflowDefinition'queryDefinitions = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowDefinition "vec'queryDefinitions" (Data.Vector.Vector WorkflowInteractionDefinition) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'queryDefinitions
           (\ x__ y__ -> x__ {_WorkflowDefinition'queryDefinitions = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowDefinition "signalDefinitions" [WorkflowInteractionDefinition] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'signalDefinitions
           (\ x__ y__ -> x__ {_WorkflowDefinition'signalDefinitions = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowDefinition "vec'signalDefinitions" (Data.Vector.Vector WorkflowInteractionDefinition) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'signalDefinitions
           (\ x__ y__ -> x__ {_WorkflowDefinition'signalDefinitions = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowDefinition "updateDefinitions" [WorkflowInteractionDefinition] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'updateDefinitions
           (\ x__ y__ -> x__ {_WorkflowDefinition'updateDefinitions = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField WorkflowDefinition "vec'updateDefinitions" (Data.Vector.Vector WorkflowInteractionDefinition) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowDefinition'updateDefinitions
           (\ x__ y__ -> x__ {_WorkflowDefinition'updateDefinitions = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowDefinition where
  messageName _
    = Data.Text.pack "temporal.api.sdk.v1.WorkflowDefinition"
  packedMessageDescriptor _
    = "\n\
      \\DC2WorkflowDefinition\DC2\DC2\n\
      \\EOTtype\CAN\SOH \SOH(\tR\EOTtype\DC2_\n\
      \\DC1query_definitions\CAN\STX \ETX(\v22.temporal.api.sdk.v1.WorkflowInteractionDefinitionR\DLEqueryDefinitions\DC2a\n\
      \\DC2signal_definitions\CAN\ETX \ETX(\v22.temporal.api.sdk.v1.WorkflowInteractionDefinitionR\DC1signalDefinitions\DC2a\n\
      \\DC2update_definitions\CAN\EOT \ETX(\v22.temporal.api.sdk.v1.WorkflowInteractionDefinitionR\DC1updateDefinitions"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        type'__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "type"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"type'")) ::
              Data.ProtoLens.FieldDescriptor WorkflowDefinition
        queryDefinitions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "query_definitions"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowInteractionDefinition)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"queryDefinitions")) ::
              Data.ProtoLens.FieldDescriptor WorkflowDefinition
        signalDefinitions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "signal_definitions"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowInteractionDefinition)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"signalDefinitions")) ::
              Data.ProtoLens.FieldDescriptor WorkflowDefinition
        updateDefinitions__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "update_definitions"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowInteractionDefinition)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"updateDefinitions")) ::
              Data.ProtoLens.FieldDescriptor WorkflowDefinition
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, type'__field_descriptor),
           (Data.ProtoLens.Tag 2, queryDefinitions__field_descriptor),
           (Data.ProtoLens.Tag 3, signalDefinitions__field_descriptor),
           (Data.ProtoLens.Tag 4, updateDefinitions__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowDefinition'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowDefinition'_unknownFields = y__})
  defMessage
    = WorkflowDefinition'_constructor
        {_WorkflowDefinition'type' = Data.ProtoLens.fieldDefault,
         _WorkflowDefinition'queryDefinitions = Data.Vector.Generic.empty,
         _WorkflowDefinition'signalDefinitions = Data.Vector.Generic.empty,
         _WorkflowDefinition'updateDefinitions = Data.Vector.Generic.empty,
         _WorkflowDefinition'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowDefinition
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld WorkflowInteractionDefinition
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld WorkflowInteractionDefinition
                -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld WorkflowInteractionDefinition
                   -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowDefinition
        loop
          x
          mutable'queryDefinitions
          mutable'signalDefinitions
          mutable'updateDefinitions
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'queryDefinitions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                   (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                      mutable'queryDefinitions)
                      frozen'signalDefinitions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                    (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                       mutable'signalDefinitions)
                      frozen'updateDefinitions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                                    (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                       mutable'updateDefinitions)
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
                              (Data.ProtoLens.Field.field @"vec'queryDefinitions")
                              frozen'queryDefinitions
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'signalDefinitions")
                                 frozen'signalDefinitions
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"vec'updateDefinitions")
                                    frozen'updateDefinitions x))))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "type"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"type'") y x)
                                  mutable'queryDefinitions mutable'signalDefinitions
                                  mutable'updateDefinitions
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "query_definitions"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'queryDefinitions y)
                                loop x v mutable'signalDefinitions mutable'updateDefinitions
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "signal_definitions"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'signalDefinitions y)
                                loop x mutable'queryDefinitions v mutable'updateDefinitions
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "update_definitions"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append
                                          mutable'updateDefinitions y)
                                loop x mutable'queryDefinitions mutable'signalDefinitions v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'queryDefinitions mutable'signalDefinitions
                                  mutable'updateDefinitions
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'queryDefinitions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                            Data.ProtoLens.Encoding.Growing.new
              mutable'signalDefinitions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                             Data.ProtoLens.Encoding.Growing.new
              mutable'updateDefinitions <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                             Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'queryDefinitions
                mutable'signalDefinitions mutable'updateDefinitions)
          "WorkflowDefinition"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"type'") _x
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
                   (Lens.Family2.view
                      (Data.ProtoLens.Field.field @"vec'queryDefinitions") _x))
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
                         (Data.ProtoLens.Field.field @"vec'signalDefinitions") _x))
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
                         (Lens.Family2.view
                            (Data.ProtoLens.Field.field @"vec'updateDefinitions") _x))
                      (Data.ProtoLens.Encoding.Wire.buildFieldSet
                         (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))
instance Control.DeepSeq.NFData WorkflowDefinition where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowDefinition'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowDefinition'type' x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowDefinition'queryDefinitions x__)
                   (Control.DeepSeq.deepseq
                      (_WorkflowDefinition'signalDefinitions x__)
                      (Control.DeepSeq.deepseq
                         (_WorkflowDefinition'updateDefinitions x__) ()))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.name' @:: Lens' WorkflowInteractionDefinition Data.Text.Text@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.description' @:: Lens' WorkflowInteractionDefinition Data.Text.Text@ -}
data WorkflowInteractionDefinition
  = WorkflowInteractionDefinition'_constructor {_WorkflowInteractionDefinition'name :: !Data.Text.Text,
                                                _WorkflowInteractionDefinition'description :: !Data.Text.Text,
                                                _WorkflowInteractionDefinition'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowInteractionDefinition where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowInteractionDefinition "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowInteractionDefinition'name
           (\ x__ y__ -> x__ {_WorkflowInteractionDefinition'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowInteractionDefinition "description" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowInteractionDefinition'description
           (\ x__ y__
              -> x__ {_WorkflowInteractionDefinition'description = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowInteractionDefinition where
  messageName _
    = Data.Text.pack
        "temporal.api.sdk.v1.WorkflowInteractionDefinition"
  packedMessageDescriptor _
    = "\n\
      \\GSWorkflowInteractionDefinition\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2 \n\
      \\vdescription\CAN\STX \SOH(\tR\vdescription"
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
              Data.ProtoLens.FieldDescriptor WorkflowInteractionDefinition
        description__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "description"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"description")) ::
              Data.ProtoLens.FieldDescriptor WorkflowInteractionDefinition
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, description__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowInteractionDefinition'_unknownFields
        (\ x__ y__
           -> x__ {_WorkflowInteractionDefinition'_unknownFields = y__})
  defMessage
    = WorkflowInteractionDefinition'_constructor
        {_WorkflowInteractionDefinition'name = Data.ProtoLens.fieldDefault,
         _WorkflowInteractionDefinition'description = Data.ProtoLens.fieldDefault,
         _WorkflowInteractionDefinition'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowInteractionDefinition
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowInteractionDefinition
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
                                       "description"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"description") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowInteractionDefinition"
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
                   _v
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"description") _x
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
instance Control.DeepSeq.NFData WorkflowInteractionDefinition where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowInteractionDefinition'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowInteractionDefinition'name x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowInteractionDefinition'description x__) ()))
{- | Fields :
     
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.definition' @:: Lens' WorkflowMetadata WorkflowDefinition@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.maybe'definition' @:: Lens' WorkflowMetadata (Prelude.Maybe WorkflowDefinition)@
         * 'Proto.Temporal.Api.Sdk.V1.WorkflowMetadata_Fields.currentDetails' @:: Lens' WorkflowMetadata Data.Text.Text@ -}
data WorkflowMetadata
  = WorkflowMetadata'_constructor {_WorkflowMetadata'definition :: !(Prelude.Maybe WorkflowDefinition),
                                   _WorkflowMetadata'currentDetails :: !Data.Text.Text,
                                   _WorkflowMetadata'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkflowMetadata where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkflowMetadata "definition" WorkflowDefinition where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowMetadata'definition
           (\ x__ y__ -> x__ {_WorkflowMetadata'definition = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkflowMetadata "maybe'definition" (Prelude.Maybe WorkflowDefinition) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowMetadata'definition
           (\ x__ y__ -> x__ {_WorkflowMetadata'definition = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkflowMetadata "currentDetails" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkflowMetadata'currentDetails
           (\ x__ y__ -> x__ {_WorkflowMetadata'currentDetails = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkflowMetadata where
  messageName _
    = Data.Text.pack "temporal.api.sdk.v1.WorkflowMetadata"
  packedMessageDescriptor _
    = "\n\
      \\DLEWorkflowMetadata\DC2G\n\
      \\n\
      \definition\CAN\SOH \SOH(\v2'.temporal.api.sdk.v1.WorkflowDefinitionR\n\
      \definition\DC2'\n\
      \\SIcurrent_details\CAN\STX \SOH(\tR\SOcurrentDetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        definition__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "definition"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkflowDefinition)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'definition")) ::
              Data.ProtoLens.FieldDescriptor WorkflowMetadata
        currentDetails__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_details"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentDetails")) ::
              Data.ProtoLens.FieldDescriptor WorkflowMetadata
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, definition__field_descriptor),
           (Data.ProtoLens.Tag 2, currentDetails__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkflowMetadata'_unknownFields
        (\ x__ y__ -> x__ {_WorkflowMetadata'_unknownFields = y__})
  defMessage
    = WorkflowMetadata'_constructor
        {_WorkflowMetadata'definition = Prelude.Nothing,
         _WorkflowMetadata'currentDetails = Data.ProtoLens.fieldDefault,
         _WorkflowMetadata'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkflowMetadata
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkflowMetadata
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
                                       "definition"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"definition") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "current_details"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentDetails") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkflowMetadata"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'definition") _x
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
                         (Data.ProtoLens.Field.field @"currentDetails") _x
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
instance Control.DeepSeq.NFData WorkflowMetadata where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkflowMetadata'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkflowMetadata'definition x__)
                (Control.DeepSeq.deepseq
                   (_WorkflowMetadata'currentDetails x__) ()))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \+temporal/api/sdk/v1/workflow_metadata.proto\DC2\DC3temporal.api.sdk.v1\"\132\SOH\n\
    \\DLEWorkflowMetadata\DC2G\n\
    \\n\
    \definition\CAN\SOH \SOH(\v2'.temporal.api.sdk.v1.WorkflowDefinitionR\n\
    \definition\DC2'\n\
    \\SIcurrent_details\CAN\STX \SOH(\tR\SOcurrentDetails\"\207\STX\n\
    \\DC2WorkflowDefinition\DC2\DC2\n\
    \\EOTtype\CAN\SOH \SOH(\tR\EOTtype\DC2_\n\
    \\DC1query_definitions\CAN\STX \ETX(\v22.temporal.api.sdk.v1.WorkflowInteractionDefinitionR\DLEqueryDefinitions\DC2a\n\
    \\DC2signal_definitions\CAN\ETX \ETX(\v22.temporal.api.sdk.v1.WorkflowInteractionDefinitionR\DC1signalDefinitions\DC2a\n\
    \\DC2update_definitions\CAN\EOT \ETX(\v22.temporal.api.sdk.v1.WorkflowInteractionDefinitionR\DC1updateDefinitions\"U\n\
    \\GSWorkflowInteractionDefinition\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2 \n\
    \\vdescription\CAN\STX \SOH(\tR\vdescriptionB\131\SOH\n\
    \\SYNio.temporal.api.sdk.v1B\NAKWorkflowMetadataProtoP\SOHZ\GSgo.temporal.io/api/sdk/v1;sdk\170\STX\NAKTemporalio.Api.Sdk.V1\234\STX\CANTemporalio::Api::Sdk::V1J\228\SO\n\
    \\ACK\DC2\EOT\NUL\NUL0\SOH\n\
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
    \\SOH\b\DC2\ETX\a\NUL6\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\a\NUL6\n\
    \\b\n\
    \\SOH\b\DC2\ETX\b\NUL1\n\
    \\t\n\
    \\STX\b-\DC2\ETX\b\NUL1\n\
    \\b\n\
    \\SOH\b\DC2\ETX\t\NUL2\n\
    \\t\n\
    \\STX\b%\DC2\ETX\t\NUL2\n\
    \c\n\
    \\STX\EOT\NUL\DC2\EOT\f\NUL\DC2\SOH\SUBW The name of the query to retrieve this information is `__temporal_workflow_metadata`.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\f\b\CAN\n\
    \A\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\SO\STX$\SUB4 Metadata provided at declaration or creation time.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ACK\DC2\ETX\SO\STX\DC4\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\SO\NAK\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\SO\"#\n\
    \\173\SOH\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\DC1\STX\GS\SUB\159\SOH Current long-form details of the workflow's state. This is used by user interfaces to show\n\
    \ long-form text. This text may be formatted by the user interface.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX\DC1\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\DC1\t\CAN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\DC1\ESC\FS\n\
    \?\n\
    \\STX\EOT\SOH\DC2\EOT\NAK\NUL\"\SOH\SUB3 (-- api-linter: core::0203::optional=disabled --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\NAK\b\SUB\n\
    \\135\SOH\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\CAN\STX\DC2\SUBz A name scoped by the task queue that maps to this workflow definition.\n\
    \ If missing, this workflow is a dynamic workflow.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\CAN\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\CAN\t\r\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\CAN\DLE\DC1\n\
    \1\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\ESC\STX?\SUB$ Query definitions, sorted by name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\EOT\DC2\ETX\ESC\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ACK\DC2\ETX\ESC\v(\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\ESC):\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\ESC=>\n\
    \2\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX\RS\STX@\SUB% Signal definitions, sorted by name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\EOT\DC2\ETX\RS\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ACK\DC2\ETX\RS\v(\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX\RS);\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX\RS>?\n\
    \2\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX!\STX@\SUB% Update definitions, sorted by name.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\EOT\DC2\ETX!\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ACK\DC2\ETX!\v(\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX!);\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX!>?\n\
    \\184\SOH\n\
    \\STX\EOT\STX\DC2\EOT'\NUL0\SOH\SUB\171\SOH (-- api-linter: core::0123::resource-annotation=disabled\n\
    \     aip.dev/not-precedent: The `name` field is optional. --)\n\
    \ (-- api-linter: core::0203::optional=disabled --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX'\b%\n\
    \\222\SOH\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX+\STX\DC2\SUB\208\SOH An optional name for the handler. If missing, it represents\n\
    \ a dynamic handler that processes any interactions not handled by others.\n\
    \ There is at most one dynamic handler per workflow and interaction kind.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX+\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX+\t\r\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX+\DLE\DC1\n\
    \\207\SOH\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX/\STX\EM\SUB\193\SOH An optional interaction description provided by the application.\n\
    \ By convention, external tools may interpret its first part,\n\
    \ i.e., ending with a line break, as a summary of the description.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX/\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX/\t\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX/\ETB\CANb\ACKproto3"