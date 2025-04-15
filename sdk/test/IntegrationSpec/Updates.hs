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


-- - Happy path update:
-- - Workflow that throws an exception
-- - Malformed inputs/payloads
-- - Workflow canceled while running update (see ts-sdk's handling)
-- - Workflow exits while running update (see ts-sdk's handling)
-- - Interceptors
--
-- - Client:
--   - Making sure we throw the right exceptions
--   - Interceptors are being run on the client
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
        stateAfter
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
  let handleUpdate _ = do
        $(logDebug) "we're about to throw!"
        error "we're blowing up"
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
        stateAfter <- readStateVar stateVar
        $(logWarn) ("Called handleUpdate, new state is " <> T.pack (show stateAfter))
        pure stateAfter
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
        stateAfter <- readStateVar stateVar
        $(logWarn) ("Called handleUpdate, new state is " <> T.pack (show stateAfter))
        pure stateAfter
  setUpdateHandler testUpdate handleUpdate Nothing
  waitCondition do
    x <- readStateVar stateVar
    pure $ x > 0
  readStateVar stateVar


registerWorkflow 'updateWithValidatorThatSleeps
