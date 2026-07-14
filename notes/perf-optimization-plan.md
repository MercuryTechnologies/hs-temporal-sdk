# hs-temporal-sdk — Performance Optimization Plan (Core review)

**Status:** planning · **Date:** 2026-07-13 · **Scope:** Haskell-only (FFI/Rust deferred)

## Provenance

Derived from a review of GHC **`-O`** "Tidy Core" (`-ddump-simpl`) for every module in
`temporal-sdk` (56 modules) and `temporal-sdk-core` (10 modules). Nine reviewers each
classified one cluster; a synthesis pass merged duplicates into root-cause themes and
ranked opportunities by impact/effort/risk. Full cluster notes + aggregate live under
`/tmp/core-o2/` (ephemeral — regenerate with the dump build if needed).

Dump build command (both packages):

```
cabal build temporal-sdk-core temporal-sdk \
  --ghc-options="-O -fforce-recomp -ddump-simpl -ddump-to-file -dsuppress-all -dsuppress-uniques -dno-suppress-type-signatures"
```

**Evidence-anchor caveat.** `*.dump-simpl:N` line anchors below come from the
delimited-continuation branch's `-O` dumps. For modules that are **byte-identical** on
`main` (see applicability table) the anchors hold as-is. For modules the branch edited,
re-confirm against `main`'s Core before acting; source-level anchors marked ✓ were
verified on `main`.

## The metric that matters

Almost every item is "remove N bytes of allocation per operation" or "stop allocation
growing super-linearly." **Bytes allocated is the primary signal** (deterministic,
low-noise, directly attributable, CI-gateable). Wall-clock / GC-time / residency are
secondary confirmations. The profiling harness (next work item) is built around this.

---

## Priority-ordered opportunities

Legend — **Hotness**: HOT (per activation/step/payload/suspend) · WARM (per task/poll/RPC) · COLD (startup/registration).
**main?**: ✅ applies to `main` · ⚠️ pattern on `main`, re-verify site · ❌ branch-exclusive.

| # | Opportunity | Hot | Effort | Risk | Conf | main? |
|---|---|---|---|---|---|---|
| 1 | SPECIALIZE the worker dispatch stack | HOT | S | Low | High | ⚠️ |
| 2 | Level-gate log message construction | HOT | S | Low | High | ✅ |
| 3 | Cache per-type payload metadata in `encodeJSON` | HOT | S | Low | High | ✅ |
| 4 | Split per-activation-mutable `Info` fields | HOT | S | Low | High | ⚠️ |
| 5 | Fold signal-handler double lookup into one | HOT | S | Low | Med | ⚠️ |
| 6 | O(1)-append run queue (`JobList`) | HOT | M | Med | High | ✅ |
| 7 | Inflight scheduler: stop re-polling the world | HOT | M–L | Med | High | ❌ |
| 8 | Defer CallStack construction to error path | HOT | M | Med | Med-High | ⚠️ |
| 9 | Specialize + strictify per-step arg encoding | HOT | M | Low-Med | Med-High | ⚠️ |
| 10 | Per-suspend double-resume guard MutVar | HOT | S | Med-High | Med | ❌ |
| 11 | Per-task container/record churn bundle | HOT-WARM | S ea | Low | Med | ⚠️ |
| 12 | `nextXSequence` six-way clone + double scrutinee | HOT (tiny) | S | Low | Med | ⚠️ |
| 13 | Exception failure-path allocs | WARM | S | Low | Med | ✅ |
| 14 | `fetchLogs` double-pass + Worker complete/heartbeat via lazy builder | WARM/HOT | S | Low | Med | ✅ |
| 15 | Misc: BoundedConcurrency KnownNat / SearchAttributes toEncoding / sequenceConcurrently | WARM | S | Low | Med | ⚠️/✅ |

---

## Tier 1 — Quick wins (small, low-risk; do first)

### 1. SPECIALIZE the worker dispatch stack  ·  HOT · S · Low risk · High conf · main ⚠️
- **Root cause:** `handleActivation`, `execute`, and poll loops (`whileM_`, `pollWorkflowActivation1`) are polymorphic in `m` with no `SPECIALIZE`/`INLINABLE` → every `>>=`/`pure`/`liftIO`/`log` dispatches through a boxed dict and derived `ReaderT` dicts are rebuilt per call; blocks `return`/`>>=` collapse + fusion.
- **Where:** `Workflow.Worker` (`handleActivation`, dump :1712-1750, :848, :3825, lazy foldrM :3511), `Activity.Worker` (`execute`/`applyActivityTask(Start)`, :1970-1990, :3438-3510), `Nexus.Worker` (`execute`, :621-663).
- **Fix:** add `{-# SPECIALIZE #-}` at the concrete worker monad + `INLINABLE`; mechanical.
- **main:** `m`-polymorphism is structural/pre-existing. `Nexus/Worker.hs` diff=0, `Activity/Worker.hs` 4-line diff → portable; `Workflow/Worker.hs` 41-line diff → re-verify site.
- **Do first:** changes Core shape of the worker modules; may resolve the lazy-list finding for free. Re-measure workers only after this lands.
- **Measure:** replay macro harness — bytes allocated per activation.

### 2. Level-gate log message construction  ·  HOT · S · Low · High · main ✅
- **Root cause:** `Common.Logging.log` Aeson-encodes the JSON message, `show`s the level, and chunk-walks the lazy ByteString to compute its length **before** monad-logger's level filter runs. Disabled `logDebug` still pays near-full cost.
- **Where:** `Common/Logging.hs` (source :82-120; dump :315, :588-595) — **diff=0 on main**. Also per-dispatch debug thunks: `WorkflowInstance` :8173/:9131/:7646, `Workflow.Worker` :1774-1786.
- **Fix:** read effective min level once, short-circuit before building the message (`whenM (logLevelEnabled …)`).
- **main:** `Common/Logging.hs` identical → fully portable. Dispatch-site thunks live in edited files → re-verify.
- **Measure:** throughput harness with level=Warn but `logDebug` calls present on dispatch path; delta in bytes/activation is pure waste removed.

### 3. Cache per-type payload metadata in `encodeJSON`  ·  HOT · S · Low · High · main ✅
- **Root cause:** every encode recomputes `show . typeRep` → `String` → repacked `ByteString`, builds a 2-elem metadata map, and does a redundant `union Tip` — result is constant per type.
- **Where:** `Payload.hs` — `messageType _ _ = C.pack $ show $ typeRep (Proxy @a)` (**confirmed `main:144`** ✓; also :149-156). Dump :2826-2841, Protobuf variant :2694-2702. **diff=0 on main.**
- **Fix:** memoize per-type metadata (NOINLINE CAF / type-indexed cache); build with `Map.fromDistinctAscList` (keys already ascending); drop `<> mempty`.
- **main:** fully portable.
- **Measure:** micro-bench `encode`/`decode` of a fixed type — allocations per op.

### 4. Split per-activation-mutable `Info` fields  ·  HOT · S · Low · High · main ⚠️
- **Root cause:** `$wapplyJobs'` reads the 24-field `Info` from a `MutVar#` and rebuilds the entire constructor to update 2 fields (`historyLength`, `continueAsNewSuggested`) per activation.
- **Where:** `WorkflowInstance` dump :7576 (spot-checked on branch).
- **Fix:** move the two volatile fields into their own `IORef`s on `WorkflowInstance`; leave the immutable `Info` alone.
- **main:** `Info` record + activation apply are pre-existing, but `WorkflowInstance.hs` was heavily edited (641-line diff) → re-verify the rebuild exists on `main`.
- **Measure:** bytes/activation in replay macro harness.

### 5. Fold signal-handler double lookup into one  ·  HOT · S · Low · Med · main ⚠️
- **Root cause:** signal miss → second `lookup Nothing` → `insertWith` = 3 HashMap traversals per buffered signal.
- **Where:** `WorkflowInstance` dump :9127.
- **Fix:** single combined lookup path.
- **main:** signal handling pre-existing; `WorkflowInstance.hs` edited → re-verify.
- **Measure:** activation delivering many buffered signals with no registered handler.

---

## Tier 2 — Structural bets (benchmark before/after)

### 6. O(1)-append run queue  ·  HOT · M · Med risk · High conf · main ✅ (highest leverage)
- **Root cause:** `JobList` is a strict cons-list; `appendJobList` is O(n). Every `yield` appends one filler job to the tail of the whole queue; multi-waiter IVar fills splice woken waiters onto the tail → **O(N²)** under N yields. The only asymptotic problem in the codebase.
- **Where (confirmed on `main`** ✓**):** `Monad.hs:463-466` (`appendJobList`), `:386` (yield filler append), `Eval.hs:167-168, :242, :287`. Branch dump anchors: Monad :2856/:2923/:2894, Eval :663.
- **Fix:** O(1)-snoc structure — difference list (`JobList -> JobList`), Okasaki two-stack queue, or `Data.Sequence`.
- **Risk:** scheduler FIFO fairness + replay determinism must be preserved. Gate behind the timer benchmark + a replay-determinism test.
- **main:** pre-existing (Haxl-style scheduler); fully portable and a strong candidate to land on `main` independently.
- **Measure:** workflow with N sequential `sleep`/timer awaits (N = 10/100/1k/10k); `+RTS -s` total allocated should go super-linear→linear in N.

### 7. Inflight scheduler: stop re-polling the world  ·  HOT · M–L · Med · High · main ❌ (branch-exclusive)
- **Root cause:** `next` re-`traverse`s the whole `Seq` per poll, does O(n) `deleteAt`, and a second full fold to find the first-ready index; allocates a fresh IVar per still-blocked member per poll → O(N²) drain.
- **Where:** `Inflight` dump :645-2553, :2288-2292, :2305-2546, :517.
- **Fix:** partition ready/blocked into a separate queue (amortized O(1)); land the fresh-IVar fix in the same change.
- **main:** `Internal/Inflight.hs` does not exist on `main` (introduced by commit `357d9718`). **Do not port.**
- **Measure:** `mapConcurrently`/`sequenceConcurrently` over N staggered completions.

### 8. Defer CallStack construction to error path  ·  HOT · M · Med · Med-High · main ⚠️
- **Root cause:** every `Temporal.Workflow` combinator eagerly `PushCallStack` + `writeMutVar#` on the **success** path (14 write sites, 69 PushCallStack sites); `Eval.runWorkflow` builds 12 CallStack thunks per run (:700-759).
- **Fix:** store the stack lazily / build only on failure.
- **Risk:** keep error-report quality; replay/error paths need the stack intact.
- **main:** `RequireCallStack` plumbing pre-existing; `Workflow.hs` edited (335-line diff) → re-verify.

### 9. Specialize + strictify per-step arg encoding  ·  HOT · M · Low-Med · Med-High · main ⚠️
- **Root cause:** `Workflow.foldlArgs`/`withWorkflowArgs` thread `Codec`/`VarArgs` dicts, thunk each `IO Payload` through a lazy `Bundle Vector` + 3 `mapResult` layers, per argumented step.
- **Where:** `Workflow` dump :6216-6227, :6209-6215.
- **Fix:** SPECIALIZE Codec/VarArgs for concrete codecs; strict `generateM` + `unsafeFreeze`; bang per-arg encode.
- **main:** VarArgs/Codec arg encoding pre-existing; `Workflow.hs` edited → re-verify.
- **Measure:** payload-heavy activity args (e.g. 10 JSON args × 10k iterations).

---

## Tier 3 — Opportunistic (do when already in the file)

- **10. Per-suspend double-resume guard MutVar** — HOT · S · **Med-High risk** · main ❌. Fresh `newMutVar# False` + read/write per suspend to detect double-resume (`Monad` :1523, :1540-1545). Delimcc-specific (`DelimCC.hs` not on `main`). Do LAST; only weaken if the scheduler *structurally* guarantees single-resume; keep in debug builds.
- **11. Per-task container/record churn bundle** — HOT-WARM · main ⚠️. UNPACKed HashMap re-rooted per task (`Activity.Worker` :2646-2678; `Workflow.Worker` :812/:707), records re-`case`d field-by-field (:2280-2540), activity header maps converted per task though usually unread (:868-877), `drainCommands` `[Word32]` rebuild (`Instance` :210-213), `upsertMemo` Map spine rebuilt 2-3× (`Workflow` :2898-2934). Best single piece: lazy header conversion. The Activity.Worker pieces (4-line-diff file) are ~portable.
- **12. `nextXSequence` six-way clone + double scrutinee** — HOT(tiny) · main ⚠️. Six byte-identical workers, record cased twice each (`Instance` :326-495). Mostly code size; fold into a cleanup PR.
- **13. Exception failure-path allocs** — WARM · main ✅ (`Exception.hs` diff=0). `mkAnnotatedHandlers` rebuilds a doubled handler list (:4624); `annotationHandler` does 3 `partitionEithers . map` passes (:4494-4519). Only runs on failure.
- **14. `fetchLogs` + Worker complete/heartbeat** — main ✅ (sdk-core, diff=0). `Runtime.fetchLogs` builds an intermediate `Vector ByteString` then decodes in a 2nd pass (:33-142); Worker complete/heartbeat serialize via `toLazyByteString`+chunk-walk instead of the direct `encodeMessage` the client `call` path uses (`Core.Worker` :12320-12336 vs `Core.Client` :5137). Routing complete/heartbeat through `encodeMessage` is a cheap per-completion win.
- **15. Misc** — BoundedConcurrency re-derives `KnownNat` bound per call (branch-only, :2334); `SearchAttributes.toEncoding` via intermediate `Value` (main ✅, diff=0, :488-491); `sequenceConcurrently` dict dispatch (main ⚠️, :7651/:7710).

---

## Branch applicability summary

Established by diffing the delimited-continuation branch against `main` (merge-base `4794f167`).

- **Portable to `main` verbatim (diff=0 modules):** #2 (Common.Logging part), #3, #13, #14, #15 (SearchAttributes). Plus #1 for `Nexus/Worker.hs`.
- **Pre-existing on `main`, in edited files — port the fix, re-verify the site:** #1 (dispatch), #4, #5, #8, #9, #11, #12. **#6 confirmed present on `main`** (`Monad.hs:463`, `Eval.hs`) — highest-leverage and portable.
- **Branch-exclusive (do NOT port):** #7 (Inflight — module absent on `main`), #10 (double-resume guard — `DelimCC` absent on `main`).

Net: ~13 of 15 are not exclusive to the branch. Recommended to land the portable wins on
`main` as small orthogonal PRs; the delimcc branch inherits them on rebase/merge, and its
own net effect (#7/#10 + scheduler reshaping) shows up as a clean separate delta.

---

## Excluded / do-not-pursue (listed so we don't relitigate)

- **Entire client/control-plane cluster** — per-RPC, already well-optimized (zero list churn, proper W-W); residual cost is DEFERRED proto marshalling.
- **Cold registration/startup paths** — interceptor `<>` 17-field rebuild, `create` CallStack re-destructuring, `closeClient` MonadIO dict, KeyMap singleton at registration.
- **DEFERRED (out of scope by instruction):** all FFI marshalling (`cArrayToByteString` pinned copies, `$wcall` buffer pokes, `hs_*` bindings), proto ctor internals, otel-api Context key-hash caching.
- **Not bugs:** `absentError` vector-fusion artifacts, top-of-file inlined HashMap `Rec` blocks, scalar-selector reboxing in `Types`, unused `makeTokioAsyncCall4/3` mallocs.
- **Already done:** delete `Temporal.Coroutine` (dead since delimcc migration) — already removed on the branch.

---

## Measurement (see the profiling-harness work item next)

Three tiers, allocation-first:
- **Micro** (`tasty-bench`, reports allocations): payload encode/decode (#3, #9), one suspend→resume (#10), disabled `logDebug` (#2).
- **Scaling sweep** (parameterize N, plot alloc-vs-N): sequential timers → run queue (#6); `mapConcurrently` → Inflight (#7). O(N²)→O(N) ratio test is the acceptance bar.
- **Macro, replay-driven** (`Temporal.Replay` — diff=0, works on `main`): feed recorded histories into `handleActivation` bypassing network/FFI; headline = **bytes allocated per activation** (#1, #4).

Tooling: `tasty-bench` (allocation + baseline CSV for CI gating), `GHC.Stats` (`-T`) for
per-phase snapshots, `-fprof-late` for allocation attribution **without** perturbing
inlining/specialization (critical here — classic `-prof` would hide #1/#9). Gate CI on the
allocation column with a small threshold. Build benches at production opt level; pin the
baseline commit before any optimization PR.

## Recommended sequence

1. Stand up the profiling harness on `main` (macro replay + scaling sweep + micro), capture baseline at current tip.
2. Tier-1 quick wins as small PRs: #1 SPECIALIZE → #2 log gating → #3 payload metadata → #4 Info split (+ #5 signal lookup).
3. Structural bets behind benchmarks: #6 run queue → #7 Inflight (branch only).
4. #8 lazy CallStack + #11 churn bundle.
5. #10 double-resume guard last (branch only), keep in debug builds.
