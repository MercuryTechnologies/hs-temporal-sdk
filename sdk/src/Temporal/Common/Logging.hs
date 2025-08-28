{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE PatternSynonyms #-}

module Temporal.Common.Logging (
  logDebug,
  logInfo,
  logWarn,
  logError,
) where

import Control.Monad.Logger (LogLevel (..), LogSource, LogStr, MonadLogger (..), ToLogStr (..), defaultLoc)
import Data.Aeson (ToJSON (..))
import qualified Data.Aeson as A
import qualified Data.Aeson.Encoding as A
import Data.Text
import GHC.Stack (CallStack, HasCallStack, SrcLoc (..), callStack, getCallStack, withFrozenCallStack)
import qualified Language.Haskell.TH as TH
import Prelude hiding (log)


pattern Debug :: LogLevel
pattern Debug = LevelDebug


pattern Info :: LogLevel
pattern Info = LevelInfo


pattern Warn :: LogLevel
pattern Warn = LevelWarn


pattern Error :: LogLevel
pattern Error = LevelError


mkLoggerLoc :: SrcLoc -> TH.Loc
mkLoggerLoc SrcLoc {..} =
  TH.Loc
    { loc_filename = srcLocFile
    , loc_package = srcLocPackage
    , loc_module = srcLocModule
    , loc_start = (srcLocStartLine, srcLocStartCol)
    , loc_end = (srcLocEndLine, srcLocEndCol)
    }


callStackToLoc :: CallStack -> TH.Loc
callStackToLoc s = case getCallStack s of
  ((_, loc) : _) -> mkLoggerLoc loc
  _ -> defaultLoc


log :: (HasCallStack, MonadLogger m) => LogLevel -> Text -> m ()
log level message = withFrozenCallStack $ logWithExplicitMode True level message


logDebug :: (HasCallStack, MonadLogger m) => Text -> m ()
logDebug = log Debug


logInfo :: (HasCallStack, MonadLogger m) => Text -> m ()
logInfo = log Info


logWarn :: (HasCallStack, MonadLogger m) => Text -> m ()
logWarn = log Warn


logError :: (HasCallStack, MonadLogger m) => Text -> m ()
logError = log Error


humanLogSource :: LogSource
humanLogSource = ""


jsonLogSource :: LogSource
jsonLogSource = "json"


logWithExplicitMode :: (HasCallStack, MonadLogger m) => Bool -> LogLevel -> Text -> m ()
logWithExplicitMode jsonMode level message =
  withFrozenCallStack $
    let srcLoc = callStackToLoc callStack
        LogRepresentations human json = logRepresentations srcLoc level message
    in uncurry (realizeLog srcLoc level) $
        if jsonMode
          then (jsonLogSource, json)
          else (humanLogSource, human)


realizeLog :: (MonadLogger m) => TH.Loc -> LogLevel -> LogSource -> LogStr -> m ()
realizeLog srcLoc level source = monadLoggerLog srcLoc source level


data LogRepresentations = LogRepresentations {humanRepresentation :: LogStr, jsonRepresentation :: LogStr}


logRepresentations :: TH.Loc -> LogLevel -> Text -> LogRepresentations
logRepresentations TH.Loc {..} logLevel message = LogRepresentations {..}
  where
    humanRepresentation :: LogStr
    humanRepresentation = toLogStr message <> "\n"

    jsonRepresentation :: LogStr
    jsonRepresentation =
      encoding
        ( A.pairs $
            mconcat
              [ A.pair "message" (toEncoding message)
              , A.pair "log_level" (toEncoding $ pack $ show logLevel)
              , A.pair "source_file" (toEncoding loc_filename)
              , A.pair "source_line" (toEncoding $ fst loc_start)
              ]
        )
        <> "\n"

    encoding :: A.Encoding -> LogStr
    encoding = toLogStr . A.encodingToLazyByteString
