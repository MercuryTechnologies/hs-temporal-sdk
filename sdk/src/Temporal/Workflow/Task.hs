module Temporal.Workflow.Task where


-- | An async action handle that can be awaited or cancelled.
data Task a = Task
  { waitAction :: IO a
  , cancelAction :: IO ()
  }


instance Functor Task where
  fmap f (Task wait' cancel') = Task (fmap f wait') cancel'


instance Applicative Task where
  pure a = Task (pure a) (pure ())
  Task waitL cancelL <*> Task waitR cancelR = Task (waitL <*> waitR) (cancelL *> cancelR)
