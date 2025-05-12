# Workflow STM Implementation

How we use STM to implement Temporal workflows in Haskell.

*See also: [Command Queue](command-queue.md) | [Sequence Management](sequence-management.md)*

## Core Concepts

We chose STM (Software Transactional Memory) as our concurrency mechanism for several reasons:

1. **Determinism** - STM transactions are atomic, which helps with deterministic replay
2. **Composition** - Complex concurrent operations can be composed while preserving atomicity
3. **Natural blocking** - STM gives us clean primitives for blocking operations

## Thread Management

Every workflow has multiple threads:

- **Main thread**: Runs the workflow implementation
- **Scheduler thread**: Waits for all threads to block, then triggers command flushing
- **Worker threads**: Handle signals, timers, queries, etc.

We track every thread's state through a `ThreadManager`:

```haskell
newtype ThreadManager = ThreadManager
  { threadManager :: TVar (HashMap.HashMap ThreadId WorkflowThread)
  }

data WorkflowThread = WorkflowThread
  { workflowThreadBlocked :: {-# UNPACK #-} !(TVar Bool)
  }
```

## Blocking Mechanism

A key part of our implementation is tracking when threads are blocked. When all threads are blocked, we flush commands to Temporal.

We use `IVar`s for this purpose:

```haskell
data IVar a = IVar
  { ivar :: {-# UNPACK #-} !(TMVar a)
  , blocks :: {-# UNPACK #-} !(TVar (HashMap.HashMap ThreadId WorkflowThread))
  , manager :: {-# UNPACK #-} !ThreadManager
  }
```

When a thread waits on an `IVar`:

```haskell
waitIVar IVar{..} = do
  tid <- myThreadId
  join $ do
    atomically do
      threads <- readTVar $ threadManager manager
      let threadState = case HashMap.lookup tid threads of
            Just thread -> thread
            Nothing -> error ("waitIVar: Thread in map should exist " <> show tid)
      mval <- tryReadTMVar ivar
      case mval of
        Nothing -> do
          writeTVar threadState.workflowThreadBlocked True
          modifyTVar' blocks $ HashMap.insert tid threadState
          pure $ atomically $ readTMVar ivar
        Just val -> pure $ pure val
```

When an `IVar` gets a value:

```haskell
putIVar IVar {ivar, blocks} x = void do
  _ <- tryPutTMVar ivar x
  currentlyBlocked <- readTVar blocks
  for_ currentlyBlocked (\blocked -> writeTVar blocked.workflowThreadBlocked False)
  writeTVar blocks mempty
```

This blocking mechanism is central to the workflow execution model - it allows us to detect when the workflow is "stuck" waiting for external input, which is when we should flush commands and wait for activations.

## Execution Flow

```mermaid
sequenceDiagram
    participant C as Temporal Core
    participant W as Workflow Worker
    participant M as Main Thread
    participant S as Scheduler Thread
    participant A as Async Threads

    C->>W: Activation (InitializeWorkflow)
    W->>M: Start Workflow
    activate M
    M->>S: Start Scheduler
    activate S

    M->>M: Execute workflow code
    M-->>A: Spawn async threads<br>(signals, timers, etc.)
    activate A

    Note over M,A: When workflow needs to wait<br>(e.g., for timer, activity)
    M->>M: Mark thread as blocked
    A->>A: Mark thread(s) as blocked

    S->>S: Wait for all threads to block
    S->>C: Flush commands

    C->>W: New Activation (e.g., FireTimer)
    W->>S: Process Activation
    S->>M: Unblock relevant thread(s)
    S->>A: Unblock relevant thread(s)

    Note over M,A: Continue execution

    M->>M: Complete workflow
    M->>C: Send completion command
    deactivate M
    deactivate S
    deactivate A
```

## Blocking and Unblocking

```mermaid
flowchart TD
    A[Workflow execution] --> B{Operation requires<br>external input?}
    B -->|Yes| C[Mark thread as blocked]
    B -->|No| D[Continue execution]

    C --> E[Check if all threads blocked]
    E -->|Yes| F[Flush commands to Temporal]
    E -->|No| G[Wait for other threads]

    F --> H[Wait for activation]
    H --> I[Process activation jobs]
    I --> J1[Apply signals]
    J1 --> J2[Apply queries]
    J2 --> J[Unblock relevant threads]
    J --> K[Continue execution]

    D --> B
    K --> B
```

## Activation Processing

When an activation comes in from Temporal Core, we need to unblock the right threads. The [Sequence Management](sequence-management.md) system helps match activations with their waiting threads.

```mermaid
flowchart TD
    A[Receive Activation] --> B[Update workflow state]
    B --> C[Process activation jobs]
    C --> D{Job type?}

    D -->|FireTimer| E[Resolve timer sequence]
    D -->|ResolveActivity| F[Resolve activity sequence]
    D -->|SignalWorkflow| G[Buffer or execute signal handler]
    D -->|QueryWorkflow| H[Buffer or execute query handler]
    D -->|CancelWorkflow| I1[Put value in cancelRequested IVar]
    D -->|Others| I[Process other job types]

    E --> J[Put result in IVar]
    F --> J
    G --> J
    H --> K[Send query response]
    I1 --> J
    I --> J

    J --> L[Unblock waiting threads]
    K --> M[Continue workflow execution]
    L --> M

    subgraph "After all jobs processed"
        N[Wait for all threads to block]
        N --> O[Process buffered signals]
        O --> P[Process buffered queries]
        P --> Q[Wait for all threads to block again]
        Q --> R[Flush commands]
    end
```

The `activate` function processes incoming activations:

```haskell
activate :: WorkflowRuntime -> WorkflowActivation -> ThreadId -> STM (IO ())
activate runtime act tid = do
  -- Update workflow state (timestamp, history length, etc.)
  -- Process activation jobs
  -- Return non-STM operations that need to be executed
```

Each job type has a specific handler that:
1. Finds the right sequence/handler
2. Puts the result in the corresponding IVar, unblocking waiting threads
3. Returns any non-STM operations that need to run

## Command Flushing

Once all threads are blocked, we flush commands to Temporal using the [Command Queue](command-queue.md):

```mermaid
flowchart TD
    A[All threads blocked] --> B[Scheduler thread detects blocked state]
    B --> C[Get commands from command queue]
    C --> D[Create WorkflowActivationCompletion]
    D --> E[Send to Temporal Core]
    E --> F[Wait for next activation]
```

The scheduler thread runs this cycle repeatedly:

```haskell
schedule mainThread = do
  -- Wait for main thread to be added to thread manager
  forever do
    -- Apply activations fully before blocking again
    join $ atomically $ applyActivations tid
    atomically do
      waitAllJobsHandled
      waitAllThreadsBlocked runtime
    -- Process buffered signals and queries
    untilM_ do
      (handleCount, m) <- atomically $ applyQueuedSignals tid
      m
      atomically do
        waitAllJobsHandled
        waitAllThreadsBlocked runtime
      pure (handleCount == 0)
    join $ atomically $ applyQueuedQueries tid
    atomically do
      waitAllJobsHandled
      waitAllThreadsBlocked runtime
    flushCommands runtime
```

## Concurrency Primitives

### IVar

Our main synchronization primitive is `IVar`, which represents a value that may not exist yet:

- `newIVar`: Creates a new empty `IVar`
- `putIVar`: Sets the value, unblocking any waiting threads
- `waitIVar`: Waits for the value, marking the thread as blocked
- `tryReadIVar`: Non-blocking read attempt

### Condition

For more complex synchronization:

```haskell
newtype Condition a = Condition (STM a)
```

- `waitCondition`: Blocks until a condition becomes true

## Ensuring Determinism

Our STM approach ensures determinism by:

1. Making state changes atomic and composable
2. Tracking thread blocking to know when the workflow is truly stuck
3. Handling activations deterministically
4. Ensuring signals and queries operate on consistent workflow state

## Implementation Challenges

### Thread Management

All threads must be tracked in the `ThreadManager`, including:
- Main workflow thread
- Signal handler threads
- Child workflow threads
- Local activity threads

### Deadlock Detection

We include optional deadlock detection:

```haskell
eResult <- case inst.workflowDeadlockTimeout of
  Nothing -> do
    apply
  Just timeoutDuration -> do
    res <- UnliftIO.timeout timeoutDuration apply
    case res of
      Nothing -> do
        pure $ Left $ toException $ LogicBug WorkflowActivationDeadlock
      Just res' -> do
        pure res'
```

### Cancellation

Workflow cancellation propagates to all active threads:

```haskell
handleCancelWorkflow runtime _ = do
  markJobHandled runtime
  putIVar runtime.workflowRuntimeCancelRequested ()
  pure $ pure ()
```

## Practical Examples

### Timer Implementation

```mermaid
sequenceDiagram
    participant W as Workflow Code
    participant R as Runtime
    participant T as Temporal Service

    W->>R: Create timer (sleepFor)
    R->>R: Generate timer sequence
    R->>R: Create IVar for timer
    R->>T: Send StartTimer command
    W->>R: waitIVar (blocks thread)

    Note over W,R: Thread is now blocked

    T->>R: FireTimer activation
    R->>R: Find timer IVar by sequence
    R->>R: putIVar to unblock
    R-->>W: Resume execution
```

### Activity Implementation

```mermaid
sequenceDiagram
    participant W as Workflow Code
    participant R as Runtime
    participant T as Temporal Service
    participant A as Activity Worker

    W->>R: Execute activity
    R->>R: Generate activity sequence
    R->>R: Create IVar for result
    R->>T: Send ScheduleActivity command
    W->>R: waitIVar (blocks thread)

    Note over W,R: Thread is now blocked

    T->>A: Schedule activity
    A->>A: Execute activity
    A->>T: Complete activity
    T->>R: ResolveActivity activation
    R->>R: Find activity IVar by sequence
    R->>R: putIVar with result to unblock
    R-->>W: Resume execution with result
```

## Conclusion

The STM-based workflow implementation provides an elegant and powerful solution for managing the complex concurrency requirements of Temporal workflows in Haskell. By using STM's transactional properties and blocking mechanisms, the SDK ensures deterministic execution while allowing for complex workflow patterns to be expressed naturally.

> **Navigation:**
> - [Back to Documentation Index](README.md)
> - [Command Queue Documentation](command-queue.md)
> - [Sequence Management Documentation](sequence-management.md)
