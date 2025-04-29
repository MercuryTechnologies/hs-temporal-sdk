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
- **Flusher thread**: Sends commands to Temporal
- **Worker threads**: Handle signals, timers, etc.

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
  atomically do
    -- Find our thread state
    -- If value isn't available:
    --   Mark thread as blocked
    --   Register in blocks map
    -- Otherwise just return the value
```

When an `IVar` gets a value:

```haskell
putIVar IVar{ivar, blocks} x = void do
  _ <- tryPutTMVar ivar x
  currentlyBlocked <- readTVar blocks
  for_ currentlyBlocked (\blocked ->
    writeTVar blocked.workflowThreadBlocked False)
  writeTVar blocks mempty
```

## Execution Flow

```mermaid
sequenceDiagram
    participant C as Temporal Core
    participant W as Workflow Worker
    participant M as Main Thread
    participant S as Scheduler Thread
    participant F as Flusher Thread
    participant A as Async Threads

    C->>W: Activation (InitializeWorkflow)
    W->>M: Start Workflow
    activate M
    M->>S: Start Scheduler
    activate S
    M->>F: Start Flusher
    activate F

    M->>M: Execute workflow code
    M-->>A: Spawn async threads<br>(signals, timers, etc.)
    activate A

    Note over M,A: When workflow needs to wait<br>(e.g., for timer, activity)
    M->>M: Mark thread as blocked
    A->>A: Mark thread(s) as blocked

    S->>S: Wait for all threads to block
    S->>F: Signal ready to flush
    F->>C: Send commands

    C->>W: New Activation (e.g., FireTimer)
    W->>S: Process Activation
    S->>M: Unblock relevant thread(s)
    S->>A: Unblock relevant thread(s)

    Note over M,A: Continue execution

    M->>M: Complete workflow
    M->>F: Signal completion
    F->>C: Send completion command
    deactivate M
    deactivate S
    deactivate F
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
    I --> J[Unblock relevant threads]
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
    D -->|SignalWorkflow| G[Execute signal handler]
    D -->|QueryWorkflow| H[Execute query handler]
    D -->|Others| I[Process other job types]

    E --> J[Put result in IVar]
    F --> J
    G --> J
    H --> K[Send query response]
    I --> J

    J --> L[Unblock waiting threads]
    K --> M[Continue workflow execution]
    L --> M
```

The `activate` function processes incoming activations:

```haskell
activate :: WorkflowRuntime -> WorkflowActivation -> ThreadId -> STM (IO ())
activate runtime act tid = do
  -- Update workflow state
  -- Apply jobs atomically to ensure all threads can unblock together
  -- Handle any errors during job processing
```

Each job type has a specific handler that:
1. Finds the right sequence/handler
2. Puts the result in the corresponding IVar, unblocking waiting threads
3. Returns any non-STM operations that need to run

## Command Flushing

Once all threads are blocked, we flush commands to Temporal using the [Command Queue](command-queue.md):

```mermaid
flowchart TD
    A[All threads blocked] --> B[Mark ready to flush]
    B --> C[Flusher thread detects ready state]
    C --> D[Collect commands from queue]
    D --> E[Create WorkflowActivationCompletion]
    E --> F[Send to Temporal Core]
    F --> G[Wait for next activation]
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
  Nothing -> apply
  Just timeoutDuration -> do
    res <- UnliftIO.timeout timeoutDuration apply
    case res of
      Nothing -> pure $ Left $ toException $
                 LogicBug WorkflowActivationDeadlock
      Just res' -> pure res'
```

### Cancellation

Workflow cancellation propagates to all active threads:

```haskell
handleCancelWorkflow runtime _ = do
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
