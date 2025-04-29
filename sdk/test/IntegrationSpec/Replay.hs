module IntegrationSpec.Replay where

import Temporal.Activity
import Temporal.Workflow


oldActivity :: Activity () Text
oldActivity = pure "This is what should happen without patching"


newActivity :: Activity () Text
newActivity = pure "This is what should happen WITH patching"


oldActivityDef :: ProvidedActivity () (Activity () Text)
oldActivityDef = provideActivity JSON "someActivity" oldActivity


newActivityDef :: ProvidedActivity () (Activity () Text)
newActivityDef = provideActivity JSON "someActivity" newActivity


canProceedQuery :: KnownQuery '[] (Maybe Bool)
canProceedQuery = KnownQuery "can-proceed" JSON


canProceedSignal :: KnownSignal '[] Bool
canProceedSignal = KnownSignal "proceed" JSON


oldWorkflow :: Workflow Text
oldWorkflow = provideCallStack do
  canProceed <- newStateVar False
  setQueryHandler canProceedQuery (readStateVar canProceed)
  setSignalHandler canProceedSignal (writeStateVar canProceed)
  waitUntil (readStateVar canProceed)
  Workflow.executeActivity OldActivity activityOptions


newWorkflow :: Workflow Text
newWorkflow = provideCallStack do
  newPath <- Workflow.patched "follow-the-new-path"
  canProceed <- newStateVar False
  setQueryHandler canProceedQuery (readStateVar canProceed)
  setSignalHandler canProceedSignal (writeStateVar canProceed)
  waitUntil (readStateVar canProceed)

  -- Then decide what to do
  if newPath
    then Workflow.executeActivity newActivityDef activityOptions
    else Workflow.executeActivity oldActivityDef activityOptions
