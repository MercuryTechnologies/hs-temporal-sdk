# Sequence Management

How we match commands with their responses in Temporal workflows.

*See also: [Workflow STM Implementation](workflow-stm.md) | [Command Queue](command-queue.md)*

## Overview

In Temporal workflows, operations are asynchronous and we need to match requests with their eventual responses. When a workflow schedules an activity, we need to match the completion with the original request.

Sequences connect the [Command Queue](command-queue.md) (which sends commands) with the activation processing system (from the [Workflow STM doc](workflow-stm.md#activation-processing)), letting workflow threads block and unblock at the right times.

## Structure

Our sequence system consists of:

```haskell
-- Simple identifier for tracking sequences
newtype Sequence = Sequence Word32

-- Maps for different types of sequences
data SequenceMaps = SequenceMaps
  { timers :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ())))
  , activities :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ResolveActivity)))
  , childWorkflows :: {-# UNPACK #-} !(TVar (SequenceMap (ChildWorkflowHandle Any)))
  , externalSignals :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ResolveSignalExternalWorkflow)))
  , externalCancels :: {-# UNPACK #-} !(TVar (SequenceMap (IVar ResolveRequestCancelExternalWorkflow)))
  , counters :: {-# UNPACK #-} !Sequences
  }

-- Counters for generating sequence numbers
data Sequences = Sequences
  { externalCancel :: {-# UNPACK #-} !(TVar Word32)
  , childWorkflow :: {-# UNPACK #-} !(TVar Word32)
  , externalSignal :: {-# UNPACK #-} !(TVar Word32)
  , timer :: {-# UNPACK #-} !(TVar Word32)
  , activity :: {-# UNPACK #-} !(TVar Word32)
  }
```

We maintain:

1. **Type-specific counters** - One for each operation type
2. **Sequence maps** - Associate sequence numbers with their IVars or handles
3. **Resolution function** - Finds and removes entries when activations arrive

## How It Works

```mermaid
flowchart TD
    A[Workflow Operation] --> B[Generate Sequence Number]
    B --> C[Create IVar for Result]
    C --> D[Store in Sequence Map]
    D --> E[Send Command to Temporal]
    E --> F[Workflow Blocks on IVar]

    G[Activation from Temporal] --> H[Extract Sequence Number]
    H --> I[Look up IVar in Sequence Map]
    I --> J[Remove from Sequence Map]
    J --> K[Put Result in IVar]
    K --> L[Unblock Waiting Thread]
```

The command sending part (steps A-E) works with the [Command Queue](command-queue.md), while activation handling and thread unblocking (steps G-L) work with the [blocking mechanism](workflow-stm.md#blocking-mechanism).

### Generating Sequences

When a workflow needs to send a command to Temporal (like starting an activity), we first generate a sequence number:

```haskell
-- Example for activity sequences
nextActivitySequence :: InstanceM Sequence
nextActivitySequence = atomically do
  runtime <- ask
  Sequence <$> stateTVar
    runtime.workflowRuntimeSequenceMaps.counters.activity
    (\s -> (s, s + 1))
```

Sequences start at 1 (since 0 looks uninitialized in protobuf) and increment for each operation.

### Registering Sequences

The operation creates an IVar to hold the eventual result and registers it:

```haskell
-- Example for activities
startActivityFromPayloads :: KnownActivity args result -> StartActivityOptions -> Vector Payload -> Workflow (Task result)
startActivityFromPayloads (KnownActivity codec name) opts typedPayloads = Workflow $ withRunInIO $ \runInIO -> runInIO $ do
  runtime <- ask
  s@(Sequence actSeq) <- nextActivitySequence
  resultSlot <- newIVar $ getThreadManager runtime
  atomically $
    modifyTVar'
      runtime.workflowRuntimeSequenceMaps.activities
      (HashMap.insert s resultSlot)

  -- Create and add command with sequence number
  -- Return Task that waits on the resultSlot
```

### Resolving Sequences

When an activation returns from Temporal with a sequence number, the handler looks up and resolves the corresponding IVar:

```haskell
handleResolveActivity :: WorkflowRuntime -> ResolveActivity -> STM (IO ())
handleResolveActivity runtime msg = do
  markJobHandled runtime
  let a = msg ^. Activation.seq . to Sequence
  mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.activities a
  case mvar of
    Nothing -> Catch.throwM $ RuntimeError "Activity handle not found"
    Just existing -> do
      putIVar existing msg
      pure $ pure ()
```

The `resolveSequence` function efficiently looks up and removes the entry in one atomic operation:

```haskell
resolveSequence :: TVar (SequenceMap a) -> Sequence -> STM (Maybe a)
resolveSequence sequenceMap seq =
  stateTVar sequenceMap $ \m -> (HashMap.lookup seq m, HashMap.delete seq m)
```

## Sequence Types

We manage several types of sequences:

### 1. Timer Sequences

Used for workflow timers and sleep operations.

```mermaid
sequenceDiagram
    participant W as Workflow
    participant R as Runtime
    participant T as Temporal

    W->>R: createTimer(duration)
    R->>R: Generate timer sequence
    R->>R: Create timer IVar
    R->>T: Send StartTimer command with sequence
    W->>R: Wait on timer IVar (blocks)

    T->>R: FireTimer activation with sequence
    R->>R: Find timer IVar
    R->>R: Put value in IVar
    R-->>W: Continue execution
```

### 2. Activity Sequences

Used for tracking activities executed by the workflow.

```mermaid
sequenceDiagram
    participant W as Workflow
    participant R as Runtime
    participant T as Temporal
    participant A as Activity Worker

    W->>R: executeActivity(...)
    R->>R: Generate activity sequence
    R->>R: Create activity result IVar
    R->>T: Send ScheduleActivity command with sequence
    W->>R: Wait on activity IVar (blocks)

    T->>A: Schedule activity
    A->>T: Complete activity
    T->>R: ResolveActivity activation with sequence
    R->>R: Find activity IVar
    R->>R: Put result in IVar
    R-->>W: Continue execution with result
```

### 3. Child Workflow Sequences

Used for tracking child workflows. These are more complex because they involve multiple phases:

```mermaid
sequenceDiagram
    participant W as Workflow
    participant R as Runtime
    participant T as Temporal
    participant C as Child Workflow

    W->>R: startChildWorkflow(...)
    R->>R: Generate child workflow sequence
    R->>R: Create child workflow handle (with 3 IVars)
    R->>T: Send StartChildWorkflow command with sequence
    W->>R: Wait on start handle (blocks)

    T->>R: ResolveChildWorkflowExecutionStart with sequence
    R->>R: Find child workflow handle
    R->>R: Put value in start handle
    R-->>W: Continue execution

    W->>R: Wait on result handle (blocks)
    C->>T: Complete child workflow
    T->>R: ResolveChildWorkflowExecution with sequence
    R->>R: Find child workflow handle again
    R->>R: Put result in result handle
    R-->>W: Continue execution with result
```

Child workflow handles have more complexity since they manage the full lifecycle:

```haskell
ChildWorkflowHandle
  { childWorkflowSequence = s
  , startHandle = startSlot                -- IVar for start completion
  , resultHandle = resultSlot              -- IVar for workflow result
  , firstExecutionRunId = firstExecutionRunId  -- IVar for RunId
  , childWorkflowResultConverter = pure    -- Function to convert result
  , childWorkflowId = wfId                 -- Workflow ID
  }
```

### 4. External Signal Sequences

Used for tracking signals sent to external workflows.

```mermaid
sequenceDiagram
    participant W as Workflow
    participant R as Runtime
    participant T as Temporal
    participant E as External Workflow

    W->>R: signalExternalWorkflow(...)
    R->>R: Generate signal sequence
    R->>R: Create signal result IVar
    R->>T: Send SignalExternalWorkflow command with sequence
    W->>R: Wait on signal IVar (blocks)

    T->>E: Signal external workflow
    T->>R: ResolveSignalExternalWorkflow with sequence
    R->>R: Find signal IVar
    R->>R: Put result in IVar
    R-->>W: Continue execution
```

### 5. External Cancel Sequences

Used for tracking cancellation requests sent to external workflows.

```mermaid
sequenceDiagram
    participant W as Workflow
    participant R as Runtime
    participant T as Temporal
    participant E as External Workflow

    W->>R: cancelExternalWorkflow(...)
    R->>R: Generate cancel sequence
    R->>R: Create cancel result IVar
    R->>T: Send RequestCancelExternalWorkflow command with sequence
    W->>R: Wait on cancel IVar (blocks)

    T->>E: Request cancel external workflow
    T->>R: ResolveRequestCancelExternalWorkflow with sequence
    R->>R: Find cancel IVar
    R->>R: Put result in IVar
    R-->>W: Continue execution
```

## Integration with Thread Blocking

The sequence system works directly with the [thread blocking mechanism](workflow-stm.md#blocking-and-unblocking):

1. When a thread waits on an IVar in a sequence map, it marks itself as blocked
2. When all threads are blocked, commands get flushed to Temporal
3. When an activation comes back with a sequence number, it resolves the IVar
4. This unblocks the waiting thread, letting workflow execution continue

## Activation Job Handlers

Each activation job type has a specialized handler that resolves the appropriate sequence:

```haskell
handleFireTimer runtime msg = do
  markJobHandled runtime
  let t = msg ^. Activation.seq . to Sequence
  mvar <- resolveSequence runtime.workflowRuntimeSequenceMaps.timers t
  case mvar of
    Nothing -> Catch.throwM $ RuntimeError "Timer not found"
    Just ivar' -> do
      putIVar ivar' ()
      pure $ pure ()
```

The handler:
1. Marks the job as handled (decrements the job counter)
2. Extracts the sequence number from the activation
3. Resolves the sequence to find the corresponding IVar
4. Puts the result in the IVar, unblocking any waiting threads
5. Returns any IO operations that need to be performed

## Error Handling

We handle several error scenarios:

1. **Missing Sequences**: If an activation references a sequence that doesn't exist
2. **Failed Operations**: Errors get put into the IVar, causing waiting threads to throw exceptions
3. **Sequence Cleanup**: Sequences are removed after resolution to prevent memory leaks

## Implementation Notes

1. **Atomicity**: All sequence operations happen within STM transactions
2. **Determinism**: Sequence generation must be deterministic during replay
3. **Memory Management**: We remove sequences after resolution
4. **Error Propagation**: Errors flow through the same IVar mechanism
