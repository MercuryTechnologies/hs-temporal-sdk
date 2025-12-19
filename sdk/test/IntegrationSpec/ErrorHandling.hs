{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}

module IntegrationSpec.ErrorHandling where

import Control.Exception
import Control.Exception.Annotated
import qualified Control.Exception.Annotated as Annotated
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import GHC.Stack (SrcLoc (..), fromCallSiteList)
import IntegrationSpec.Utils
import Temporal.Duration
import Temporal.Exception
import Temporal.Payload
import Test.Hspec


-- | Error handling and exception conversion tests
spec :: Spec
spec = do
  describe "Exception converters" $ do
    let handlers = mkAnnotatedHandlers standardApplicationFailureHandlers
    it "exception conversion works" $ do
      let aFailure = mkApplicationFailure (toException SampleException) handlers
      aFailure
        `shouldBe` ApplicationFailure
          { stack = ""
          , nonRetryable = False
          , details = []
          , message = "SampleException"
          , type' = "SampleException"
          , nextRetryDelay = Nothing
          }
    it "annotated exception conversion works (pt1)" $ do
      let bFailure = mkApplicationFailure (toException $ AnnotatedException [] SampleException) handlers
      bFailure
        `shouldBe` ApplicationFailure
          { stack = ""
          , nonRetryable = False
          , details = []
          , message = "SampleException"
          , type' = "SampleException"
          , nextRetryDelay = Nothing
          }
    it "annotated exception conversion works (pt2)" $ do
      let cFailure =
            mkApplicationFailure
              ( SomeException
                  $ AnnotatedException
                    [ Annotation Foo
                    , Annotation $
                        fromCallSiteList
                          [
                            ( "Foo"
                            , SrcLoc
                                { srcLocPackage = "Foo"
                                , srcLocModule = "Foo"
                                , srcLocFile = "Foo.hs"
                                , srcLocStartLine = 1
                                , srcLocStartCol = 1
                                , srcLocEndLine = 1
                                , srcLocEndCol = 1
                                }
                            )
                          ]
                    ]
                  $ SomeException SampleException
              )
              handlers
      cFailure
        `shouldBe` ApplicationFailure
          { stack = "Foo, called at Foo.hs:1:1 in Foo:Foo\n"
          , nonRetryable = False
          , details = [Payload {payloadData = "\"Annotation @RegressionTask Foo\"", payloadMetadata = Map.fromList [("encoding", "json/plain"), ("messageType", "[Char]")]}]
          , message = "SampleException"
          , type' = "SampleException"
          , nextRetryDelay = Nothing
          }
    it "Straight ApplicationFailure usage works" $ do
      let basic =
            ApplicationFailure
              { stack = "Foo, called at Foo.hs:1:1 in Foo:Foo\n"
              , nonRetryable = False
              , details = [Payload {payloadData = "\"Annotation @RegressionTask Foo\"", payloadMetadata = Map.fromList [("encoding", "json/plain"), ("messageType", "[Char]")]}]
              , message = "SampleException"
              , type' = "SampleException"
              , nextRetryDelay = Nothing
              }
      mkApplicationFailure (toException basic) handlers `shouldBe` basic
    it "ApplicationFailure hierarchy works" $ do
      let anAppFailure = mkApplicationFailure (toException AnApplicationFailure) handlers
      anAppFailure
        `shouldBe` toApplicationFailure AnApplicationFailure
    it "Annotation checkpoints work" $ do
      eRes <- Annotated.try $ do
        Annotated.checkpointMany [annotateNonRetryableError, annotateNextRetryDelay $ seconds 2] $ do
          Control.Exception.Annotated.throw AnApplicationFailure
      case eRes of
        Right () -> fail "Should have failed"
        Left err -> do
          let appFailure = mkApplicationFailure err handlers
          appFailure
            `shouldBe` ApplicationFailure
              "AnApplicationFailure"
              "Uh oh"
              True
              []
              appFailure.stack
              (Just $ seconds 2)
