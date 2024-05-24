module Temporal.Client.AsyncActivity where

import Control.Exception
import Temporal.Common
import Temporal.Core.Client
import Temporal.Payload


---------------------------------------------------------------------------------
-- AsyncCompletionClient

-- | A client for asynchronous completion and heartbeating of Activities.
data AsyncCompletionClient = AsyncCompletionClient Client


complete :: AsyncCompletionClient -> TaskToken -> m ()
complete = undefined


fail :: AsyncCompletionClient -> TaskToken -> SomeException -> m ()
fail = undefined


heartbeat :: AsyncCompletionClient -> TaskToken -> [Payload] -> m ()
heartbeat = undefined


reportCancellation :: AsyncCompletionClient -> TaskToken -> [Payload] -> m ()
reportCancellation = undefined
