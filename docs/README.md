# Temporal SDK Internal Docs

Documentation for the Haskell Temporal SDK's STM-based workflow implementation. This is for developers working on the SDK or those curious about how it works internally.

Each doc links to related docs for easy navigation.

## Core Components

### [Workflow STM Implementation](workflow-stm.md)

This document provides a comprehensive overview of how the Haskell SDK uses Software Transactional Memory (STM) to implement workflow execution. It covers:

- The core concurrency model using STM
- Thread management and blocking mechanisms
- How workflow execution is structured
- The activation processing flow
- Diagrams illustrating the workflow lifecycle

### [Command Queue](command-queue.md)

This document explains the Command Queue system, which is responsible for collecting and flushing commands from workflows to the Temporal service:

- Command Queue structure and implementation
- How commands flow through the system
- Command batching and flow control
- Integration with the workflow lifecycle

### [Sequence Management System](sequence-management.md)

This document details how the Sequence Management System works to correlate asynchronous operations:

- How sequence numbers are generated and tracked
- How operations like activities, timers, and child workflows are correlated with their completions
- Sequence handling for different operation types
- Error handling in the sequence system

## Workflow Execution Flow

```mermaid
flowchart TD
    A[External Request] --> B[Temporal Service]
    B --> C[Workflow Worker]

    subgraph "Workflow Execution"
        D[Main Thread] --> E{Blocking<br>Operation?}
        E -->|Yes| F[Create IVar and Sequence]
        F --> G[Add Command to Queue]
        G --> H[Mark Thread as Blocked]

        I[Scheduler Thread] --> J{All Threads<br>Blocked?}
        J -->|Yes| K[Flush Commands]

        L[Flusher Thread] --> M[Send Commands to Temporal]
    end

    C --> N[Process Activation]
    N --> O[Resolve Sequence]
    O --> P[Unblock Thread]
    P --> D
```

## Blocking and Unblocking

The core of our SDK is the ability to block and unblock threads deterministically based on external events. This works through:

1. `IVar`s that threads wait on
2. The `ThreadManager` tracking thread states
3. The `waitAllBlocked` mechanism triggering command flushes
4. Activation handling that resolves `IVar`s and unblocks threads

### Key Interactions

```mermaid
sequenceDiagram
    participant W as Workflow Thread
    participant T as Thread Manager
    participant I as IVar
    participant Q as Command Queue
    participant F as Flusher
    participant S as Temporal Service

    W->>I: waitIVar
    I->>T: Mark thread as blocked

    T->>T: Check if all threads blocked
    T->>Q: Signal ready to flush
    Q->>F: Collect commands
    F->>S: Send commands

    S->>W: Send activation
    W->>I: putIVar
    I->>T: Mark thread as unblocked
    I->>W: Return value to thread
```

## Key Implementation Challenges & Solutions

Our STM approach solves several challenges:

1. **Determinism** - STM makes state changes atomic and composable for replay
2. **Concurrency** - Multiple operations run concurrently while maintaining determinism
3. **Blocking** - Threads block without consuming resources or affecting determinism
4. **Error Handling** - Errors propagate naturally like normal results

## See Also

For additional information:

- [Temporal Documentation](https://docs.temporal.io/)
- [Haskell SDK API Documentation](../README.md)
- [STM Documentation](https://hackage.haskell.org/package/stm)
