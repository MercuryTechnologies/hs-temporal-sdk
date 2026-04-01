{-# LANGUAGE CPP #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE GADTs #-}

module Temporal.Nexus.Types (
  -- * Typed operation references
  KnownNexusOperation (..),

  -- * Handler monad
  NexusHandler (..),
  runNexusHandler,
  NexusHandlerEnv (..),

  -- * Handler context accessors
  askNexusOperationContext,
  askNexusClient,
  askNexusPayloadProcessor,

  -- * Handler context
  NexusOperationInfo (..),
  NexusLink (..),

  -- * Operation handler types
  NexusOperationDefinition (..),
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

  -- * Event type format conversion
  eventTypeToPascalCase,
  eventTypeToConstantCase,
) where

import Control.Applicative
import Control.Monad
import Control.Monad.Catch
import Control.Monad.Fix
import Control.Monad.Logger (Loc, LogLevel, LogSource, LogStr, MonadLogger (..), MonadLoggerIO (..), ToLogStr (..))
import Control.Monad.Reader
import Data.Aeson (FromJSON (..), ToJSON (..), (.:), (.:?), (.=))
import qualified Data.Aeson as Aeson
import Data.Aeson.Types (camelTo2)
#if MIN_VERSION_base64(1,0,0)
import qualified Data.Base64.Types as Base64.Types
import qualified Data.ByteString.Base64.URL as Base64URL
#else
import qualified Data.ByteString.Base64.URL as Base64URL
#endif
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.Char (isAlpha, isUpper, toLower, toUpper)
import Data.Map.Strict (Map)
import Data.Maybe (fromMaybe)
import Data.String (IsString)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Data.Vector (Vector)
import Network.HTTP.Types.URI (urlEncode, urlDecode, parseQuery, renderQuery)
import Temporal.Client.Types (WorkflowClient)
import Temporal.Common
import Temporal.Payload
import Text.Read (readMaybe)
import UnliftIO


-- | A typed reference to a Nexus operation, analogous to 'KnownWorkflow'.
--
-- Carries the codec existentially so callers can encode/decode inputs and
-- outputs without knowing the concrete serialization format at the use site.
data KnownNexusOperation input output = forall codec.
  (Codec codec input, Codec codec output) =>
  KnownNexusOperation
  { knownNexusOperationCodec :: codec
  , knownNexusOperationName :: NexusOperationName
  }


-- NexusHandler monad ---------------------------------------------------------

-- | Environment for the 'NexusHandler' monad.
data NexusHandlerEnv env = NexusHandlerEnv
  { nexusHandlerInfo :: {-# UNPACK #-} !NexusOperationInfo
  , nexusHandlerPayloadProcessor :: {-# UNPACK #-} !PayloadProcessor
  , nexusHandlerWorkflowClient :: !WorkflowClient
  , nexusHandlerLogger :: !(Loc -> LogSource -> LogLevel -> LogStr -> IO ())
  , nexusHandlerEnv :: env
  }


-- | The Nexus handler monad, analogous to 'Activity'.
--
-- Provides 'MonadIO', 'MonadUnliftIO', 'MonadLogger', and 'MonadReader env'
-- to Nexus operation handlers. Handlers are expected to perform
-- deadline-bounded IO (network calls, DB queries, Temporal client operations).
newtype NexusHandler env a = NexusHandler {unNexusHandler :: ReaderT (NexusHandlerEnv env) IO a}
  deriving newtype
    ( Functor
    , Applicative
    , Alternative
    , Monad
    , MonadFail
    , MonadFix
    , MonadIO
    , MonadPlus
    , MonadUnliftIO
    , MonadThrow
    , MonadCatch
    , MonadMask
    )


instance MonadReader env (NexusHandler env) where
  ask = NexusHandler $ asks (.nexusHandlerEnv)
  local f (NexusHandler m) = NexusHandler $ local (\a -> a {nexusHandlerEnv = f $ nexusHandlerEnv a}) m


instance MonadLogger (NexusHandler env) where
  monadLoggerLog loc source level msg = NexusHandler $ do
    logger <- asks (.nexusHandlerLogger)
    liftIO $ logger loc source level (toLogStr msg)


instance MonadLoggerIO (NexusHandler env) where
  askLoggerIO = NexusHandler $ asks (.nexusHandlerLogger)


runNexusHandler :: NexusHandlerEnv env -> NexusHandler env a -> IO a
runNexusHandler env (NexusHandler m) = runReaderT m env


askNexusOperationContext :: NexusHandler env NexusOperationInfo
askNexusOperationContext = NexusHandler $ asks (.nexusHandlerInfo)


askNexusClient :: NexusHandler env WorkflowClient
askNexusClient = NexusHandler $ asks (.nexusHandlerWorkflowClient)


askNexusPayloadProcessor :: NexusHandler env PayloadProcessor
askNexusPayloadProcessor = NexusHandler $ asks (.nexusHandlerPayloadProcessor)


-- Operation context -----------------------------------------------------------

-- | Information about the current Nexus operation execution.
--
-- Mirrors the @StartOperationContext@ / @OperationInfo@ from the TS/Go SDKs.
-- The 'nexusOpInfoRequestId' is stable across retries and should be used to
-- deduplicate workflow starts.
data NexusOperationInfo = NexusOperationInfo
  { nexusOpInfoRequestId :: !Text
  , nexusOpInfoHeaders :: !(Map Text Text)
  , nexusOpInfoCallbackUrl :: !Text
  , nexusOpInfoCallbackHeaders :: !(Map Text Text)
  , nexusOpInfoLinks :: !(Vector NexusLink)
  , nexusOpInfoService :: !NexusServiceName
  , nexusOpInfoOperation :: !NexusOperationName
  , nexusOpInfoNamespace :: !Namespace
  , nexusOpInfoTaskQueue :: !TaskQueue
  }
  deriving stock (Show, Eq)


-- | A link attached to a Nexus operation request or response.
data NexusLink = NexusLink
  { nexusLinkUrl :: !Text
  , nexusLinkType :: !Text
  }
  deriving stock (Show, Eq)


-- Operation definitions -------------------------------------------------------

-- | Internal handler definition with type-erased I/O.
--
-- Start and cancel handlers run in 'NexusHandler', which provides
-- logging, the Temporal client, and the user environment.
data NexusOperationDefinition env = NexusOperationDefinition
  { nexusOpName :: !NexusOperationName
  , nexusOpStartHandler :: NexusStartInput -> NexusHandler env NexusStartResult
  , nexusOpCancelHandler :: Maybe (NexusCancelInput -> NexusHandler env ())
  }


-- | Input delivered to a Nexus start-operation handler.
-- The payload has already been through 'PayloadProcessor.decode'.
data NexusStartInput = NexusStartInput
  { startInputPayload :: !(Maybe Payload)
  }
  deriving stock (Show)


-- | Result returned by a Nexus start-operation handler.
data NexusStartResult
  = -- | The operation completed synchronously with a result payload.
    NexusSyncSuccess !Payload ![NexusLink]
  | -- | The operation was started asynchronously; the token identifies it.
    NexusAsyncStarted !NexusOperationToken ![NexusLink]
  | -- | The handler rejected the request with an error.
    NexusStartError !NexusHandlerError
  deriving stock (Show)


-- | Input delivered to a Nexus cancel-operation handler.
data NexusCancelInput = NexusCancelInput
  { cancelInputOperationToken :: !Text
  , cancelInputHeaders :: !(Map Text Text)
  }
  deriving stock (Show)


-- | An error returned by a Nexus operation handler.
--
-- Can be thrown as an exception from 'NexusHandler' code — the worker
-- catches it and converts it to the appropriate proto error status,
-- preserving 'errorType' and 'retryable' semantics.
--
-- Mirrors @HandlerError@ in the TypeScript SDK: handlers may either
-- return 'NexusStartError' explicitly or @throwM@ a 'NexusHandlerError'.
data NexusHandlerError = NexusHandlerError
  { errorType :: !Text
  , message :: !Text
  , retryable :: !Bool
  , failureMetadata :: !(Map Text Text)
  , failureDetails :: !BS.ByteString
  }
  deriving stock (Show, Eq)


instance Exception NexusHandlerError


-- Async operation tokens ------------------------------------------------------

-- | An opaque token identifying an async Nexus operation (typically a workflow ID).
newtype NexusOperationToken = NexusOperationToken {rawNexusOperationToken :: Text}
  deriving stock (Show, Eq, Ord)
  deriving newtype (IsString)


-- | A structured token for workflow-backed Nexus operations.
-- Encodes to base64url JSON for wire transport (compatible with TS SDK).
data WorkflowRunOperationToken = WorkflowRunOperationToken
  { tokenNamespace :: !Text
  , tokenWorkflowId :: !Text
  }
  deriving stock (Show, Eq)


instance ToJSON WorkflowRunOperationToken where
  toJSON tok =
    Aeson.object
      [ "t" .= (1 :: Int)
      , "ns" .= tok.tokenNamespace
      , "wid" .= tok.tokenWorkflowId
      ]


instance FromJSON WorkflowRunOperationToken where
  parseJSON = Aeson.withObject "WorkflowRunOperationToken" $ \o -> do
    tokenType <- o .: "t"
    case (tokenType :: Int) of
      1 -> do
        mVersion <- o .:? "v"
        case (mVersion :: Maybe Int) of
          Nothing -> pure ()
          Just 0 -> pure ()
          Just v -> fail $ "unsupported token version: " <> show v
        ns <- o .: "ns"
        wid <- o .: "wid"
        when (T.null wid) $ fail "empty workflow ID in token"
        pure $ WorkflowRunOperationToken ns wid
      other -> fail $ "unknown token type: " <> show other


generateWorkflowRunOperationToken :: Namespace -> WorkflowId -> NexusOperationToken
generateWorkflowRunOperationToken (Namespace ns) (WorkflowId wfId) =
  let tok = WorkflowRunOperationToken ns wfId
      encoded = base64UrlEncodeNoPad $ BL.toStrict $ Aeson.encode tok
  in NexusOperationToken (TE.decodeUtf8 encoded)


loadWorkflowRunOperationToken :: NexusOperationToken -> Either Text WorkflowRunOperationToken
loadWorkflowRunOperationToken (NexusOperationToken raw) = do
  bytes <- base64UrlDecode (TE.encodeUtf8 raw)
  case Aeson.eitherDecodeStrict bytes of
    Left err -> Left $ "failed to parse token: " <> T.pack err
    Right tok -> Right tok


base64UrlEncodeNoPad :: BS.ByteString -> BS.ByteString
base64UrlEncodeNoPad =
#if MIN_VERSION_base64(1,0,0)
  Base64.Types.extractBase64 . Base64URL.encodeBase64Unpadded'
#else
  Base64URL.encodeBase64Unpadded'
#endif


base64UrlDecode :: BS.ByteString -> Either Text BS.ByteString
base64UrlDecode =
#if MIN_VERSION_base64(1,0,0)
  Base64URL.decodeBase64Untyped
#else
  Base64URL.decodeBase64
#endif


-- Link conversion -------------------------------------------------------------

-- | A parsed workflow event link, corresponding to proto Link.WorkflowEvent.
--
-- The reference is either an 'EventReference' (pointing at a specific history
-- event) or a 'RequestIdReference' (used for back-links from the started
-- workflow to the Nexus caller).
data WorkflowEventLink = WorkflowEventLink
  { welNamespace :: !Text
  , welWorkflowId :: !Text
  , welRunId :: !Text
  , welReference :: !(Maybe WorkflowEventReference)
  }
  deriving stock (Show, Eq)


-- | Discriminated reference in a workflow event link.
data WorkflowEventReference
  = WelEventRef !EventReference
  | WelRequestIdRef !RequestIdReference
  deriving stock (Show, Eq)


data EventReference = EventReference
  { eventRefId :: !Int
  , eventRefType :: !Text
  -- ^ PascalCase event type name, e.g. @WorkflowExecutionStarted@.
  }
  deriving stock (Show, Eq)


-- | A reference by request ID, used for back-links from the workflow started
-- by a Nexus operation to the calling workflow.
data RequestIdReference = RequestIdReference
  { requestIdRefRequestId :: !Text
  , requestIdRefEventType :: !Text
  -- ^ PascalCase event type name, e.g. @WorkflowExecutionStarted@.
  }
  deriving stock (Show, Eq)


-- | Type constant used for Nexus workflow event links.
workflowEventLinkType :: Text
workflowEventLinkType = "temporal.api.common.v1.Link.WorkflowEvent"


-- | Convert a Nexus link URL to a structured 'WorkflowEventLink'.
--
-- Path segments are percent-decoded per RFC 3986; query parameters are parsed
-- via @http-types@.  This matches the Python\/Go\/TS SDK implementations.
--
-- Expected format: @temporal:\/\/\/namespaces\/{ns}\/workflows\/{wfId}\/{runId}\/history@
nexusLinkToWorkflowEventLink :: NexusLink -> Either Text WorkflowEventLink
nexusLinkToWorkflowEventLink link = do
  let url = link.nexusLinkUrl
  stripped <- case T.stripPrefix "temporal:///" url of
    Nothing -> case T.stripPrefix "temporal://" url of
      Nothing -> Left $ "invalid URL scheme, expected temporal://, got: " <> url
      Just rest -> Right rest
    Just rest -> Right rest
  let (pathPart, queryPart) = T.breakOn "?" stripped
      parts = T.splitOn "/" pathPart
  case parts of
    ["namespaces", nsEnc, "workflows", wfIdEnc, runIdEnc, "history"] -> do
      let ns = decodePathSegment nsEnc
          wfId = decodePathSegment wfIdEnc
          runId = decodePathSegment runIdEnc
          qParams = parseQuery (TE.encodeUtf8 queryPart)
      ref <- parseReference qParams
      Right $ WorkflowEventLink ns wfId runId ref
    _ -> Left $ "invalid URL path structure: " <> pathPart
  where
    parseReference qParams =
      case lookupQ "referenceType" qParams of
        Nothing -> Right Nothing
        Just "EventReference" -> do
          eventTypeBS <- case lookupQ "eventType" qParams of
            Nothing -> Left "missing eventType parameter"
            Just et -> Right et
          let eventId = maybe 0 (\bs -> fromMaybe 0 (readMaybe (T.unpack (TE.decodeUtf8 bs)))) (lookupQ "eventID" qParams)
              eventType = normalizeEventTypeFromUrl (TE.decodeUtf8 eventTypeBS)
          Right $ Just $ WelEventRef $ EventReference eventId eventType
        Just "RequestIdReference" -> do
          eventTypeBS <- case lookupQ "eventType" qParams of
            Nothing -> Left "missing eventType parameter"
            Just et -> Right et
          let reqId = maybe "" (TE.decodeUtf8) (lookupQ "requestID" qParams)
              eventType = normalizeEventTypeFromUrl (TE.decodeUtf8 eventTypeBS)
          Right $ Just $ WelRequestIdRef $ RequestIdReference reqId eventType
        Just other -> Left $ "unknown referenceType: " <> TE.decodeUtf8 other


-- | Convert a 'WorkflowEventLink' back to a 'NexusLink' URL.
--
-- Path segments are percent-encoded; query parameters are rendered via
-- @http-types@.  Event types are emitted in PascalCase per the Nexus
-- convention.
workflowEventLinkToNexusLink :: WorkflowEventLink -> NexusLink
workflowEventLinkToNexusLink wel =
  let basePath = T.concat
        [ "temporal:///namespaces/"
        , encodePathSegment wel.welNamespace
        , "/workflows/"
        , encodePathSegment wel.welWorkflowId
        , "/"
        , encodePathSegment wel.welRunId
        , "/history"
        ]
      queryBS = case wel.welReference of
        Nothing -> BS.empty
        Just (WelEventRef ref) ->
          let params = filter (\(_, v) -> not (BS.null v))
                [ ("referenceType", "EventReference")
                , ("eventType", TE.encodeUtf8 (eventTypeToPascalCase ref.eventRefType))
                , ("eventID", if ref.eventRefId > 0 then TE.encodeUtf8 (T.pack (show ref.eventRefId)) else "")
                ]
          in renderQuery True (fmap (\(k, v) -> (k, Just v)) params)
        Just (WelRequestIdRef ref) ->
          let params = filter (\(_, v) -> not (BS.null v))
                [ ("referenceType", "RequestIdReference")
                , ("requestID", TE.encodeUtf8 ref.requestIdRefRequestId)
                , ("eventType", TE.encodeUtf8 (eventTypeToPascalCase ref.requestIdRefEventType))
                ]
          in renderQuery True (fmap (\(k, v) -> (k, Just v)) params)
  in NexusLink
      { nexusLinkUrl = basePath <> TE.decodeUtf8 queryBS
      , nexusLinkType = workflowEventLinkType
      }


-- Event type format conversion ------------------------------------------------

-- | Convert a @CONSTANT_CASE@ event type (e.g. @WORKFLOW_EXECUTION_STARTED@)
-- to PascalCase (e.g. @WorkflowExecutionStarted@).
--
-- Handles underscore-separated words and all-uppercase single words (e.g.
-- @AB@ -> @Ab@).  If already in PascalCase, returns the input unchanged.
eventTypeToPascalCase :: Text -> Text
eventTypeToPascalCase t
  | T.any (== '_') t = T.concat $ fmap capitalizeWord $ T.splitOn "_" t
  | T.length t > 1 && T.all (\c -> isUpper c || not (isAlpha c)) t = capitalizeWord t
  | otherwise = t
  where
    capitalizeWord w
      | T.null w = w
      | otherwise = T.cons (toUpper (T.head w)) (T.map toLower (T.tail w))


-- | Convert a PascalCase event type (e.g. @WorkflowExecutionStarted@) to
-- @CONSTANT_CASE@ (e.g. @WORKFLOW_EXECUTION_STARTED@).
--
-- Uses aeson's 'camelTo2' for correct handling of consecutive uppercase
-- runs (e.g. @AbCddE@ -> @AB_CDD_E@).
-- If already in CONSTANT_CASE (has underscores), returns the input unchanged.
eventTypeToConstantCase :: Text -> Text
eventTypeToConstantCase t
  | T.any (== '_') t = t
  | otherwise = T.toUpper $ T.pack $ camelTo2 '_' $ T.unpack t


-- | Accepts either PascalCase or CONSTANT_CASE from a URL, strips
-- @EVENT_TYPE_@ prefix if present, and normalizes to PascalCase.
normalizeEventTypeFromUrl :: Text -> Text
normalizeEventTypeFromUrl t =
  let stripped = fromMaybe t (T.stripPrefix "EVENT_TYPE_" t)
  in eventTypeToPascalCase stripped


-- Internal helpers ------------------------------------------------------------

lookupQ :: BS.ByteString -> [(BS.ByteString, Maybe BS.ByteString)] -> Maybe BS.ByteString
lookupQ _ [] = Nothing
lookupQ k ((k', mv) : rest)
  | k == k' = case mv of
      Nothing -> lookupQ k rest
      Just v -> Just v
  | otherwise = lookupQ k rest


encodePathSegment :: Text -> Text
encodePathSegment = TE.decodeUtf8 . urlEncode False . TE.encodeUtf8


decodePathSegment :: Text -> Text
decodePathSegment = TE.decodeUtf8 . urlDecode False . TE.encodeUtf8
