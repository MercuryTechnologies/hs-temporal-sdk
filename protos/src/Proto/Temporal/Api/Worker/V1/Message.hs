{- This file was auto-generated from temporal/api/worker/v1/message.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Worker.V1.Message (
        WorkerHeartbeat(), WorkerHostInfo(), WorkerInfo(),
        WorkerPollerInfo(), WorkerSlotsInfo()
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
import qualified Proto.Temporal.Api.Deployment.V1.Message
import qualified Proto.Temporal.Api.Enums.V1.Common
{- | Fields :
     
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.workerInstanceKey' @:: Lens' WorkerHeartbeat Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.workerIdentity' @:: Lens' WorkerHeartbeat Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.hostInfo' @:: Lens' WorkerHeartbeat WorkerHostInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'hostInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerHostInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.taskQueue' @:: Lens' WorkerHeartbeat Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.deploymentVersion' @:: Lens' WorkerHeartbeat Proto.Temporal.Api.Deployment.V1.Message.WorkerDeploymentVersion@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'deploymentVersion' @:: Lens' WorkerHeartbeat (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.WorkerDeploymentVersion)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.sdkName' @:: Lens' WorkerHeartbeat Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.sdkVersion' @:: Lens' WorkerHeartbeat Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.status' @:: Lens' WorkerHeartbeat Proto.Temporal.Api.Enums.V1.Common.WorkerStatus@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.startTime' @:: Lens' WorkerHeartbeat Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'startTime' @:: Lens' WorkerHeartbeat (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.heartbeatTime' @:: Lens' WorkerHeartbeat Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'heartbeatTime' @:: Lens' WorkerHeartbeat (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.elapsedSinceLastHeartbeat' @:: Lens' WorkerHeartbeat Proto.Google.Protobuf.Duration.Duration@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'elapsedSinceLastHeartbeat' @:: Lens' WorkerHeartbeat (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.workflowTaskSlotsInfo' @:: Lens' WorkerHeartbeat WorkerSlotsInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'workflowTaskSlotsInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerSlotsInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.activityTaskSlotsInfo' @:: Lens' WorkerHeartbeat WorkerSlotsInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'activityTaskSlotsInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerSlotsInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.nexusTaskSlotsInfo' @:: Lens' WorkerHeartbeat WorkerSlotsInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'nexusTaskSlotsInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerSlotsInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.localActivitySlotsInfo' @:: Lens' WorkerHeartbeat WorkerSlotsInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'localActivitySlotsInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerSlotsInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.workflowPollerInfo' @:: Lens' WorkerHeartbeat WorkerPollerInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'workflowPollerInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerPollerInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.workflowStickyPollerInfo' @:: Lens' WorkerHeartbeat WorkerPollerInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'workflowStickyPollerInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerPollerInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.activityPollerInfo' @:: Lens' WorkerHeartbeat WorkerPollerInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'activityPollerInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerPollerInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.nexusPollerInfo' @:: Lens' WorkerHeartbeat WorkerPollerInfo@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'nexusPollerInfo' @:: Lens' WorkerHeartbeat (Prelude.Maybe WorkerPollerInfo)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.totalStickyCacheHit' @:: Lens' WorkerHeartbeat Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.totalStickyCacheMiss' @:: Lens' WorkerHeartbeat Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.currentStickyCacheSize' @:: Lens' WorkerHeartbeat Data.Int.Int32@ -}
data WorkerHeartbeat
  = WorkerHeartbeat'_constructor {_WorkerHeartbeat'workerInstanceKey :: !Data.Text.Text,
                                  _WorkerHeartbeat'workerIdentity :: !Data.Text.Text,
                                  _WorkerHeartbeat'hostInfo :: !(Prelude.Maybe WorkerHostInfo),
                                  _WorkerHeartbeat'taskQueue :: !Data.Text.Text,
                                  _WorkerHeartbeat'deploymentVersion :: !(Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.WorkerDeploymentVersion),
                                  _WorkerHeartbeat'sdkName :: !Data.Text.Text,
                                  _WorkerHeartbeat'sdkVersion :: !Data.Text.Text,
                                  _WorkerHeartbeat'status :: !Proto.Temporal.Api.Enums.V1.Common.WorkerStatus,
                                  _WorkerHeartbeat'startTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                  _WorkerHeartbeat'heartbeatTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                  _WorkerHeartbeat'elapsedSinceLastHeartbeat :: !(Prelude.Maybe Proto.Google.Protobuf.Duration.Duration),
                                  _WorkerHeartbeat'workflowTaskSlotsInfo :: !(Prelude.Maybe WorkerSlotsInfo),
                                  _WorkerHeartbeat'activityTaskSlotsInfo :: !(Prelude.Maybe WorkerSlotsInfo),
                                  _WorkerHeartbeat'nexusTaskSlotsInfo :: !(Prelude.Maybe WorkerSlotsInfo),
                                  _WorkerHeartbeat'localActivitySlotsInfo :: !(Prelude.Maybe WorkerSlotsInfo),
                                  _WorkerHeartbeat'workflowPollerInfo :: !(Prelude.Maybe WorkerPollerInfo),
                                  _WorkerHeartbeat'workflowStickyPollerInfo :: !(Prelude.Maybe WorkerPollerInfo),
                                  _WorkerHeartbeat'activityPollerInfo :: !(Prelude.Maybe WorkerPollerInfo),
                                  _WorkerHeartbeat'nexusPollerInfo :: !(Prelude.Maybe WorkerPollerInfo),
                                  _WorkerHeartbeat'totalStickyCacheHit :: !Data.Int.Int32,
                                  _WorkerHeartbeat'totalStickyCacheMiss :: !Data.Int.Int32,
                                  _WorkerHeartbeat'currentStickyCacheSize :: !Data.Int.Int32,
                                  _WorkerHeartbeat'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerHeartbeat where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "workerInstanceKey" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workerInstanceKey
           (\ x__ y__ -> x__ {_WorkerHeartbeat'workerInstanceKey = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "workerIdentity" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workerIdentity
           (\ x__ y__ -> x__ {_WorkerHeartbeat'workerIdentity = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "hostInfo" WorkerHostInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'hostInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'hostInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'hostInfo" (Prelude.Maybe WorkerHostInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'hostInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'hostInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "taskQueue" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'taskQueue
           (\ x__ y__ -> x__ {_WorkerHeartbeat'taskQueue = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "deploymentVersion" Proto.Temporal.Api.Deployment.V1.Message.WorkerDeploymentVersion where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'deploymentVersion
           (\ x__ y__ -> x__ {_WorkerHeartbeat'deploymentVersion = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'deploymentVersion" (Prelude.Maybe Proto.Temporal.Api.Deployment.V1.Message.WorkerDeploymentVersion) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'deploymentVersion
           (\ x__ y__ -> x__ {_WorkerHeartbeat'deploymentVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "sdkName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'sdkName
           (\ x__ y__ -> x__ {_WorkerHeartbeat'sdkName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "sdkVersion" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'sdkVersion
           (\ x__ y__ -> x__ {_WorkerHeartbeat'sdkVersion = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "status" Proto.Temporal.Api.Enums.V1.Common.WorkerStatus where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'status
           (\ x__ y__ -> x__ {_WorkerHeartbeat'status = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "startTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'startTime
           (\ x__ y__ -> x__ {_WorkerHeartbeat'startTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'startTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'startTime
           (\ x__ y__ -> x__ {_WorkerHeartbeat'startTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "heartbeatTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'heartbeatTime
           (\ x__ y__ -> x__ {_WorkerHeartbeat'heartbeatTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'heartbeatTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'heartbeatTime
           (\ x__ y__ -> x__ {_WorkerHeartbeat'heartbeatTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "elapsedSinceLastHeartbeat" Proto.Google.Protobuf.Duration.Duration where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'elapsedSinceLastHeartbeat
           (\ x__ y__
              -> x__ {_WorkerHeartbeat'elapsedSinceLastHeartbeat = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'elapsedSinceLastHeartbeat" (Prelude.Maybe Proto.Google.Protobuf.Duration.Duration) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'elapsedSinceLastHeartbeat
           (\ x__ y__
              -> x__ {_WorkerHeartbeat'elapsedSinceLastHeartbeat = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "workflowTaskSlotsInfo" WorkerSlotsInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workflowTaskSlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'workflowTaskSlotsInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'workflowTaskSlotsInfo" (Prelude.Maybe WorkerSlotsInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workflowTaskSlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'workflowTaskSlotsInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "activityTaskSlotsInfo" WorkerSlotsInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'activityTaskSlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'activityTaskSlotsInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'activityTaskSlotsInfo" (Prelude.Maybe WorkerSlotsInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'activityTaskSlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'activityTaskSlotsInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "nexusTaskSlotsInfo" WorkerSlotsInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'nexusTaskSlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'nexusTaskSlotsInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'nexusTaskSlotsInfo" (Prelude.Maybe WorkerSlotsInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'nexusTaskSlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'nexusTaskSlotsInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "localActivitySlotsInfo" WorkerSlotsInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'localActivitySlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'localActivitySlotsInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'localActivitySlotsInfo" (Prelude.Maybe WorkerSlotsInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'localActivitySlotsInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'localActivitySlotsInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "workflowPollerInfo" WorkerPollerInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workflowPollerInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'workflowPollerInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'workflowPollerInfo" (Prelude.Maybe WorkerPollerInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workflowPollerInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'workflowPollerInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "workflowStickyPollerInfo" WorkerPollerInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workflowStickyPollerInfo
           (\ x__ y__
              -> x__ {_WorkerHeartbeat'workflowStickyPollerInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'workflowStickyPollerInfo" (Prelude.Maybe WorkerPollerInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'workflowStickyPollerInfo
           (\ x__ y__
              -> x__ {_WorkerHeartbeat'workflowStickyPollerInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "activityPollerInfo" WorkerPollerInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'activityPollerInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'activityPollerInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'activityPollerInfo" (Prelude.Maybe WorkerPollerInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'activityPollerInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'activityPollerInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "nexusPollerInfo" WorkerPollerInfo where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'nexusPollerInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'nexusPollerInfo = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "maybe'nexusPollerInfo" (Prelude.Maybe WorkerPollerInfo) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'nexusPollerInfo
           (\ x__ y__ -> x__ {_WorkerHeartbeat'nexusPollerInfo = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "totalStickyCacheHit" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'totalStickyCacheHit
           (\ x__ y__ -> x__ {_WorkerHeartbeat'totalStickyCacheHit = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "totalStickyCacheMiss" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'totalStickyCacheMiss
           (\ x__ y__ -> x__ {_WorkerHeartbeat'totalStickyCacheMiss = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHeartbeat "currentStickyCacheSize" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHeartbeat'currentStickyCacheSize
           (\ x__ y__ -> x__ {_WorkerHeartbeat'currentStickyCacheSize = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerHeartbeat where
  messageName _
    = Data.Text.pack "temporal.api.worker.v1.WorkerHeartbeat"
  packedMessageDescriptor _
    = "\n\
      \\SIWorkerHeartbeat\DC2.\n\
      \\DC3worker_instance_key\CAN\SOH \SOH(\tR\DC1workerInstanceKey\DC2'\n\
      \\SIworker_identity\CAN\STX \SOH(\tR\SOworkerIdentity\DC2C\n\
      \\thost_info\CAN\ETX \SOH(\v2&.temporal.api.worker.v1.WorkerHostInfoR\bhostInfo\DC2\GS\n\
      \\n\
      \task_queue\CAN\EOT \SOH(\tR\ttaskQueue\DC2b\n\
      \\DC2deployment_version\CAN\ENQ \SOH(\v23.temporal.api.deployment.v1.WorkerDeploymentVersionR\DC1deploymentVersion\DC2\EM\n\
      \\bsdk_name\CAN\ACK \SOH(\tR\asdkName\DC2\US\n\
      \\vsdk_version\CAN\a \SOH(\tR\n\
      \sdkVersion\DC2;\n\
      \\ACKstatus\CAN\b \SOH(\SO2#.temporal.api.enums.v1.WorkerStatusR\ACKstatus\DC29\n\
      \\n\
      \start_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\DC2A\n\
      \\SOheartbeat_time\CAN\n\
      \ \SOH(\v2\SUB.google.protobuf.TimestampR\rheartbeatTime\DC2Z\n\
      \\FSelapsed_since_last_heartbeat\CAN\v \SOH(\v2\EM.google.protobuf.DurationR\EMelapsedSinceLastHeartbeat\DC2`\n\
      \\CANworkflow_task_slots_info\CAN\f \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\NAKworkflowTaskSlotsInfo\DC2`\n\
      \\CANactivity_task_slots_info\CAN\r \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\NAKactivityTaskSlotsInfo\DC2Z\n\
      \\NAKnexus_task_slots_info\CAN\SO \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\DC2nexusTaskSlotsInfo\DC2b\n\
      \\EMlocal_activity_slots_info\CAN\SI \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\SYNlocalActivitySlotsInfo\DC2Z\n\
      \\DC4workflow_poller_info\CAN\DLE \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\DC2workflowPollerInfo\DC2g\n\
      \\ESCworkflow_sticky_poller_info\CAN\DC1 \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\CANworkflowStickyPollerInfo\DC2Z\n\
      \\DC4activity_poller_info\CAN\DC2 \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\DC2activityPollerInfo\DC2T\n\
      \\DC1nexus_poller_info\CAN\DC3 \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\SInexusPollerInfo\DC23\n\
      \\SYNtotal_sticky_cache_hit\CAN\DC4 \SOH(\ENQR\DC3totalStickyCacheHit\DC25\n\
      \\ETBtotal_sticky_cache_miss\CAN\NAK \SOH(\ENQR\DC4totalStickyCacheMiss\DC29\n\
      \\EMcurrent_sticky_cache_size\CAN\SYN \SOH(\ENQR\SYNcurrentStickyCacheSize"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workerInstanceKey__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker_instance_key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workerInstanceKey")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        workerIdentity__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker_identity"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"workerIdentity")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        hostInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "host_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerHostInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'hostInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        taskQueue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "task_queue"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"taskQueue")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        deploymentVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "deployment_version"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Deployment.V1.Message.WorkerDeploymentVersion)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'deploymentVersion")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        sdkName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sdk_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"sdkName")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        sdkVersion__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "sdk_version"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"sdkVersion")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        status__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "status"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Temporal.Api.Enums.V1.Common.WorkerStatus)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"status")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        startTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startTime")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        heartbeatTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "heartbeat_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'heartbeatTime")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        elapsedSinceLastHeartbeat__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "elapsed_since_last_heartbeat"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Duration.Duration)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'elapsedSinceLastHeartbeat")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        workflowTaskSlotsInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_task_slots_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerSlotsInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowTaskSlotsInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        activityTaskSlotsInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_task_slots_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerSlotsInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'activityTaskSlotsInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        nexusTaskSlotsInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "nexus_task_slots_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerSlotsInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nexusTaskSlotsInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        localActivitySlotsInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "local_activity_slots_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerSlotsInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'localActivitySlotsInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        workflowPollerInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_poller_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerPollerInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowPollerInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        workflowStickyPollerInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "workflow_sticky_poller_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerPollerInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workflowStickyPollerInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        activityPollerInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "activity_poller_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerPollerInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'activityPollerInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        nexusPollerInfo__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "nexus_poller_info"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerPollerInfo)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'nexusPollerInfo")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        totalStickyCacheHit__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "total_sticky_cache_hit"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"totalStickyCacheHit")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        totalStickyCacheMiss__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "total_sticky_cache_miss"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"totalStickyCacheMiss")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
        currentStickyCacheSize__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_sticky_cache_size"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentStickyCacheSize")) ::
              Data.ProtoLens.FieldDescriptor WorkerHeartbeat
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workerInstanceKey__field_descriptor),
           (Data.ProtoLens.Tag 2, workerIdentity__field_descriptor),
           (Data.ProtoLens.Tag 3, hostInfo__field_descriptor),
           (Data.ProtoLens.Tag 4, taskQueue__field_descriptor),
           (Data.ProtoLens.Tag 5, deploymentVersion__field_descriptor),
           (Data.ProtoLens.Tag 6, sdkName__field_descriptor),
           (Data.ProtoLens.Tag 7, sdkVersion__field_descriptor),
           (Data.ProtoLens.Tag 8, status__field_descriptor),
           (Data.ProtoLens.Tag 9, startTime__field_descriptor),
           (Data.ProtoLens.Tag 10, heartbeatTime__field_descriptor),
           (Data.ProtoLens.Tag 11, 
            elapsedSinceLastHeartbeat__field_descriptor),
           (Data.ProtoLens.Tag 12, workflowTaskSlotsInfo__field_descriptor),
           (Data.ProtoLens.Tag 13, activityTaskSlotsInfo__field_descriptor),
           (Data.ProtoLens.Tag 14, nexusTaskSlotsInfo__field_descriptor),
           (Data.ProtoLens.Tag 15, localActivitySlotsInfo__field_descriptor),
           (Data.ProtoLens.Tag 16, workflowPollerInfo__field_descriptor),
           (Data.ProtoLens.Tag 17, 
            workflowStickyPollerInfo__field_descriptor),
           (Data.ProtoLens.Tag 18, activityPollerInfo__field_descriptor),
           (Data.ProtoLens.Tag 19, nexusPollerInfo__field_descriptor),
           (Data.ProtoLens.Tag 20, totalStickyCacheHit__field_descriptor),
           (Data.ProtoLens.Tag 21, totalStickyCacheMiss__field_descriptor),
           (Data.ProtoLens.Tag 22, currentStickyCacheSize__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerHeartbeat'_unknownFields
        (\ x__ y__ -> x__ {_WorkerHeartbeat'_unknownFields = y__})
  defMessage
    = WorkerHeartbeat'_constructor
        {_WorkerHeartbeat'workerInstanceKey = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'workerIdentity = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'hostInfo = Prelude.Nothing,
         _WorkerHeartbeat'taskQueue = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'deploymentVersion = Prelude.Nothing,
         _WorkerHeartbeat'sdkName = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'sdkVersion = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'status = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'startTime = Prelude.Nothing,
         _WorkerHeartbeat'heartbeatTime = Prelude.Nothing,
         _WorkerHeartbeat'elapsedSinceLastHeartbeat = Prelude.Nothing,
         _WorkerHeartbeat'workflowTaskSlotsInfo = Prelude.Nothing,
         _WorkerHeartbeat'activityTaskSlotsInfo = Prelude.Nothing,
         _WorkerHeartbeat'nexusTaskSlotsInfo = Prelude.Nothing,
         _WorkerHeartbeat'localActivitySlotsInfo = Prelude.Nothing,
         _WorkerHeartbeat'workflowPollerInfo = Prelude.Nothing,
         _WorkerHeartbeat'workflowStickyPollerInfo = Prelude.Nothing,
         _WorkerHeartbeat'activityPollerInfo = Prelude.Nothing,
         _WorkerHeartbeat'nexusPollerInfo = Prelude.Nothing,
         _WorkerHeartbeat'totalStickyCacheHit = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'totalStickyCacheMiss = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'currentStickyCacheSize = Data.ProtoLens.fieldDefault,
         _WorkerHeartbeat'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerHeartbeat
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerHeartbeat
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
                                       "worker_instance_key"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workerInstanceKey") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "worker_identity"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workerIdentity") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "host_info"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"hostInfo") y x)
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "task_queue"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"taskQueue") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "deployment_version"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"deploymentVersion") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "sdk_name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"sdkName") y x)
                        58
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "sdk_version"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"sdkVersion") y x)
                        64
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "status"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"status") y x)
                        74
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_time"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"startTime") y x)
                        82
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "heartbeat_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"heartbeatTime") y x)
                        90
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "elapsed_since_last_heartbeat"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"elapsedSinceLastHeartbeat") y x)
                        98
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_task_slots_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowTaskSlotsInfo") y x)
                        106
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "activity_task_slots_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityTaskSlotsInfo") y x)
                        114
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "nexus_task_slots_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nexusTaskSlotsInfo") y x)
                        122
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "local_activity_slots_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"localActivitySlotsInfo") y x)
                        130
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_poller_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowPollerInfo") y x)
                        138
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "workflow_sticky_poller_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workflowStickyPollerInfo") y x)
                        146
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "activity_poller_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"activityPollerInfo") y x)
                        154
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "nexus_poller_info"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"nexusPollerInfo") y x)
                        160
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "total_sticky_cache_hit"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"totalStickyCacheHit") y x)
                        168
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "total_sticky_cache_miss"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"totalStickyCacheMiss") y x)
                        176
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "current_sticky_cache_size"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentStickyCacheSize") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerHeartbeat"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"workerInstanceKey") _x
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
                         (Data.ProtoLens.Field.field @"workerIdentity") _x
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
                   (case
                        Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'hostInfo") _x
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
                         _v = Lens.Family2.view (Data.ProtoLens.Field.field @"taskQueue") _x
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
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'deploymentVersion") _x
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
                            (let
                               _v = Lens.Family2.view (Data.ProtoLens.Field.field @"sdkName") _x
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
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"sdkVersion") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                        ((Prelude..)
                                           (\ bs
                                              -> (Data.Monoid.<>)
                                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                      (Prelude.fromIntegral
                                                         (Data.ByteString.length bs)))
                                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                           Data.Text.Encoding.encodeUtf8 _v))
                               ((Data.Monoid.<>)
                                  (let
                                     _v
                                       = Lens.Family2.view (Data.ProtoLens.Field.field @"status") _x
                                   in
                                     if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                         Data.Monoid.mempty
                                     else
                                         (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt 64)
                                           ((Prelude..)
                                              ((Prelude..)
                                                 Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 Prelude.fromIntegral)
                                              Prelude.fromEnum _v))
                                  ((Data.Monoid.<>)
                                     (case
                                          Lens.Family2.view
                                            (Data.ProtoLens.Field.field @"maybe'startTime") _x
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
                                               (Data.ProtoLens.Field.field @"maybe'heartbeatTime")
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
                                           (case
                                                Lens.Family2.view
                                                  (Data.ProtoLens.Field.field
                                                     @"maybe'elapsedSinceLastHeartbeat")
                                                  _x
                                            of
                                              Prelude.Nothing -> Data.Monoid.mempty
                                              (Prelude.Just _v)
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 90)
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
                                                        @"maybe'workflowTaskSlotsInfo")
                                                     _x
                                               of
                                                 Prelude.Nothing -> Data.Monoid.mempty
                                                 (Prelude.Just _v)
                                                   -> (Data.Monoid.<>)
                                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 98)
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
                                                           @"maybe'activityTaskSlotsInfo")
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
                                                              @"maybe'nexusTaskSlotsInfo")
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
                                                       (case
                                                            Lens.Family2.view
                                                              (Data.ProtoLens.Field.field
                                                                 @"maybe'localActivitySlotsInfo")
                                                              _x
                                                        of
                                                          Prelude.Nothing -> Data.Monoid.mempty
                                                          (Prelude.Just _v)
                                                            -> (Data.Monoid.<>)
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
                                                                    Data.ProtoLens.encodeMessage
                                                                    _v))
                                                       ((Data.Monoid.<>)
                                                          (case
                                                               Lens.Family2.view
                                                                 (Data.ProtoLens.Field.field
                                                                    @"maybe'workflowPollerInfo")
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
                                                             (case
                                                                  Lens.Family2.view
                                                                    (Data.ProtoLens.Field.field
                                                                       @"maybe'workflowStickyPollerInfo")
                                                                    _x
                                                              of
                                                                Prelude.Nothing
                                                                  -> Data.Monoid.mempty
                                                                (Prelude.Just _v)
                                                                  -> (Data.Monoid.<>)
                                                                       (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                          138)
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
                                                                          @"maybe'activityPollerInfo")
                                                                       _x
                                                                 of
                                                                   Prelude.Nothing
                                                                     -> Data.Monoid.mempty
                                                                   (Prelude.Just _v)
                                                                     -> (Data.Monoid.<>)
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
                                                                             Data.ProtoLens.encodeMessage
                                                                             _v))
                                                                ((Data.Monoid.<>)
                                                                   (case
                                                                        Lens.Family2.view
                                                                          (Data.ProtoLens.Field.field
                                                                             @"maybe'nexusPollerInfo")
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
                                                                      (let
                                                                         _v
                                                                           = Lens.Family2.view
                                                                               (Data.ProtoLens.Field.field
                                                                                  @"totalStickyCacheHit")
                                                                               _x
                                                                       in
                                                                         if (Prelude.==)
                                                                              _v
                                                                              Data.ProtoLens.fieldDefault then
                                                                             Data.Monoid.mempty
                                                                         else
                                                                             (Data.Monoid.<>)
                                                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  160)
                                                                               ((Prelude..)
                                                                                  Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                  Prelude.fromIntegral
                                                                                  _v))
                                                                      ((Data.Monoid.<>)
                                                                         (let
                                                                            _v
                                                                              = Lens.Family2.view
                                                                                  (Data.ProtoLens.Field.field
                                                                                     @"totalStickyCacheMiss")
                                                                                  _x
                                                                          in
                                                                            if (Prelude.==)
                                                                                 _v
                                                                                 Data.ProtoLens.fieldDefault then
                                                                                Data.Monoid.mempty
                                                                            else
                                                                                (Data.Monoid.<>)
                                                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                     168)
                                                                                  ((Prelude..)
                                                                                     Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                     Prelude.fromIntegral
                                                                                     _v))
                                                                         ((Data.Monoid.<>)
                                                                            (let
                                                                               _v
                                                                                 = Lens.Family2.view
                                                                                     (Data.ProtoLens.Field.field
                                                                                        @"currentStickyCacheSize")
                                                                                     _x
                                                                             in
                                                                               if (Prelude.==)
                                                                                    _v
                                                                                    Data.ProtoLens.fieldDefault then
                                                                                   Data.Monoid.mempty
                                                                               else
                                                                                   (Data.Monoid.<>)
                                                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                        176)
                                                                                     ((Prelude..)
                                                                                        Data.ProtoLens.Encoding.Bytes.putVarInt
                                                                                        Prelude.fromIntegral
                                                                                        _v))
                                                                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                                                               (Lens.Family2.view
                                                                                  Data.ProtoLens.unknownFields
                                                                                  _x)))))))))))))))))))))))
instance Control.DeepSeq.NFData WorkerHeartbeat where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerHeartbeat'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerHeartbeat'workerInstanceKey x__)
                (Control.DeepSeq.deepseq
                   (_WorkerHeartbeat'workerIdentity x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerHeartbeat'hostInfo x__)
                      (Control.DeepSeq.deepseq
                         (_WorkerHeartbeat'taskQueue x__)
                         (Control.DeepSeq.deepseq
                            (_WorkerHeartbeat'deploymentVersion x__)
                            (Control.DeepSeq.deepseq
                               (_WorkerHeartbeat'sdkName x__)
                               (Control.DeepSeq.deepseq
                                  (_WorkerHeartbeat'sdkVersion x__)
                                  (Control.DeepSeq.deepseq
                                     (_WorkerHeartbeat'status x__)
                                     (Control.DeepSeq.deepseq
                                        (_WorkerHeartbeat'startTime x__)
                                        (Control.DeepSeq.deepseq
                                           (_WorkerHeartbeat'heartbeatTime x__)
                                           (Control.DeepSeq.deepseq
                                              (_WorkerHeartbeat'elapsedSinceLastHeartbeat x__)
                                              (Control.DeepSeq.deepseq
                                                 (_WorkerHeartbeat'workflowTaskSlotsInfo x__)
                                                 (Control.DeepSeq.deepseq
                                                    (_WorkerHeartbeat'activityTaskSlotsInfo x__)
                                                    (Control.DeepSeq.deepseq
                                                       (_WorkerHeartbeat'nexusTaskSlotsInfo x__)
                                                       (Control.DeepSeq.deepseq
                                                          (_WorkerHeartbeat'localActivitySlotsInfo
                                                             x__)
                                                          (Control.DeepSeq.deepseq
                                                             (_WorkerHeartbeat'workflowPollerInfo
                                                                x__)
                                                             (Control.DeepSeq.deepseq
                                                                (_WorkerHeartbeat'workflowStickyPollerInfo
                                                                   x__)
                                                                (Control.DeepSeq.deepseq
                                                                   (_WorkerHeartbeat'activityPollerInfo
                                                                      x__)
                                                                   (Control.DeepSeq.deepseq
                                                                      (_WorkerHeartbeat'nexusPollerInfo
                                                                         x__)
                                                                      (Control.DeepSeq.deepseq
                                                                         (_WorkerHeartbeat'totalStickyCacheHit
                                                                            x__)
                                                                         (Control.DeepSeq.deepseq
                                                                            (_WorkerHeartbeat'totalStickyCacheMiss
                                                                               x__)
                                                                            (Control.DeepSeq.deepseq
                                                                               (_WorkerHeartbeat'currentStickyCacheSize
                                                                                  x__)
                                                                               ()))))))))))))))))))))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.hostName' @:: Lens' WorkerHostInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.processKey' @:: Lens' WorkerHostInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.processId' @:: Lens' WorkerHostInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.currentHostCpuUsage' @:: Lens' WorkerHostInfo Prelude.Float@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.currentHostMemUsage' @:: Lens' WorkerHostInfo Prelude.Float@ -}
data WorkerHostInfo
  = WorkerHostInfo'_constructor {_WorkerHostInfo'hostName :: !Data.Text.Text,
                                 _WorkerHostInfo'processKey :: !Data.Text.Text,
                                 _WorkerHostInfo'processId :: !Data.Text.Text,
                                 _WorkerHostInfo'currentHostCpuUsage :: !Prelude.Float,
                                 _WorkerHostInfo'currentHostMemUsage :: !Prelude.Float,
                                 _WorkerHostInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerHostInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerHostInfo "hostName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHostInfo'hostName
           (\ x__ y__ -> x__ {_WorkerHostInfo'hostName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHostInfo "processKey" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHostInfo'processKey
           (\ x__ y__ -> x__ {_WorkerHostInfo'processKey = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHostInfo "processId" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHostInfo'processId
           (\ x__ y__ -> x__ {_WorkerHostInfo'processId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHostInfo "currentHostCpuUsage" Prelude.Float where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHostInfo'currentHostCpuUsage
           (\ x__ y__ -> x__ {_WorkerHostInfo'currentHostCpuUsage = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerHostInfo "currentHostMemUsage" Prelude.Float where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerHostInfo'currentHostMemUsage
           (\ x__ y__ -> x__ {_WorkerHostInfo'currentHostMemUsage = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerHostInfo where
  messageName _
    = Data.Text.pack "temporal.api.worker.v1.WorkerHostInfo"
  packedMessageDescriptor _
    = "\n\
      \\SOWorkerHostInfo\DC2\ESC\n\
      \\thost_name\CAN\SOH \SOH(\tR\bhostName\DC2\US\n\
      \\vprocess_key\CAN\ENQ \SOH(\tR\n\
      \processKey\DC2\GS\n\
      \\n\
      \process_id\CAN\STX \SOH(\tR\tprocessId\DC23\n\
      \\SYNcurrent_host_cpu_usage\CAN\ETX \SOH(\STXR\DC3currentHostCpuUsage\DC23\n\
      \\SYNcurrent_host_mem_usage\CAN\EOT \SOH(\STXR\DC3currentHostMemUsage"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        hostName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "host_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"hostName")) ::
              Data.ProtoLens.FieldDescriptor WorkerHostInfo
        processKey__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "process_key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"processKey")) ::
              Data.ProtoLens.FieldDescriptor WorkerHostInfo
        processId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "process_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"processId")) ::
              Data.ProtoLens.FieldDescriptor WorkerHostInfo
        currentHostCpuUsage__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_host_cpu_usage"
              (Data.ProtoLens.ScalarField Data.ProtoLens.FloatField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentHostCpuUsage")) ::
              Data.ProtoLens.FieldDescriptor WorkerHostInfo
        currentHostMemUsage__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_host_mem_usage"
              (Data.ProtoLens.ScalarField Data.ProtoLens.FloatField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Float)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentHostMemUsage")) ::
              Data.ProtoLens.FieldDescriptor WorkerHostInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, hostName__field_descriptor),
           (Data.ProtoLens.Tag 5, processKey__field_descriptor),
           (Data.ProtoLens.Tag 2, processId__field_descriptor),
           (Data.ProtoLens.Tag 3, currentHostCpuUsage__field_descriptor),
           (Data.ProtoLens.Tag 4, currentHostMemUsage__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerHostInfo'_unknownFields
        (\ x__ y__ -> x__ {_WorkerHostInfo'_unknownFields = y__})
  defMessage
    = WorkerHostInfo'_constructor
        {_WorkerHostInfo'hostName = Data.ProtoLens.fieldDefault,
         _WorkerHostInfo'processKey = Data.ProtoLens.fieldDefault,
         _WorkerHostInfo'processId = Data.ProtoLens.fieldDefault,
         _WorkerHostInfo'currentHostCpuUsage = Data.ProtoLens.fieldDefault,
         _WorkerHostInfo'currentHostMemUsage = Data.ProtoLens.fieldDefault,
         _WorkerHostInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerHostInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerHostInfo
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
                                       "host_name"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"hostName") y x)
                        42
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "process_key"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"processKey") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "process_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"processId") y x)
                        29
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToFloat
                                          Data.ProtoLens.Encoding.Bytes.getFixed32)
                                       "current_host_cpu_usage"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentHostCpuUsage") y x)
                        37
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToFloat
                                          Data.ProtoLens.Encoding.Bytes.getFixed32)
                                       "current_host_mem_usage"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentHostMemUsage") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerHostInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"hostName") _x
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
                     = Lens.Family2.view (Data.ProtoLens.Field.field @"processKey") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (let
                      _v = Lens.Family2.view (Data.ProtoLens.Field.field @"processId") _x
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
                               (Data.ProtoLens.Field.field @"currentHostCpuUsage") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 29)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putFixed32
                                  Data.ProtoLens.Encoding.Bytes.floatToWord _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"currentHostMemUsage") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 37)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putFixed32
                                     Data.ProtoLens.Encoding.Bytes.floatToWord _v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData WorkerHostInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerHostInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerHostInfo'hostName x__)
                (Control.DeepSeq.deepseq
                   (_WorkerHostInfo'processKey x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerHostInfo'processId x__)
                      (Control.DeepSeq.deepseq
                         (_WorkerHostInfo'currentHostCpuUsage x__)
                         (Control.DeepSeq.deepseq
                            (_WorkerHostInfo'currentHostMemUsage x__) ())))))
{- | Fields :
     
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.workerHeartbeat' @:: Lens' WorkerInfo WorkerHeartbeat@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'workerHeartbeat' @:: Lens' WorkerInfo (Prelude.Maybe WorkerHeartbeat)@ -}
data WorkerInfo
  = WorkerInfo'_constructor {_WorkerInfo'workerHeartbeat :: !(Prelude.Maybe WorkerHeartbeat),
                             _WorkerInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerInfo "workerHeartbeat" WorkerHeartbeat where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerInfo'workerHeartbeat
           (\ x__ y__ -> x__ {_WorkerInfo'workerHeartbeat = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerInfo "maybe'workerHeartbeat" (Prelude.Maybe WorkerHeartbeat) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerInfo'workerHeartbeat
           (\ x__ y__ -> x__ {_WorkerInfo'workerHeartbeat = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerInfo where
  messageName _ = Data.Text.pack "temporal.api.worker.v1.WorkerInfo"
  packedMessageDescriptor _
    = "\n\
      \\n\
      \WorkerInfo\DC2R\n\
      \\DLEworker_heartbeat\CAN\SOH \SOH(\v2'.temporal.api.worker.v1.WorkerHeartbeatR\SIworkerHeartbeat"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        workerHeartbeat__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "worker_heartbeat"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor WorkerHeartbeat)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'workerHeartbeat")) ::
              Data.ProtoLens.FieldDescriptor WorkerInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, workerHeartbeat__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerInfo'_unknownFields
        (\ x__ y__ -> x__ {_WorkerInfo'_unknownFields = y__})
  defMessage
    = WorkerInfo'_constructor
        {_WorkerInfo'workerHeartbeat = Prelude.Nothing,
         _WorkerInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerInfo -> Data.ProtoLens.Encoding.Bytes.Parser WorkerInfo
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
                                       "worker_heartbeat"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"workerHeartbeat") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'workerHeartbeat") _x
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
instance Control.DeepSeq.NFData WorkerInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq (_WorkerInfo'workerHeartbeat x__) ())
{- | Fields :
     
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.currentPollers' @:: Lens' WorkerPollerInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.lastSuccessfulPollTime' @:: Lens' WorkerPollerInfo Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.maybe'lastSuccessfulPollTime' @:: Lens' WorkerPollerInfo (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.isAutoscaling' @:: Lens' WorkerPollerInfo Prelude.Bool@ -}
data WorkerPollerInfo
  = WorkerPollerInfo'_constructor {_WorkerPollerInfo'currentPollers :: !Data.Int.Int32,
                                   _WorkerPollerInfo'lastSuccessfulPollTime :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                   _WorkerPollerInfo'isAutoscaling :: !Prelude.Bool,
                                   _WorkerPollerInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerPollerInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerPollerInfo "currentPollers" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerPollerInfo'currentPollers
           (\ x__ y__ -> x__ {_WorkerPollerInfo'currentPollers = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerPollerInfo "lastSuccessfulPollTime" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerPollerInfo'lastSuccessfulPollTime
           (\ x__ y__
              -> x__ {_WorkerPollerInfo'lastSuccessfulPollTime = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField WorkerPollerInfo "maybe'lastSuccessfulPollTime" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerPollerInfo'lastSuccessfulPollTime
           (\ x__ y__
              -> x__ {_WorkerPollerInfo'lastSuccessfulPollTime = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerPollerInfo "isAutoscaling" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerPollerInfo'isAutoscaling
           (\ x__ y__ -> x__ {_WorkerPollerInfo'isAutoscaling = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerPollerInfo where
  messageName _
    = Data.Text.pack "temporal.api.worker.v1.WorkerPollerInfo"
  packedMessageDescriptor _
    = "\n\
      \\DLEWorkerPollerInfo\DC2'\n\
      \\SIcurrent_pollers\CAN\SOH \SOH(\ENQR\SOcurrentPollers\DC2U\n\
      \\EMlast_successful_poll_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\SYNlastSuccessfulPollTime\DC2%\n\
      \\SOis_autoscaling\CAN\ETX \SOH(\bR\risAutoscaling"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        currentPollers__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_pollers"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentPollers")) ::
              Data.ProtoLens.FieldDescriptor WorkerPollerInfo
        lastSuccessfulPollTime__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_successful_poll_time"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'lastSuccessfulPollTime")) ::
              Data.ProtoLens.FieldDescriptor WorkerPollerInfo
        isAutoscaling__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "is_autoscaling"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"isAutoscaling")) ::
              Data.ProtoLens.FieldDescriptor WorkerPollerInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, currentPollers__field_descriptor),
           (Data.ProtoLens.Tag 2, lastSuccessfulPollTime__field_descriptor),
           (Data.ProtoLens.Tag 3, isAutoscaling__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerPollerInfo'_unknownFields
        (\ x__ y__ -> x__ {_WorkerPollerInfo'_unknownFields = y__})
  defMessage
    = WorkerPollerInfo'_constructor
        {_WorkerPollerInfo'currentPollers = Data.ProtoLens.fieldDefault,
         _WorkerPollerInfo'lastSuccessfulPollTime = Prelude.Nothing,
         _WorkerPollerInfo'isAutoscaling = Data.ProtoLens.fieldDefault,
         _WorkerPollerInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerPollerInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerPollerInfo
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
                                       "current_pollers"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentPollers") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "last_successful_poll_time"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastSuccessfulPollTime") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "is_autoscaling"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"isAutoscaling") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerPollerInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"currentPollers") _x
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
                       (Data.ProtoLens.Field.field @"maybe'lastSuccessfulPollTime") _x
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
                        = Lens.Family2.view
                            (Data.ProtoLens.Field.field @"isAutoscaling") _x
                    in
                      if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                          Data.Monoid.mempty
                      else
                          (Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                            ((Prelude..)
                               Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                               _v))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData WorkerPollerInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerPollerInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerPollerInfo'currentPollers x__)
                (Control.DeepSeq.deepseq
                   (_WorkerPollerInfo'lastSuccessfulPollTime x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerPollerInfo'isAutoscaling x__) ())))
{- | Fields :
     
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.currentAvailableSlots' @:: Lens' WorkerSlotsInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.currentUsedSlots' @:: Lens' WorkerSlotsInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.slotSupplierKind' @:: Lens' WorkerSlotsInfo Data.Text.Text@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.totalProcessedTasks' @:: Lens' WorkerSlotsInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.totalFailedTasks' @:: Lens' WorkerSlotsInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.lastIntervalProcessedTasks' @:: Lens' WorkerSlotsInfo Data.Int.Int32@
         * 'Proto.Temporal.Api.Worker.V1.Message_Fields.lastIntervalFailureTasks' @:: Lens' WorkerSlotsInfo Data.Int.Int32@ -}
data WorkerSlotsInfo
  = WorkerSlotsInfo'_constructor {_WorkerSlotsInfo'currentAvailableSlots :: !Data.Int.Int32,
                                  _WorkerSlotsInfo'currentUsedSlots :: !Data.Int.Int32,
                                  _WorkerSlotsInfo'slotSupplierKind :: !Data.Text.Text,
                                  _WorkerSlotsInfo'totalProcessedTasks :: !Data.Int.Int32,
                                  _WorkerSlotsInfo'totalFailedTasks :: !Data.Int.Int32,
                                  _WorkerSlotsInfo'lastIntervalProcessedTasks :: !Data.Int.Int32,
                                  _WorkerSlotsInfo'lastIntervalFailureTasks :: !Data.Int.Int32,
                                  _WorkerSlotsInfo'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show WorkerSlotsInfo where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "currentAvailableSlots" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'currentAvailableSlots
           (\ x__ y__ -> x__ {_WorkerSlotsInfo'currentAvailableSlots = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "currentUsedSlots" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'currentUsedSlots
           (\ x__ y__ -> x__ {_WorkerSlotsInfo'currentUsedSlots = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "slotSupplierKind" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'slotSupplierKind
           (\ x__ y__ -> x__ {_WorkerSlotsInfo'slotSupplierKind = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "totalProcessedTasks" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'totalProcessedTasks
           (\ x__ y__ -> x__ {_WorkerSlotsInfo'totalProcessedTasks = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "totalFailedTasks" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'totalFailedTasks
           (\ x__ y__ -> x__ {_WorkerSlotsInfo'totalFailedTasks = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "lastIntervalProcessedTasks" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'lastIntervalProcessedTasks
           (\ x__ y__
              -> x__ {_WorkerSlotsInfo'lastIntervalProcessedTasks = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField WorkerSlotsInfo "lastIntervalFailureTasks" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _WorkerSlotsInfo'lastIntervalFailureTasks
           (\ x__ y__
              -> x__ {_WorkerSlotsInfo'lastIntervalFailureTasks = y__}))
        Prelude.id
instance Data.ProtoLens.Message WorkerSlotsInfo where
  messageName _
    = Data.Text.pack "temporal.api.worker.v1.WorkerSlotsInfo"
  packedMessageDescriptor _
    = "\n\
      \\SIWorkerSlotsInfo\DC26\n\
      \\ETBcurrent_available_slots\CAN\SOH \SOH(\ENQR\NAKcurrentAvailableSlots\DC2,\n\
      \\DC2current_used_slots\CAN\STX \SOH(\ENQR\DLEcurrentUsedSlots\DC2,\n\
      \\DC2slot_supplier_kind\CAN\ETX \SOH(\tR\DLEslotSupplierKind\DC22\n\
      \\NAKtotal_processed_tasks\CAN\EOT \SOH(\ENQR\DC3totalProcessedTasks\DC2,\n\
      \\DC2total_failed_tasks\CAN\ENQ \SOH(\ENQR\DLEtotalFailedTasks\DC2A\n\
      \\GSlast_interval_processed_tasks\CAN\ACK \SOH(\ENQR\SUBlastIntervalProcessedTasks\DC2=\n\
      \\ESClast_interval_failure_tasks\CAN\a \SOH(\ENQR\CANlastIntervalFailureTasks"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        currentAvailableSlots__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_available_slots"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentAvailableSlots")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
        currentUsedSlots__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "current_used_slots"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"currentUsedSlots")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
        slotSupplierKind__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "slot_supplier_kind"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"slotSupplierKind")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
        totalProcessedTasks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "total_processed_tasks"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"totalProcessedTasks")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
        totalFailedTasks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "total_failed_tasks"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"totalFailedTasks")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
        lastIntervalProcessedTasks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_interval_processed_tasks"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"lastIntervalProcessedTasks")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
        lastIntervalFailureTasks__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "last_interval_failure_tasks"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"lastIntervalFailureTasks")) ::
              Data.ProtoLens.FieldDescriptor WorkerSlotsInfo
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, currentAvailableSlots__field_descriptor),
           (Data.ProtoLens.Tag 2, currentUsedSlots__field_descriptor),
           (Data.ProtoLens.Tag 3, slotSupplierKind__field_descriptor),
           (Data.ProtoLens.Tag 4, totalProcessedTasks__field_descriptor),
           (Data.ProtoLens.Tag 5, totalFailedTasks__field_descriptor),
           (Data.ProtoLens.Tag 6, 
            lastIntervalProcessedTasks__field_descriptor),
           (Data.ProtoLens.Tag 7, lastIntervalFailureTasks__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _WorkerSlotsInfo'_unknownFields
        (\ x__ y__ -> x__ {_WorkerSlotsInfo'_unknownFields = y__})
  defMessage
    = WorkerSlotsInfo'_constructor
        {_WorkerSlotsInfo'currentAvailableSlots = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'currentUsedSlots = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'slotSupplierKind = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'totalProcessedTasks = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'totalFailedTasks = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'lastIntervalProcessedTasks = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'lastIntervalFailureTasks = Data.ProtoLens.fieldDefault,
         _WorkerSlotsInfo'_unknownFields = []}
  parseMessage
    = let
        loop ::
          WorkerSlotsInfo
          -> Data.ProtoLens.Encoding.Bytes.Parser WorkerSlotsInfo
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
                                       "current_available_slots"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentAvailableSlots") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "current_used_slots"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"currentUsedSlots") y x)
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "slot_supplier_kind"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"slotSupplierKind") y x)
                        32
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "total_processed_tasks"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"totalProcessedTasks") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "total_failed_tasks"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"totalFailedTasks") y x)
                        48
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "last_interval_processed_tasks"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastIntervalProcessedTasks") y x)
                        56
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "last_interval_failure_tasks"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"lastIntervalFailureTasks") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "WorkerSlotsInfo"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view
                      (Data.ProtoLens.Field.field @"currentAvailableSlots") _x
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
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"currentUsedSlots") _x
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
                            (Data.ProtoLens.Field.field @"slotSupplierKind") _x
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
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"totalProcessedTasks") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 32)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"totalFailedTasks") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  ((Prelude..)
                                     Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                     _v))
                         ((Data.Monoid.<>)
                            (let
                               _v
                                 = Lens.Family2.view
                                     (Data.ProtoLens.Field.field @"lastIntervalProcessedTasks") _x
                             in
                               if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                   Data.Monoid.mempty
                               else
                                   (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt 48)
                                     ((Prelude..)
                                        Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral
                                        _v))
                            ((Data.Monoid.<>)
                               (let
                                  _v
                                    = Lens.Family2.view
                                        (Data.ProtoLens.Field.field @"lastIntervalFailureTasks") _x
                                in
                                  if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                      Data.Monoid.mempty
                                  else
                                      (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt 56)
                                        ((Prelude..)
                                           Data.ProtoLens.Encoding.Bytes.putVarInt
                                           Prelude.fromIntegral _v))
                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
instance Control.DeepSeq.NFData WorkerSlotsInfo where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_WorkerSlotsInfo'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_WorkerSlotsInfo'currentAvailableSlots x__)
                (Control.DeepSeq.deepseq
                   (_WorkerSlotsInfo'currentUsedSlots x__)
                   (Control.DeepSeq.deepseq
                      (_WorkerSlotsInfo'slotSupplierKind x__)
                      (Control.DeepSeq.deepseq
                         (_WorkerSlotsInfo'totalProcessedTasks x__)
                         (Control.DeepSeq.deepseq
                            (_WorkerSlotsInfo'totalFailedTasks x__)
                            (Control.DeepSeq.deepseq
                               (_WorkerSlotsInfo'lastIntervalProcessedTasks x__)
                               (Control.DeepSeq.deepseq
                                  (_WorkerSlotsInfo'lastIntervalFailureTasks x__) ())))))))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \$temporal/api/worker/v1/message.proto\DC2\SYNtemporal.api.worker.v1\SUB\RSgoogle/protobuf/duration.proto\SUB\USgoogle/protobuf/timestamp.proto\SUB(temporal/api/deployment/v1/message.proto\SUB\"temporal/api/enums/v1/common.proto\"\185\SOH\n\
    \\DLEWorkerPollerInfo\DC2'\n\
    \\SIcurrent_pollers\CAN\SOH \SOH(\ENQR\SOcurrentPollers\DC2U\n\
    \\EMlast_successful_poll_time\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\SYNlastSuccessfulPollTime\DC2%\n\
    \\SOis_autoscaling\CAN\ETX \SOH(\bR\risAutoscaling\"\137\ETX\n\
    \\SIWorkerSlotsInfo\DC26\n\
    \\ETBcurrent_available_slots\CAN\SOH \SOH(\ENQR\NAKcurrentAvailableSlots\DC2,\n\
    \\DC2current_used_slots\CAN\STX \SOH(\ENQR\DLEcurrentUsedSlots\DC2,\n\
    \\DC2slot_supplier_kind\CAN\ETX \SOH(\tR\DLEslotSupplierKind\DC22\n\
    \\NAKtotal_processed_tasks\CAN\EOT \SOH(\ENQR\DC3totalProcessedTasks\DC2,\n\
    \\DC2total_failed_tasks\CAN\ENQ \SOH(\ENQR\DLEtotalFailedTasks\DC2A\n\
    \\GSlast_interval_processed_tasks\CAN\ACK \SOH(\ENQR\SUBlastIntervalProcessedTasks\DC2=\n\
    \\ESClast_interval_failure_tasks\CAN\a \SOH(\ENQR\CANlastIntervalFailureTasks\"\215\SOH\n\
    \\SOWorkerHostInfo\DC2\ESC\n\
    \\thost_name\CAN\SOH \SOH(\tR\bhostName\DC2\US\n\
    \\vprocess_key\CAN\ENQ \SOH(\tR\n\
    \processKey\DC2\GS\n\
    \\n\
    \process_id\CAN\STX \SOH(\tR\tprocessId\DC23\n\
    \\SYNcurrent_host_cpu_usage\CAN\ETX \SOH(\STXR\DC3currentHostCpuUsage\DC23\n\
    \\SYNcurrent_host_mem_usage\CAN\EOT \SOH(\STXR\DC3currentHostMemUsage\"\167\f\n\
    \\SIWorkerHeartbeat\DC2.\n\
    \\DC3worker_instance_key\CAN\SOH \SOH(\tR\DC1workerInstanceKey\DC2'\n\
    \\SIworker_identity\CAN\STX \SOH(\tR\SOworkerIdentity\DC2C\n\
    \\thost_info\CAN\ETX \SOH(\v2&.temporal.api.worker.v1.WorkerHostInfoR\bhostInfo\DC2\GS\n\
    \\n\
    \task_queue\CAN\EOT \SOH(\tR\ttaskQueue\DC2b\n\
    \\DC2deployment_version\CAN\ENQ \SOH(\v23.temporal.api.deployment.v1.WorkerDeploymentVersionR\DC1deploymentVersion\DC2\EM\n\
    \\bsdk_name\CAN\ACK \SOH(\tR\asdkName\DC2\US\n\
    \\vsdk_version\CAN\a \SOH(\tR\n\
    \sdkVersion\DC2;\n\
    \\ACKstatus\CAN\b \SOH(\SO2#.temporal.api.enums.v1.WorkerStatusR\ACKstatus\DC29\n\
    \\n\
    \start_time\CAN\t \SOH(\v2\SUB.google.protobuf.TimestampR\tstartTime\DC2A\n\
    \\SOheartbeat_time\CAN\n\
    \ \SOH(\v2\SUB.google.protobuf.TimestampR\rheartbeatTime\DC2Z\n\
    \\FSelapsed_since_last_heartbeat\CAN\v \SOH(\v2\EM.google.protobuf.DurationR\EMelapsedSinceLastHeartbeat\DC2`\n\
    \\CANworkflow_task_slots_info\CAN\f \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\NAKworkflowTaskSlotsInfo\DC2`\n\
    \\CANactivity_task_slots_info\CAN\r \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\NAKactivityTaskSlotsInfo\DC2Z\n\
    \\NAKnexus_task_slots_info\CAN\SO \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\DC2nexusTaskSlotsInfo\DC2b\n\
    \\EMlocal_activity_slots_info\CAN\SI \SOH(\v2'.temporal.api.worker.v1.WorkerSlotsInfoR\SYNlocalActivitySlotsInfo\DC2Z\n\
    \\DC4workflow_poller_info\CAN\DLE \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\DC2workflowPollerInfo\DC2g\n\
    \\ESCworkflow_sticky_poller_info\CAN\DC1 \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\CANworkflowStickyPollerInfo\DC2Z\n\
    \\DC4activity_poller_info\CAN\DC2 \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\DC2activityPollerInfo\DC2T\n\
    \\DC1nexus_poller_info\CAN\DC3 \SOH(\v2(.temporal.api.worker.v1.WorkerPollerInfoR\SInexusPollerInfo\DC23\n\
    \\SYNtotal_sticky_cache_hit\CAN\DC4 \SOH(\ENQR\DC3totalStickyCacheHit\DC25\n\
    \\ETBtotal_sticky_cache_miss\CAN\NAK \SOH(\ENQR\DC4totalStickyCacheMiss\DC29\n\
    \\EMcurrent_sticky_cache_size\CAN\SYN \SOH(\ENQR\SYNcurrentStickyCacheSize\"`\n\
    \\n\
    \WorkerInfo\DC2R\n\
    \\DLEworker_heartbeat\CAN\SOH \SOH(\v2'.temporal.api.worker.v1.WorkerHeartbeatR\SIworkerHeartbeatB\137\SOH\n\
    \\EMio.temporal.api.worker.v1B\fMessageProtoP\SOHZ#go.temporal.io/api/worker/v1;worker\170\STX\CANTemporalio.Api.Worker.V1\234\STX\ESCTemporalio::Api::Worker::V1J\237)\n\
    \\a\DC2\ENQ\NUL\NUL\133\SOH\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\US\n\
    \\b\n\
    \\SOH\b\DC2\ETX\EOT\NUL:\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\EOT\NUL:\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ENQ\NUL2\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ENQ\NUL2\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ACK\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\ACK\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\a\NUL-\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\a\NUL-\n\
    \\b\n\
    \\SOH\b\DC2\ETX\b\NUL4\n\
    \\t\n\
    \\STX\b-\DC2\ETX\b\NUL4\n\
    \\b\n\
    \\SOH\b\DC2\ETX\t\NUL5\n\
    \\t\n\
    \\STX\b%\DC2\ETX\t\NUL5\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\v\NUL(\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\f\NUL)\n\
    \\t\n\
    \\STX\ETX\STX\DC2\ETX\r\NUL2\n\
    \\t\n\
    \\STX\ETX\ETX\DC2\ETX\SO\NUL,\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\DLE\NUL\CAN\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\DLE\b\CAN\n\
    \C\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\DC2\STX\FS\SUB6 Number of polling RPCs that are currently in flight.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\DC2\STX\a\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\DC2\b\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\DC2\SUB\ESC\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\DC4\STX:\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ACK\DC2\ETX\DC4\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\DC4\FS5\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\DC489\n\
    \J\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\ETB\STX\SUB\SUB= Set true if the number of concurrent pollers is auto-scaled\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ENQ\DC2\ETX\ETB\STX\ACK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\ETB\a\NAK\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\ETB\CAN\EM\n\
    \\n\
    \\n\
    \\STX\EOT\SOH\DC2\EOT\SUB\NUL1\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\SUB\b\ETB\n\
    \v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\GS\STX$\SUBi Number of slots available for the worker to specific tasks.\n\
    \ May be -1 if the upper bound is not known.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\GS\STX\a\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\GS\b\US\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\GS\"#\n\
    \E\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\US\STX\US\SUB8 Number of slots used by the worker for specific tasks.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX\US\STX\a\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\US\b\SUB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\US\GS\RS\n\
    \\156\SOH\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX#\STX \SUB\142\SOH Kind of the slot supplier, which is used to determine how the slots are allocated.\n\
    \ Possible values: \"Fixed | ResourceBased | Custom String\"\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ENQ\DC2\ETX#\STX\b\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX#\t\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX#\RS\US\n\
    \\184\SOH\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX'\STX\"\SUB\170\SOH Total number of tasks processed (completed both successfully and unsuccesfully, or any other way)\n\
    \ by the worker since the worker started. This is a cumulative counter.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ENQ\DC2\ETX'\STX\a\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX'\b\GS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX' !\n\
    \K\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX)\STX\US\SUB> Total number of failed tasks processed by the worker so far.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ENQ\DC2\ETX)\STX\a\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX)\b\SUB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX)\GS\RS\n\
    \\222\SOH\n\
    \\EOT\EOT\SOH\STX\ENQ\DC2\ETX.\STX*\SUB\208\SOH Number of tasks processed in since the last heartbeat from the worker.\n\
    \ This is a cumulative counter, and it is reset to 0 each time the worker sends a heartbeat.\n\
    \ Contains both successful and failed tasks.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ENQ\DC2\ETX.\STX\a\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\SOH\DC2\ETX.\b%\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ETX\DC2\ETX.()\n\
    \Y\n\
    \\EOT\EOT\SOH\STX\ACK\DC2\ETX0\STX(\SUBL Number of failed tasks processed since the last heartbeat from the worker.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ENQ\DC2\ETX0\STX\a\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\SOH\DC2\ETX0\b#\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ACK\ETX\DC2\ETX0&'\n\
    \Q\n\
    \\STX\EOT\STX\DC2\EOT4\NULJ\SOH\SUBE Holds everything needed to identify the worker host/process context\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX4\b\SYN\n\
    \&\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX6\STX\ETB\SUB\EM Worker host identifier.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ENQ\DC2\ETX6\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX6\t\DC2\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX6\NAK\SYN\n\
    \\168\STX\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX>\STX\EM\SUB\154\STX Worker process identifier. This id should be unique for all _processes_\n\
    \ running workers in the namespace, and should be shared by all workers\n\
    \ in the same process.\n\
    \ This will be used to build the worker command nexus task queue name:\n\
    \ \"temporal-sys/worker-commands/{process_key}\"\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ENQ\DC2\ETX>\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX>\t\DC4\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX>\ETB\CAN\n\
    \\160\SOH\n\
    \\EOT\EOT\STX\STX\STX\DC2\ETXB\STX\CAN\SUB\146\SOH Worker process identifier. Unlike process_key, this id only needs to be unique\n\
    \ within one host (so using e.g. a unix pid would be appropriate).\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ENQ\DC2\ETXB\STX\b\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\SOH\DC2\ETXB\t\DC3\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\STX\ETX\DC2\ETXB\SYN\ETB\n\
    \x\n\
    \\EOT\EOT\STX\STX\ETX\DC2\ETXF\STX#\SUBk System used CPU as a float in the range [0.0, 1.0] where 1.0 is defined as all\n\
    \ cores on the host pegged.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ENQ\DC2\ETXF\STX\a\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\SOH\DC2\ETXF\b\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\ETX\ETX\DC2\ETXF!\"\n\
    \\135\SOH\n\
    \\EOT\EOT\STX\STX\EOT\DC2\ETXI\STX#\SUBz System used memory as a float in the range [0.0, 1.0] where 1.0 is defined as\n\
    \ all available memory on the host is used.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ENQ\DC2\ETXI\STX\a\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\SOH\DC2\ETXI\b\RS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\EOT\ETX\DC2\ETXI!\"\n\
    \\147\STX\n\
    \\STX\EOT\ETX\DC2\ENQP\NUL\129\SOH\SOH\SUB\133\STX Worker info message, contains information about the worker and its current state.\n\
    \ All information is provided by the worker itself.\n\
    \ (-- api-linter: core::0140::prepositions=disabled\n\
    \     aip.dev/not-precedent: Removing those words make names less clear. --)\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETXP\b\ETB\n\
    \\151\SOH\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETXS\STX!\SUB\137\SOH Worker identifier, should be unique for the namespace.\n\
    \ It is distinct from worker identity, which is not necessarily namespace-unique.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ENQ\DC2\ETXS\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETXS\t\FS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETXS\US \n\
    \\155\SOH\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETXW\STX\GS\SUB\141\SOH Worker identity, set by the client, may not be unique.\n\
    \ Usually host_name+(user group name)+process_id, but can be overwritten by the user.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ENQ\DC2\ETXW\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETXW\t\CAN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETXW\ESC\FS\n\
    \'\n\
    \\EOT\EOT\ETX\STX\STX\DC2\ETXZ\STX\US\SUB\SUB Worker host information.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ACK\DC2\ETXZ\STX\DLE\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\SOH\DC2\ETXZ\DC1\SUB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\STX\ETX\DC2\ETXZ\GS\RS\n\
    \;\n\
    \\EOT\EOT\ETX\STX\ETX\DC2\ETX]\STX\CAN\SUB. Task queue this worker is polling for tasks.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ENQ\DC2\ETX]\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\SOH\DC2\ETX]\t\DC3\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ETX\ETX\DC2\ETX]\SYN\ETB\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\EOT\DC2\ETX_\STXL\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ACK\DC2\ETX_\STX4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\SOH\DC2\ETX_5G\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\EOT\ETX\DC2\ETX_JK\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\ENQ\DC2\ETXa\STX\SYN\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\ENQ\DC2\ETXa\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\SOH\DC2\ETXa\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ENQ\ETX\DC2\ETXa\DC4\NAK\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\ACK\DC2\ETXb\STX\EM\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ACK\ENQ\DC2\ETXb\STX\b\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ACK\SOH\DC2\ETXb\t\DC4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\ACK\ETX\DC2\ETXb\ETB\CAN\n\
    \-\n\
    \\EOT\EOT\ETX\STX\a\DC2\ETXe\STX0\SUB  Worker status. Defined by SDK.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\a\ACK\DC2\ETXe\STX$\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\a\SOH\DC2\ETXe%+\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\a\ETX\DC2\ETXe./\n\
    \i\n\
    \\EOT\EOT\ETX\STX\b\DC2\ETXi\STX+\SUB\\ Worker start time.\n\
    \ It can be used to determine worker uptime. (current time - start time)\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\b\ACK\DC2\ETXi\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\b\SOH\DC2\ETXi\FS&\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\b\ETX\DC2\ETXi)*\n\
    \\195\SOH\n\
    \\EOT\EOT\ETX\STX\t\DC2\ETXm\STX0\SUB\181\SOH Timestamp of this heartbeat, coming from the worker. Worker should set it to \"now\".\n\
    \ Note that this timestamp comes directly from the worker and is subject to workers' clock skew.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\t\ACK\DC2\ETXm\STX\ESC\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\t\SOH\DC2\ETXm\FS*\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\t\ETX\DC2\ETXm-/\n\
    \E\n\
    \\EOT\EOT\ETX\STX\n\
    \\DC2\ETXo\STX=\SUB8 Elapsed time since the last heartbeat from the worker.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\n\
    \\ACK\DC2\ETXo\STX\SUB\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\n\
    \\SOH\DC2\ETXo\ESC7\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\n\
    \\ETX\DC2\ETXo:<\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\v\DC2\ETXq\STX0\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\v\ACK\DC2\ETXq\STX\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\v\SOH\DC2\ETXq\DC2*\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\v\ETX\DC2\ETXq-/\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\f\DC2\ETXr\STX0\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\f\ACK\DC2\ETXr\STX\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\f\SOH\DC2\ETXr\DC2*\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\f\ETX\DC2\ETXr-/\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\r\DC2\ETXs\STX-\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\r\ACK\DC2\ETXs\STX\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\r\SOH\DC2\ETXs\DC2'\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\r\ETX\DC2\ETXs*,\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SO\DC2\ETXt\STX1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SO\ACK\DC2\ETXt\STX\DC1\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SO\SOH\DC2\ETXt\DC2+\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SO\ETX\DC2\ETXt.0\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SI\DC2\ETXv\STX-\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SI\ACK\DC2\ETXv\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SI\SOH\DC2\ETXv\DC3'\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SI\ETX\DC2\ETXv*,\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\DLE\DC2\ETXw\STX4\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DLE\ACK\DC2\ETXw\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DLE\SOH\DC2\ETXw\DC3.\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DLE\ETX\DC2\ETXw13\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\DC1\DC2\ETXx\STX-\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC1\ACK\DC2\ETXx\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC1\SOH\DC2\ETXx\DC3'\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC1\ETX\DC2\ETXx*,\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\DC2\DC2\ETXy\STX*\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC2\ACK\DC2\ETXy\STX\DC2\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC2\SOH\DC2\ETXy\DC3$\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC2\ETX\DC2\ETXy')\n\
    \P\n\
    \\EOT\EOT\ETX\STX\DC3\DC2\ETX|\STX$\SUBC A Workflow Task found a cached Workflow Execution to run against.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC3\ENQ\DC2\ETX|\STX\a\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC3\SOH\DC2\ETX|\b\RS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC3\ETX\DC2\ETX|!#\n\
    \W\n\
    \\EOT\EOT\ETX\STX\DC4\DC2\ETX~\STX%\SUBJ A Workflow Task did not find a cached Workflow execution to run against.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC4\ENQ\DC2\ETX~\STX\a\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC4\SOH\DC2\ETX~\b\US\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\DC4\ETX\DC2\ETX~\"$\n\
    \O\n\
    \\EOT\EOT\ETX\STX\NAK\DC2\EOT\128\SOH\STX'\SUBA Current cache size, expressed in number of Workflow Executions.\n\
    \\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NAK\ENQ\DC2\EOT\128\SOH\STX\a\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NAK\SOH\DC2\EOT\128\SOH\b!\n\
    \\r\n\
    \\ENQ\EOT\ETX\STX\NAK\ETX\DC2\EOT\128\SOH$&\n\
    \\f\n\
    \\STX\EOT\EOT\DC2\ACK\131\SOH\NUL\133\SOH\SOH\n\
    \\v\n\
    \\ETX\EOT\EOT\SOH\DC2\EOT\131\SOH\b\DC2\n\
    \\f\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\EOT\132\SOH\STX'\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\EOT\132\SOH\STX\DC1\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\EOT\132\SOH\DC2\"\n\
    \\r\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\EOT\132\SOH%&b\ACKproto3"