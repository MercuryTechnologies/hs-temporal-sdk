module Temporal.Workflow.CommandQueue where

import Control.Concurrent.STM
import Proto.Temporal.Sdk.Core.WorkflowCommands.WorkflowCommands (WorkflowCommand)


class HasCommandQueue a where
  getCommandQueue :: a -> CommandQueue


instance HasCommandQueue CommandQueue where
  getCommandQueue = id


data CommandQueue = CommandQueue
  { commandQueue :: {-# UNPACK #-} !(TQueue WorkflowCommand)
  , commandQueuePushback :: {-# UNPACK #-} !(TVar [WorkflowCommand])
  -- ^ Sometimes we have a lot of commands to send, and they exceed
  -- the gRPC body size limit. We can use this to push back commands
  -- that haven't been sent yet.
  }


newCommandQueue :: STM CommandQueue
newCommandQueue = CommandQueue <$> newTQueue <*> newTVar []


addCommand :: HasCommandQueue a => a -> WorkflowCommand -> STM ()
addCommand runtime command = do
  writeTQueue (getCommandQueue runtime).commandQueue command


pushbackCommands :: HasCommandQueue a => a -> [WorkflowCommand] -> STM ()
pushbackCommands q remainder = do
  writeTVar (getCommandQueue q).commandQueuePushback remainder


getCommands :: HasCommandQueue a => a -> STM [WorkflowCommand]
getCommands runtime = do
  let q = getCommandQueue runtime
  commands <- readTVar q.commandQueuePushback
  writeTVar q.commandQueuePushback []
  remainder <- flushTQueue q.commandQueue
  pure (commands <> remainder)
