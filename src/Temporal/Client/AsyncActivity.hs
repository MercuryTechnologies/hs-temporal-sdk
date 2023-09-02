module Temporal.Client.AsyncActivity where

---------------------------------------------------------------------------------
-- AsyncCompletionClient

-- | A client for asynchronous completion and heartbeating of Activities.
data AsyncCompletionClient = AsyncCompletionClient Client

complete :: AsyncCompletionClient -> TaskToken -> m ()
complete = undefined

fail :: AsyncCompletionClient -> TaskToken -> SomeException -> m ()
fail = undefined

heartbeat :: AsyncCompletionClient -> TaskToken -> [RawPayload] -> m ()
heartbeat = undefined

reportCancellation :: AsyncCompletionClient -> TaskToken -> [RawPayload] -> m ()
reportCancellation = undefined
