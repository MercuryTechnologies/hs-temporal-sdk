{- This file was auto-generated from temporal/api/testservice/v1/service.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Temporal.Api.Testservice.V1.Service (
        TestService(..)
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
import qualified Proto.Google.Protobuf.Empty
import qualified Proto.Temporal.Api.Testservice.V1.RequestResponse
data TestService = TestService {}
instance Data.ProtoLens.Service.Types.Service TestService where
  type ServiceName TestService = "TestService"
  type ServicePackage TestService = "temporal.api.testservice.v1"
  type ServiceMethods TestService = '["getCurrentTime",
                                      "lockTimeSkipping",
                                      "sleep",
                                      "sleepUntil",
                                      "unlockTimeSkipping",
                                      "unlockTimeSkippingWithSleep"]
  packedServiceDescriptor _
    = "\n\
      \\vTestService\DC2\129\SOH\n\
      \\DLELockTimeSkipping\DC24.temporal.api.testservice.v1.LockTimeSkippingRequest\SUB5.temporal.api.testservice.v1.LockTimeSkippingResponse\"\NUL\DC2\135\SOH\n\
      \\DC2UnlockTimeSkipping\DC26.temporal.api.testservice.v1.UnlockTimeSkippingRequest\SUB7.temporal.api.testservice.v1.UnlockTimeSkippingResponse\"\NUL\DC2`\n\
      \\ENQSleep\DC2).temporal.api.testservice.v1.SleepRequest\SUB*.temporal.api.testservice.v1.SleepResponse\"\NUL\DC2j\n\
      \\n\
      \SleepUntil\DC2..temporal.api.testservice.v1.SleepUntilRequest\SUB*.temporal.api.testservice.v1.SleepResponse\"\NUL\DC2v\n\
      \\ESCUnlockTimeSkippingWithSleep\DC2).temporal.api.testservice.v1.SleepRequest\SUB*.temporal.api.testservice.v1.SleepResponse\"\NUL\DC2_\n\
      \\SOGetCurrentTime\DC2\SYN.google.protobuf.Empty\SUB3.temporal.api.testservice.v1.GetCurrentTimeResponse\"\NUL"
instance Data.ProtoLens.Service.Types.HasMethodImpl TestService "lockTimeSkipping" where
  type MethodName TestService "lockTimeSkipping" = "LockTimeSkipping"
  type MethodInput TestService "lockTimeSkipping" = Proto.Temporal.Api.Testservice.V1.RequestResponse.LockTimeSkippingRequest
  type MethodOutput TestService "lockTimeSkipping" = Proto.Temporal.Api.Testservice.V1.RequestResponse.LockTimeSkippingResponse
  type MethodStreamingType TestService "lockTimeSkipping" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl TestService "unlockTimeSkipping" where
  type MethodName TestService "unlockTimeSkipping" = "UnlockTimeSkipping"
  type MethodInput TestService "unlockTimeSkipping" = Proto.Temporal.Api.Testservice.V1.RequestResponse.UnlockTimeSkippingRequest
  type MethodOutput TestService "unlockTimeSkipping" = Proto.Temporal.Api.Testservice.V1.RequestResponse.UnlockTimeSkippingResponse
  type MethodStreamingType TestService "unlockTimeSkipping" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl TestService "sleep" where
  type MethodName TestService "sleep" = "Sleep"
  type MethodInput TestService "sleep" = Proto.Temporal.Api.Testservice.V1.RequestResponse.SleepRequest
  type MethodOutput TestService "sleep" = Proto.Temporal.Api.Testservice.V1.RequestResponse.SleepResponse
  type MethodStreamingType TestService "sleep" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl TestService "sleepUntil" where
  type MethodName TestService "sleepUntil" = "SleepUntil"
  type MethodInput TestService "sleepUntil" = Proto.Temporal.Api.Testservice.V1.RequestResponse.SleepUntilRequest
  type MethodOutput TestService "sleepUntil" = Proto.Temporal.Api.Testservice.V1.RequestResponse.SleepResponse
  type MethodStreamingType TestService "sleepUntil" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl TestService "unlockTimeSkippingWithSleep" where
  type MethodName TestService "unlockTimeSkippingWithSleep" = "UnlockTimeSkippingWithSleep"
  type MethodInput TestService "unlockTimeSkippingWithSleep" = Proto.Temporal.Api.Testservice.V1.RequestResponse.SleepRequest
  type MethodOutput TestService "unlockTimeSkippingWithSleep" = Proto.Temporal.Api.Testservice.V1.RequestResponse.SleepResponse
  type MethodStreamingType TestService "unlockTimeSkippingWithSleep" = 'Data.ProtoLens.Service.Types.NonStreaming
instance Data.ProtoLens.Service.Types.HasMethodImpl TestService "getCurrentTime" where
  type MethodName TestService "getCurrentTime" = "GetCurrentTime"
  type MethodInput TestService "getCurrentTime" = Proto.Google.Protobuf.Empty.Empty
  type MethodOutput TestService "getCurrentTime" = Proto.Temporal.Api.Testservice.V1.RequestResponse.GetCurrentTimeResponse
  type MethodStreamingType TestService "getCurrentTime" = 'Data.ProtoLens.Service.Types.NonStreaming