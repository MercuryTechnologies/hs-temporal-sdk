{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.Updates where

import Control.Exception
import Control.Monad
import Control.Monad.Catch
import Control.Monad.Logger
import qualified Data.Text as T
import RequireCallStack (provideCallStack)
import System.IO.Unsafe (unsafePerformIO)
import Temporal.Activity
import Temporal.Client
import Temporal.Duration
import Temporal.Payload
import Temporal.TH
import Temporal.Workflow
import Temporal.Workflow.Update


-- - Workflow that throws an exception
--   - If it throws before the update, the update shouldn't run
--   - If it throws after, the update shouldn't be effected (it already ran)
-- - Punting a little bit:
--   - Workflow canceled while running update (see ts-sdk's handling)
--   - Workflow exits while running update (see ts-sdk's handling)
--   - We'll want to use the resource management work that Ian has in progress
--
-- - Client interceptors:
--   - Are run
--   - Expected args
--   - Right order
--   - Propogate whatever exc an interceptor throws
--
-- - Ideas:
--   - Start vs execute semantics for update

testUpdate :: KnownUpdate '[Int] Int SomeException
testUpdate =
  KnownUpdate
    { knownUpdateCodec = JSON
    , knownUpdateName = "test-update"
    }


updateWithoutValidator :: Workflow Int
updateWithoutValidator = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate arg = do
        modifyStateVar stateVar (+ arg)
        readStateVar stateVar
  setUpdateHandler testUpdate handleUpdate Nothing
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'updateWithoutValidator


updateWithValidator :: Workflow Int
updateWithValidator = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate arg = do
        modifyStateVar stateVar (+ arg)
        readStateVar stateVar
  let validateUpdate arg = do
        val <- readStateVar stateVar
        when
          (arg == 5)
          (error "5 is the WORST number")
        if arg + val >= 0
          then pure $ Right ()
          else pure $ Left $ toException $ ErrorCall "in a bad state!!!"
  setUpdateHandler testUpdate handleUpdate $ Just validateUpdate
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'updateWithValidator


updateThatThrows :: Workflow Int
updateThatThrows = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate _ = error "we're blowing up"
  setUpdateHandler testUpdate handleUpdate Nothing
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'updateThatThrows


updateWithValidatorThatThrows :: Workflow Int
updateWithValidatorThatThrows = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate arg = do
        modifyStateVar stateVar (+ arg)
        readStateVar stateVar
  let validateUpdate _ = error "validator blowing up!"
  setUpdateHandler testUpdate handleUpdate $ Just validateUpdate
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'updateWithValidatorThatThrows


updateWithValidatorThatSleeps :: Workflow Int
updateWithValidatorThatSleeps = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate arg = do
        sleep $ seconds 1
        modifyStateVar stateVar (+ arg)
        readStateVar stateVar
  setUpdateHandler testUpdate handleUpdate Nothing
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'updateWithValidatorThatSleeps


workflowThatThrowsBeforeTheUpdate :: Workflow Int
workflowThatThrowsBeforeTheUpdate = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate arg = do
        modifyStateVar stateVar (+ arg)
        readStateVar stateVar
  setUpdateHandler testUpdate handleUpdate Nothing
  x <- readStateVar stateVar
  error ("Current state var: " <> show x)
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'workflowThatThrowsBeforeTheUpdate


workflowThatThrowsAfterTheUpdate :: Workflow Int
workflowThatThrowsAfterTheUpdate = provideCallStack do
  stateVar <- newStateVar (0 :: Int)
  let handleUpdate arg = do
        modifyStateVar stateVar (+ arg)
        readStateVar stateVar
  setUpdateHandler testUpdate handleUpdate Nothing
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  x <- readStateVar stateVar
  error ("Current state var: " <> show x)
  readStateVar stateVar


registerWorkflow 'workflowThatThrowsAfterTheUpdate
