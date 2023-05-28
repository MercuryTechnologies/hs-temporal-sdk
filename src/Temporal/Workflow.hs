module Temporal.Workflow 
  ( Workflow
  -- , execWorkflow
  -- , continueAsNew
  -- , deprecatePatch
  -- , executeActivity
  -- , executeChildWorkflow
  -- , executeLocalActivity
  -- , info
  -- , memo
  -- , memoValue
  -- , now
  -- , patched
  -- , query
  -- , random
  -- , setDynamicQueryHandler
  -- , setDynamicSignalHandler
  -- , setQueryHandler
  -- , setSignalHandler
  -- , signal
  -- , startActivity
  -- , startChildWorkflow
  -- , time
  -- , timeNanoseconds
  -- , upsertSearchAttributes
  -- , uuid4
  -- , waitCondition
  ) where

import Control.Monad.Reader
import Control.Monad.IO.Class
import Data.IORef
import Data.Map.Strict (Map)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import Data.Word (Word32)
import Data.Vector (Vector)
import Proto.Temporal.Api.Common.V1.Message (Payload)
import Temporal.Workflow.Unsafe

-- continueAsNew :: () -> Workflow env ()
-- continueAsNew = undefined

-- deprecatePatch :: () -> Workflow env ()
-- deprecatePatch = undefined

-- executeActivity :: () -> Workflow env ()
-- executeActivity = undefined

-- executeChildWorkflow :: () -> Workflow env ()
-- executeChildWorkflow = undefined

-- executeLocalActivity :: () -> Workflow env ()
-- executeLocalActivity = undefined

-- {-
-- Function	get_dynamic_query_handler	Get the dynamic query handler if any.
-- Function	get_dynamic_signal_handler	Get the dynamic signal handler if any.
-- Function	get_external_workflow_handle	Get a workflow handle to an existing workflow by its ID.
-- Function	get_external_workflow_handle_for	Get a typed workflow handle to an existing workflow by its ID.
-- Function	get_query_handler	Get the query handler for the given name if any.
-- Function	get_signal_handler	Get the signal handler for the given name if any.
-- -}

-- info :: () -> Workflow env ()
-- info = undefined

-- memo :: () -> Workflow env ()
-- memo = undefined

-- memoValue :: () -> Workflow env ()
-- memoValue = undefined

-- now :: () -> Workflow env ()
-- now = undefined

-- patched :: () -> Workflow env ()
-- patched = undefined

-- query :: () -> Workflow env ()
-- query = undefined

-- random :: () -> Workflow env ()
-- random = undefined

-- setDynamicQueryHandler :: () -> Workflow env ()
-- setDynamicQueryHandler = undefined

-- setDynamicSignalHandler :: () -> Workflow env ()
-- setDynamicSignalHandler = undefined

-- setQueryHandler :: () -> Workflow env ()
-- setQueryHandler = undefined

-- setSignalHandler :: () -> Workflow env ()
-- setSignalHandler = undefined

-- signal :: () -> Workflow env ()
-- signal = undefined

-- startActivity :: () -> Workflow env ()
-- startActivity = undefined

-- startChildWorkflow :: () -> Workflow env ()
-- startChildWorkflow = undefined

-- time :: () -> Workflow env ()
-- time = undefined

-- timeNanoseconds :: () -> Workflow env ()
-- timeNanoseconds = undefined

-- upsertSearchAttributes :: () -> Workflow env ()
-- upsertSearchAttributes = undefined

-- uuid4 :: () -> Workflow env ()
-- uuid4 = undefined

-- waitCondition :: () -> Workflow env ()
-- waitCondition = undefined

