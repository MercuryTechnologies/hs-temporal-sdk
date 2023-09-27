{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedRecordDot #-}
module GenericSpec where
import Control.Monad.Reader
import Data.Kind
import GHC.Generics
import Temporal.Bundle
import Temporal.Activity
import Temporal.Duration (seconds)
import Temporal.Payload (JSON(..))
import Temporal.Workflow
import Temporal.Worker (ConfigM)
import RequireCallStack

data EmailWorkflows t f = Workflows
  { emailNewUser :: Wear t f (Int -> Workflow ())
  , sendEmail :: Wear t f (String -> Activity () ())
  , emailPasswordReset :: Wear t f (String -> Workflow ())
  } deriving (Generic)

instance FunctorB (EmailWorkflows Covered)
instance TraversableB (EmailWorkflows Covered)
instance ApplicativeB (EmailWorkflows Covered)
instance ConstraintsB (EmailWorkflows Covered)
instance BareB EmailWorkflows
instance Label (EmailWorkflows Covered)

emailSvc :: Refs EmailWorkflows
emailSvc = refs JSON emailSvcImpl

emailSvcImpl :: Impl EmailWorkflows
emailSvcImpl = Workflows
  { emailNewUser = \userId -> provideCallStack $ do
      h <- startActivity 
        emailSvc.sendEmail -- <=== Note how we can reference other workflows and activities using the refs we defined above
        (defaultStartActivityOptions $ ScheduleToClose $ seconds 0)
        "foo"
      wait h
  , sendEmail = \email -> do
      pure ()
  , emailPasswordReset = \email -> do
      pure ()
  }

emailSvcConfig :: ConfigM () ()
emailSvcConfig = defsToConfig $ defs JSON emailSvcImpl

spec :: Monad m => m ()
spec = pure ()