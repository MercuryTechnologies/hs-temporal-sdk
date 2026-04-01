{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE GADTs #-}

{- | Typed Nexus service and operation definitions.

This module provides value-level builders for defining Nexus services
with typed inputs and outputs, analogous to how 'provideWorkflow' and
'provideActivity' work for workflows and activities.

@
(echoDef, echoRef) = syncOperation JSON "echo" $ \\(req :: EchoRequest) ->
  pure $ EchoResponse { echoedMessage = req.message }

myService :: NexusServiceHandler env
myService = buildService
  $ register echoDef
  $ nexusService "my-service"
@
-}
module Temporal.Nexus (
  -- * Typed operation constructors
  syncOperation,
  workflowRunOperation,

  -- * Service builder
  NexusServiceBuilder,
  nexusService,
  register,
  buildService,

  -- * Handler monad and context
  NexusHandler,
  runNexusHandler,
  NexusHandlerEnv (..),
  askNexusOperationContext,
  askNexusClient,
  askNexusPayloadProcessor,
  NexusOperationInfo (..),

  -- * Re-exports from Temporal.Nexus.Types
  KnownNexusOperation (..),
  NexusOperationDefinition (..),
  NexusLink (..),
  NexusStartInput (..),
  NexusStartResult (..),
  NexusCancelInput (..),
  NexusHandlerError (..),

  -- * Async operation token
  NexusOperationToken (..),
  WorkflowRunOperationToken (..),
  generateWorkflowRunOperationToken,
  loadWorkflowRunOperationToken,

  -- * Link conversion
  WorkflowEventLink (..),
  WorkflowEventReference (..),
  EventReference (..),
  RequestIdReference (..),
  nexusLinkToWorkflowEventLink,
  workflowEventLinkToNexusLink,
  eventTypeToPascalCase,
  eventTypeToConstantCase,

  -- * Workflow start helper
  nexusStartWorkflow,
  NexusStartWorkflowResult (..),

  -- * Re-exports from Temporal.Nexus.Worker (raw escape hatch)
  NexusServiceHandler (..),
  NexusOperationHandler (..),
) where

import Control.Monad (when)
import Control.Monad.Catch (throwM)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Reader (runReaderT)
import qualified Data.Bifunctor
import qualified Data.ByteString as BS
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Text as T
import qualified Data.Vector as V
import qualified Temporal.Client as Client
import Temporal.Client.Types (NexusCompletionCallback (..), StartWorkflowOptions (..), WorkflowLink (..))
import Temporal.Common
import Temporal.Nexus.Types
import Temporal.Nexus.Worker (NexusOperationHandler (..), NexusServiceHandler (..))
import Temporal.Payload
import Temporal.Workflow.Definition (KnownWorkflow (..), WorkflowRef (..))


{- | Define a synchronous Nexus operation with typed input and output.

The handler runs in 'NexusHandler', giving access to logging, the Temporal
client, and the user environment. Use 'askNexusOperationContext' for request
metadata (request ID, headers, links). Use 'askNexusClient' for a
'WorkflowClient' to start workflows or call other Temporal APIs.

Returns both a handler definition (for the service builder) and a typed
reference (for callers).

@
(echoDef, echoRef) = syncOperation JSON "echo" $ \\req ->
  pure $ EchoResponse { echoedMessage = req.message }
@
-}
syncOperation
  :: forall codec env input output
   . (Codec codec input, Codec codec output)
  => codec
  -> NexusOperationName
  -> (input -> NexusHandler env output)
  -> (NexusOperationDefinition env, KnownNexusOperation input output)
syncOperation codec opName handler =
  ( NexusOperationDefinition
      { nexusOpName = opName
      , nexusOpStartHandler = \startInput -> do
          case startInput.startInputPayload of
            Nothing -> pure $ NexusStartError $ badRequestError "missing payload"
            Just payload -> do
              decoded <- liftIO $ decode codec payload
              case decoded of
                Left err -> pure $ NexusStartError $ badRequestError ("failed to decode input: " <> T.pack err)
                Right input -> do
                  output <- handler input
                  resultPayload <- liftIO $ encode codec output
                  pure $ NexusSyncSuccess resultPayload []
      , nexusOpCancelHandler = Nothing
      }
  , KnownNexusOperation
      { knownNexusOperationCodec = codec
      , knownNexusOperationName = opName
      }
  )


{- | Define a workflow-backed async Nexus operation with typed input and output.

The start handler runs in 'NexusHandler'. Use 'askNexusOperationContext' to
access the request ID (stable across retries — use it as the workflow ID for
idempotent starts) and 'askNexusClient' for the 'WorkflowClient'.

Use 'generateWorkflowRunOperationToken' to create a structured operation
token from the namespace and workflow ID.

@
(transferDef, transferRef) = workflowRunOperation JSON "transfer"
  (\\req -> do
    ctx <- askNexusOperationContext
    wfClient <- askNexusClient
    let wfId = WorkflowId ctx.nexusOpInfoRequestId
    _ <- liftIO $ C.start wfClient transferWorkflow wfId opts req
    pure $ generateWorkflowRunOperationToken ctx.nexusOpInfoNamespace wfId
  )
  (Just $ \\token -> do
    wfClient <- askNexusClient
    let decoded = loadWorkflowRunOperationToken token
    liftIO $ cancelWorkflow wfClient (WorkflowId decoded.tokenWorkflowId)
  )
@

Note: The built-in cancel wrapper already validates the token and checks that
the token namespace matches the worker namespace before calling your handler.
If validation fails, it throws a NOT_FOUND 'NexusHandlerError'.
-}
workflowRunOperation
  :: forall codec env input output
   . (Codec codec input, Codec codec output)
  => codec
  -> NexusOperationName
  -> (input -> NexusHandler env NexusOperationToken)
  -> Maybe (NexusOperationToken -> NexusHandler env ())
  -> (NexusOperationDefinition env, KnownNexusOperation input output)
workflowRunOperation codec opName startWorkflow mCancelWorkflow =
  ( NexusOperationDefinition
      { nexusOpName = opName
      , nexusOpStartHandler = \startInput -> do
          case startInput.startInputPayload of
            Nothing -> pure $ NexusStartError $ badRequestError "missing payload"
            Just payload -> do
              decoded <- liftIO $ decode codec payload
              case decoded of
                Left err -> pure $ NexusStartError $ badRequestError ("failed to decode input: " <> T.pack err)
                Right input -> do
                  token <- startWorkflow input
                  pure $ NexusAsyncStarted token []
      , nexusOpCancelHandler = fmap wrapCancel mCancelWorkflow
      }
  , KnownNexusOperation
      { knownNexusOperationCodec = codec
      , knownNexusOperationName = opName
      }
  )
  where
    wrapCancel cancel cancelInput = do
      let rawToken = NexusOperationToken cancelInput.cancelInputOperationToken
      case loadWorkflowRunOperationToken rawToken of
        Left err -> throwM $ notFoundError ("invalid operation token: " <> err)
        Right decoded -> do
          ctx <- askNexusOperationContext
          let workerNs = rawNamespace ctx.nexusOpInfoNamespace
          when (decoded.tokenNamespace /= workerNs) $
            throwM $
              notFoundError ("token namespace " <> decoded.tokenNamespace <> " does not match worker namespace " <> workerNs)
          cancel rawToken


{- | A service being assembled. Use 'nexusService' to create one, 'register'
to add operations, and 'buildService' to finalize.
-}
data NexusServiceBuilder env = NexusServiceBuilder
  { nsbServiceName :: !NexusServiceName
  , nsbOperations :: ![(NexusOperationName, NexusOperationDefinition env)]
  }


-- | Start building a new Nexus service with the given name.
nexusService :: NexusServiceName -> NexusServiceBuilder env
nexusService name = NexusServiceBuilder name []


-- | Register a typed operation definition in the service builder.
register :: NexusOperationDefinition env -> NexusServiceBuilder env -> NexusServiceBuilder env
register def builder = builder {nsbOperations = (def.nexusOpName, def) : builder.nsbOperations}


{- | Convert a service builder into a 'NexusServiceHandler' suitable for
'Temporal.Worker.addNexusServiceHandler'.

Each 'NexusOperationDefinition' is wrapped into a 'NexusOperationHandler'.
Proto conversion and interceptor application are handled by the dispatch
loop in 'Temporal.Nexus.Worker', not here.
-}
buildService :: NexusServiceBuilder env -> NexusServiceHandler env
buildService builder =
  NexusServiceHandler
    { serviceName = rawNexusServiceName builder.nsbServiceName
    , operations = HashMap.fromList $ fmap (Data.Bifunctor.bimap rawNexusOperationName wrapDefinition) builder.nsbOperations
    }


wrapDefinition :: NexusOperationDefinition env -> NexusOperationHandler env
wrapDefinition def =
  NexusOperationHandler
    { handleStartOperation = def.nexusOpStartHandler
    , handleCancelOperation = def.nexusOpCancelHandler
    }


badRequestError :: T.Text -> NexusHandlerError
badRequestError msg =
  NexusHandlerError
    { errorType = "BAD_REQUEST"
    , message = msg
    , retryable = False
    , failureMetadata = mempty
    , failureDetails = BS.empty
    }


notFoundError :: T.Text -> NexusHandlerError
notFoundError msg =
  NexusHandlerError
    { errorType = "NOT_FOUND"
    , message = msg
    , retryable = False
    , failureMetadata = mempty
    , failureDetails = BS.empty
    }


{- | Result of 'nexusStartWorkflow', containing the operation token and
back-links to the started workflow for inclusion in the Nexus response.
-}
data NexusStartWorkflowResult = NexusStartWorkflowResult
  { nexusToken :: !NexusOperationToken
  , nexusResponseLinks :: ![NexusLink]
  }
  deriving stock (Show)


{- | Start a workflow as the backing implementation of an async Nexus operation.

Automatically wires Nexus metadata so that the Temporal UI and server can
correlate the Nexus operation with the underlying workflow:

1. Uses the Nexus @requestId@ as the workflow ID for idempotent dedup.
2. Converts inbound Nexus links to proto workflow links.
3. Sets completion callbacks from the Nexus callback URL\/headers.
4. Sets @workflowIdConflictPolicy = UseExisting@ so retries reuse the
   same workflow rather than failing.
5. Returns a structured 'NexusOperationToken' and back-links pointing
   to the started workflow.

@
(transferDef, transferRef) = workflowRunOperation JSON "transfer"
  (\\req -> do
    result <- nexusStartWorkflow transferWorkflow opts req
    pure result.nexusToken
  )
  Nothing
@
-}
nexusStartWorkflow
  :: forall args result env
   . ()
  => KnownWorkflow args result
  -> StartWorkflowOptions
  -> V.Vector Payload
  -> NexusHandler env NexusStartWorkflowResult
nexusStartWorkflow k opts encodedInputs = do
  ctx <- askNexusOperationContext
  wfClient <- askNexusClient
  let wfId = WorkflowId ctx.nexusOpInfoRequestId

      nexusCallback =
        NexusCompletionCallback
          { callbackUrl = ctx.nexusOpInfoCallbackUrl
          , callbackHeaders = ctx.nexusOpInfoCallbackHeaders
          }

      inboundWorkflowLinks = V.mapMaybe convertNexusLink ctx.nexusOpInfoLinks

      opts' =
        opts
          { workflowIdConflictPolicy = Just WorkflowIdConflictPolicyUseExisting
          }

  wfHandle <-
    liftIO $
      runReaderT
        (Client.startFromPayloadsForNexus k wfId opts' (fmap pure encodedInputs) (V.singleton nexusCallback) inboundWorkflowLinks)
        wfClient
  let ns = ctx.nexusOpInfoNamespace
      token = generateWorkflowRunOperationToken ns wfId
      -- TODO: Use server-provided links from StartWorkflowExecutionResponse
      -- when available (newer servers include them). For now, always construct
      -- the back-link manually, matching Python/TS SDK behavior.
      backLink =
        workflowEventLinkToNexusLink
          WorkflowEventLink
            { welNamespace = rawNamespace ns
            , welWorkflowId = rawWorkflowId wfId
            , welRunId = maybe "" rawRunId (Client.workflowHandleRunId wfHandle)
            , welReference =
                Just $
                  WelRequestIdRef $
                    RequestIdReference
                      { requestIdRefRequestId = ctx.nexusOpInfoRequestId
                      , requestIdRefEventType = "WorkflowExecutionStarted"
                      }
            }
  pure
    NexusStartWorkflowResult
      { nexusToken = token
      , nexusResponseLinks = [backLink]
      }
  where
    convertNexusLink nl = case nexusLinkToWorkflowEventLink nl of
      Left _ -> Nothing
      Right wel ->
        Just
          WorkflowLink
            { linkNamespace = wel.welNamespace
            , linkWorkflowId = wel.welWorkflowId
            , linkRunId = wel.welRunId
            }
