use ffi_convert::{AsRust, CArray, CDrop, CDropError, CReprOf, RawBorrow, RawPointerConverter};
use libc::c_char;
use prost::Message;
use std::collections::{HashMap, HashSet};
use std::marker::PhantomData;
use std::str;
use std::sync::Arc;
use std::time::Duration;
use temporal_sdk_core::replay::{HistoryForReplay, ReplayWorkerInput};
use temporal_sdk_core::{
    ResourceBasedSlotsOptionsBuilder, ResourceSlotOptions,
    SlotSupplierOptions, TunerHolderOptionsBuilder,
};
use temporal_sdk_core_api::errors::{PollError, WorkflowErrorType};
use temporal_sdk_core_api::worker::{
    PollerBehavior, SlotKind, SlotInfoTrait, SlotMarkUsedContext, SlotReleaseContext,
    SlotReservationContext, SlotSupplier, SlotSupplierPermit, WorkerVersioningStrategy,
};
use temporal_sdk_core_api::Worker;
use temporal_sdk_core_protos::coresdk::workflow_completion::WorkflowActivationCompletion;
use temporal_sdk_core_protos::coresdk::{ActivityHeartbeat, ActivityTaskCompletion};
use temporal_sdk_core_protos::coresdk::nexus::NexusTaskCompletion;
use temporal_sdk_core_protos::temporal::api::history::v1::History;
use tokio::sync::mpsc::{Sender, channel};
use tokio_stream::wrappers::ReceiverStream;

use crate::client;
use crate::runtime::{self, Capability, HsCallback, MVar};
use serde::{Deserialize, Serialize};

// Helper macro to convert CWorkerError, falling back to a basic error on failure
macro_rules! to_c_worker_error {
    ($err:expr, $code:expr) => {{
        let code_val = $code;
        let err_val = $err;
        CWorkerError::c_repr_of(err_val).unwrap_or_else(|e| {
            eprintln!("Failed to convert worker error: {:?}", e);
            CWorkerError {
                code: code_val,
                message: std::ptr::null(),
            }
        })
    }};
}

pub struct WorkerRef {
    worker: Option<Arc<temporal_sdk_core::Worker>>,
    runtime: runtime::Runtime,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
#[serde(tag = "type")]
pub enum SlotSupplierConfig {
    #[serde(rename = "fixed_size")]
    FixedSize { slots: usize },
    #[serde(rename = "resource_based")]
    ResourceBased {
        minimum_slots: Option<usize>,
        maximum_slots: Option<usize>,
        ramp_throttle_ms: Option<u64>,
    },
    #[serde(rename = "custom")]
    Custom { handle: u64 },
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct ResourceBasedTunerConfig {
    pub target_memory_usage: f64,
    pub target_cpu_usage: f64,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct TunerConfig {
    pub workflow_slot_supplier: Option<SlotSupplierConfig>,
    pub activity_slot_supplier: Option<SlotSupplierConfig>,
    pub local_activity_slot_supplier: Option<SlotSupplierConfig>,
    pub resource_based_tuner_options: Option<ResourceBasedTunerConfig>,
}

impl TunerConfig {
    fn build_tuner_holder(self) -> Result<Box<dyn temporal_sdk_core_api::worker::WorkerTuner + Send + Sync>, WorkerError> {
        let resource_opts = self.resource_based_tuner_options.as_ref().map(|rbt| {
            ResourceBasedSlotsOptionsBuilder::default()
                .target_mem_usage(rbt.target_memory_usage)
                .target_cpu_usage(rbt.target_cpu_usage)
                .build()
                .expect("resource based slot options should not fail with just targets set")
        });

        let any_resource_based = matches!(self.workflow_slot_supplier, Some(SlotSupplierConfig::ResourceBased { .. }))
            || matches!(self.activity_slot_supplier, Some(SlotSupplierConfig::ResourceBased { .. }))
            || matches!(self.local_activity_slot_supplier, Some(SlotSupplierConfig::ResourceBased { .. }));

        if any_resource_based && resource_opts.is_none() {
            return Err(WorkerError {
                code: WorkerErrorCode::InvalidWorkerConfig,
                message: "resource_based_tuner_options must be set when any slot supplier is resource_based".to_string(),
            });
        }

        let mut builder = TunerHolderOptionsBuilder::default();

        if let Some(ref opts) = resource_opts {
            builder.resource_based_options(opts.clone());
        }

        if let Some(ref ss) = self.workflow_slot_supplier {
            builder.workflow_slot_options(to_slot_supplier_options(ss)?);
        }
        if let Some(ref ss) = self.activity_slot_supplier {
            builder.activity_slot_options(to_slot_supplier_options(ss)?);
        }
        if let Some(ref ss) = self.local_activity_slot_supplier {
            builder.local_activity_slot_options(to_slot_supplier_options(ss)?);
        }

        let tuner = builder.build_tuner_holder().map_err(|err| WorkerError {
            code: WorkerErrorCode::InvalidWorkerConfig,
            message: format!("Failed building tuner: {}", err),
        })?;

        Ok(Box::new(tuner))
    }
}

fn to_slot_supplier_options<SK: SlotKind + Send + Sync + 'static>(
    config: &SlotSupplierConfig,
) -> Result<SlotSupplierOptions<SK>, WorkerError>
where
    SK::Info: SlotInfoTrait,
{
    match config {
        SlotSupplierConfig::FixedSize { slots } => {
            Ok(SlotSupplierOptions::FixedSize { slots: *slots })
        }
        SlotSupplierConfig::ResourceBased {
            minimum_slots,
            maximum_slots,
            ramp_throttle_ms,
        } => Ok(SlotSupplierOptions::ResourceBased(
            ResourceSlotOptions::new(
                minimum_slots.unwrap_or(1),
                maximum_slots.unwrap_or(10_000),
                Duration::from_millis(ramp_throttle_ms.unwrap_or(50)),
            ),
        )),
        SlotSupplierConfig::Custom { handle } => {
            let inner_ptr = *handle as *const HaskellSlotSupplierInner;
            let inner = unsafe { &*inner_ptr };
            let supplier: HaskellSlotSupplier<SK> = HaskellSlotSupplier {
                inner: Arc::new(HaskellSlotSupplierInner {
                    reserve_fn: inner.reserve_fn,
                    try_reserve_fn: inner.try_reserve_fn,
                    mark_used_fn: inner.mark_used_fn,
                    release_fn: inner.release_fn,
                }),
                _phantom: PhantomData,
            };
            Ok(SlotSupplierOptions::Custom(Arc::new(supplier)))
        }
    }
}

// ---------------------------------------------------------------------------
// Custom (Haskell-supplied) SlotSupplier
// ---------------------------------------------------------------------------

/// Callback signatures that Haskell exports.
///
/// `reserve_slot`: called from async context. Haskell must fork a thread, do its work,
///   then call `hs_temporal_slot_reserve_complete(completion)` when ready.
///   `ctx_ptr`/`ctx_len` point to a JSON-encoded `SerializedSlotReservationContext`.
///   Haskell MUST copy the bytes before the callback returns (Rust frees them afterward).
///
/// `try_reserve_slot`: synchronous. Returns 1 if a slot was granted, 0 otherwise.
///
/// `mark_slot_used` / `release_slot`: fire-and-forget notifications with JSON-encoded info.
type ReserveSlotFn = unsafe extern "C" fn(ctx_ptr: *const u8, ctx_len: usize, completion: *mut SlotReserveCompletion);
type TryReserveSlotFn = unsafe extern "C" fn(ctx_ptr: *const u8, ctx_len: usize) -> i32;
type MarkSlotUsedFn = unsafe extern "C" fn(info_ptr: *const u8, info_len: usize);
type ReleaseSlotFn = unsafe extern "C" fn(info_ptr: *const u8, info_len: usize);

pub struct SlotReserveCompletion {
    sender: Option<tokio::sync::oneshot::Sender<()>>,
}

pub struct HaskellSlotSupplierInner {
    reserve_fn: ReserveSlotFn,
    try_reserve_fn: TryReserveSlotFn,
    mark_used_fn: MarkSlotUsedFn,
    release_fn: ReleaseSlotFn,
}

unsafe impl Send for HaskellSlotSupplierInner {}
unsafe impl Sync for HaskellSlotSupplierInner {}

struct HaskellSlotSupplier<SK: SlotKind> {
    inner: Arc<HaskellSlotSupplierInner>,
    _phantom: PhantomData<SK>,
}

unsafe impl<SK: SlotKind> Send for HaskellSlotSupplier<SK> {}
unsafe impl<SK: SlotKind> Sync for HaskellSlotSupplier<SK> {}

#[derive(Serialize)]
struct SerializedSlotReservationContext {
    task_queue: String,
    worker_identity: String,
    num_issued_slots: usize,
    is_sticky: bool,
}

impl SerializedSlotReservationContext {
    fn from_ctx(ctx: &dyn SlotReservationContext) -> Self {
        Self {
            task_queue: ctx.task_queue().to_string(),
            worker_identity: ctx.worker_identity().to_string(),
            num_issued_slots: ctx.num_issued_slots(),
            is_sticky: ctx.is_sticky(),
        }
    }
}

#[derive(Serialize)]
#[serde(tag = "type")]
enum SerializedSlotInfo {
    #[serde(rename = "workflow")]
    Workflow { workflow_type: String, is_sticky: bool },
    #[serde(rename = "activity")]
    Activity { activity_type: String },
    #[serde(rename = "local_activity")]
    LocalActivity { activity_type: String },
    #[serde(rename = "nexus")]
    Nexus { service: String, operation: String },
}

impl SerializedSlotInfo {
    fn from_info(info: temporal_sdk_core_api::worker::SlotInfo<'_>) -> Self {
        match info {
            temporal_sdk_core_api::worker::SlotInfo::Workflow(i) => Self::Workflow {
                workflow_type: i.workflow_type.clone(),
                is_sticky: i.is_sticky,
            },
            temporal_sdk_core_api::worker::SlotInfo::Activity(i) => Self::Activity {
                activity_type: i.activity_type.clone(),
            },
            temporal_sdk_core_api::worker::SlotInfo::LocalActivity(i) => Self::LocalActivity {
                activity_type: i.activity_type.clone(),
            },
            temporal_sdk_core_api::worker::SlotInfo::Nexus(i) => Self::Nexus {
                service: i.service.clone(),
                operation: i.operation.clone(),
            },
        }
    }
}

#[derive(Serialize)]
struct SerializedMarkUsedContext {
    slot_info: SerializedSlotInfo,
}

#[derive(Serialize)]
struct SerializedReleaseContext {
    slot_info: Option<SerializedSlotInfo>,
}

#[async_trait::async_trait]
impl<SK: SlotKind + 'static> SlotSupplier for HaskellSlotSupplier<SK>
where
    SK::Info: SlotInfoTrait,
{
    type SlotKind = SK;

    async fn reserve_slot(&self, ctx: &dyn SlotReservationContext) -> SlotSupplierPermit {
        let json = serde_json::to_vec(&SerializedSlotReservationContext::from_ctx(ctx))
            .expect("serialization should not fail");
        let (tx, rx) = tokio::sync::oneshot::channel();
        let completion = Box::into_raw(Box::new(SlotReserveCompletion { sender: Some(tx) }));

        unsafe { (self.inner.reserve_fn)(json.as_ptr(), json.len(), completion) };
        // json is alive until this point; Haskell must have copied the bytes synchronously.

        let _ = rx.await;
        SlotSupplierPermit::default()
    }

    fn try_reserve_slot(&self, ctx: &dyn SlotReservationContext) -> Option<SlotSupplierPermit> {
        let json = serde_json::to_vec(&SerializedSlotReservationContext::from_ctx(ctx))
            .expect("serialization should not fail");
        let result = unsafe { (self.inner.try_reserve_fn)(json.as_ptr(), json.len()) };
        if result != 0 {
            Some(SlotSupplierPermit::default())
        } else {
            None
        }
    }

    fn mark_slot_used(&self, ctx: &dyn SlotMarkUsedContext<SlotKind = SK>) {
        let info = SerializedSlotInfo::from_info(ctx.info().downcast());
        let json = serde_json::to_vec(&SerializedMarkUsedContext { slot_info: info })
            .expect("serialization should not fail");
        unsafe { (self.inner.mark_used_fn)(json.as_ptr(), json.len()) };
    }

    fn release_slot(&self, ctx: &dyn SlotReleaseContext<SlotKind = SK>) {
        let info = ctx.info().map(|i| SerializedSlotInfo::from_info(i.downcast()));
        let json = serde_json::to_vec(&SerializedReleaseContext { slot_info: info })
            .expect("serialization should not fail");
        unsafe { (self.inner.release_fn)(json.as_ptr(), json.len()) };
    }
}

/// Create a custom slot supplier handle from Haskell-supplied callback function pointers.
/// Returns a raw pointer that must be freed with `hs_temporal_drop_custom_slot_supplier`.
///
/// # Safety
///
/// Haskell FFI bridge invariants. All function pointers must remain valid for the
/// lifetime of the returned handle.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_new_custom_slot_supplier(
    reserve_fn: ReserveSlotFn,
    try_reserve_fn: TryReserveSlotFn,
    mark_used_fn: MarkSlotUsedFn,
    release_fn: ReleaseSlotFn,
) -> *mut HaskellSlotSupplierInner {
    Box::into_raw(Box::new(HaskellSlotSupplierInner {
        reserve_fn,
        try_reserve_fn,
        mark_used_fn,
        release_fn,
    }))
}

/// Free a custom slot supplier handle.
///
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_drop_custom_slot_supplier(
    handle: *mut HaskellSlotSupplierInner,
) {
    unsafe { drop(Box::from_raw(handle)) };
}

/// Called from Haskell when a `reserve_slot` request has been fulfilled.
/// Takes ownership of the completion handle.
///
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_slot_reserve_complete(
    completion: *mut SlotReserveCompletion,
) {
    let mut completion = unsafe { Box::from_raw(completion) };
    if let Some(sender) = completion.sender.take() {
        let _ = sender.send(());
    }
}

#[derive(Serialize, Deserialize)]
pub struct WorkerConfig {
    namespace: String,
    task_queue: String,
    build_id: String,
    identity_override: Option<String>,
    max_cached_workflows: usize,
    max_outstanding_workflow_tasks: usize,
    max_outstanding_activities: usize,
    max_outstanding_local_activities: usize,
    max_concurrent_workflow_task_polls: usize,
    nonsticky_to_sticky_poll_ratio: f32,
    max_concurrent_activity_task_polls: usize,
    no_remote_activities: bool,
    sticky_queue_schedule_to_start_timeout_millis: u64,
    max_heartbeat_throttle_interval_millis: u64,
    default_heartbeat_throttle_interval_millis: u64,
    max_activities_per_second: Option<f64>,
    max_task_queue_activities_per_second: Option<f64>,
    graceful_shutdown_period_millis: u64,
    nondeterminism_as_workflow_fail: bool,
    nondeterminism_as_workflow_fail_for_types: Vec<String>,
    tuner: Option<TunerConfig>,
    max_outstanding_nexus_tasks: Option<usize>,
    max_concurrent_nexus_task_polls: Option<usize>,
}

impl TryFrom<WorkerConfig> for temporal_sdk_core::WorkerConfig {
    type Error = WorkerError;

    fn try_from(conf: WorkerConfig) -> Result<Self, WorkerError> {
        let mut builder = temporal_sdk_core::WorkerConfigBuilder::default();
        builder
            .namespace(conf.namespace)
            .task_queue(conf.task_queue)
            .versioning_strategy(WorkerVersioningStrategy::None {
                build_id: conf.build_id,
            })
            .client_identity_override(conf.identity_override)
            .max_cached_workflows(conf.max_cached_workflows)
            .workflow_task_poller_behavior(PollerBehavior::SimpleMaximum(
                conf.max_concurrent_workflow_task_polls,
            ))
            .nonsticky_to_sticky_poll_ratio(conf.nonsticky_to_sticky_poll_ratio)
            .activity_task_poller_behavior(PollerBehavior::SimpleMaximum(
                conf.max_concurrent_activity_task_polls,
            ))
            .no_remote_activities(conf.no_remote_activities)
            .sticky_queue_schedule_to_start_timeout(Duration::from_millis(
                conf.sticky_queue_schedule_to_start_timeout_millis,
            ))
            .max_heartbeat_throttle_interval(Duration::from_millis(
                conf.max_heartbeat_throttle_interval_millis,
            ))
            .default_heartbeat_throttle_interval(Duration::from_millis(
                conf.default_heartbeat_throttle_interval_millis,
            ))
            .max_worker_activities_per_second(conf.max_activities_per_second)
            .max_task_queue_activities_per_second(conf.max_task_queue_activities_per_second)
            .graceful_shutdown_period(Duration::from_millis(conf.graceful_shutdown_period_millis))
            .workflow_failure_errors(if conf.nondeterminism_as_workflow_fail {
                HashSet::from([WorkflowErrorType::Nondeterminism])
            } else {
                HashSet::new()
            })
            .workflow_types_to_failure_errors(
                conf.nondeterminism_as_workflow_fail_for_types
                    .iter()
                    .map(|s| {
                        (
                            s.to_owned(),
                            HashSet::from([WorkflowErrorType::Nondeterminism]),
                        )
                    })
                    .collect::<HashMap<String, HashSet<WorkflowErrorType>>>(),
            )
            .nexus_task_poller_behavior(PollerBehavior::SimpleMaximum(
                conf.max_concurrent_nexus_task_polls.unwrap_or(5),
            ));

        if let Some(max) = conf.max_outstanding_nexus_tasks {
            builder.max_outstanding_nexus_tasks(max);
        }

        match conf.tuner {
            Some(tuner_config) => {
                let tuner = tuner_config.build_tuner_holder()?;
                builder.tuner(Arc::from(tuner));
            }
            None => {
                builder
                    .max_outstanding_workflow_tasks(conf.max_outstanding_workflow_tasks)
                    .max_outstanding_activities(conf.max_outstanding_activities)
                    .max_outstanding_local_activities(conf.max_outstanding_local_activities);
            }
        }

        builder.build().map_err(|err| WorkerError {
            code: WorkerErrorCode::InvalidWorkerConfig,
            message: format!("{}", err),
        })
    }
}

macro_rules! enter_sync {
    ($runtime:expr) => {
        let _trace_guard = $runtime.core.telemetry().trace_subscriber().map(|s| tracing::subscriber::set_default(s));
        let _guard = $runtime.core.tokio_handle().enter();
    };
}

#[repr(u8)]
#[derive(Copy, Clone, Debug)]
pub enum WorkerErrorCode {
    SDKError = 1,
    InitWorkerFailed = 2,
    InitReplayWorkerFailed = 3,
    InvalidProto = 4,
    ReplayWorkerClosed = 5,
    PollShutdownError = 6,
    PollFailure = 7,
    CompletionFailure = 8,
    InvalidWorkerConfig = 9,
}

impl AsRust<WorkerErrorCode> for WorkerErrorCode {
    fn as_rust(&self) -> Result<WorkerErrorCode, ffi_convert::AsRustError> {
        Ok(*self)
    }
}

impl CDrop for WorkerErrorCode {
    fn do_drop(&mut self) -> Result<(), CDropError> {
        Ok(())
    }
}

impl CReprOf<WorkerErrorCode> for WorkerErrorCode {
    fn c_repr_of(input: WorkerErrorCode) -> Result<WorkerErrorCode, ffi_convert::CReprOfError> {
        Ok(input)
    }
}

#[derive(Debug)]
pub struct WorkerError {
    code: WorkerErrorCode,
    message: String,
}

#[repr(C)]
#[derive(CReprOf, AsRust, RawPointerConverter, CDrop)]
#[target_type(WorkerError)]
pub struct CWorkerError {
    code: WorkerErrorCode,
    message: *const c_char,
}

struct FormattedError {
    message: String,
}

#[repr(C)]
#[derive(CReprOf, AsRust, RawPointerConverter, CDrop)]
#[target_type(FormattedError)]
pub struct CWorkerValidationError {
    message: *const c_char,
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_drop_worker_validation_error(
    err: *mut CWorkerValidationError,
) {
    unsafe { drop(CWorkerValidationError::from_raw_pointer_mut(err)) }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_drop_worker_error(err: *mut CWorkerError) {
    unsafe { drop(CWorkerError::from_raw_pointer_mut(err)) }
}

pub struct Unit {}
#[repr(C)]
#[derive(CReprOf, AsRust, RawPointerConverter, CDrop)]
#[target_type(Unit)]
pub struct CUnit {}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_drop_unit(unit: *mut CUnit) {
    unsafe { drop(CUnit::from_raw_pointer_mut(unit)) }
}

fn new_worker(client: &client::ClientRef, config: WorkerConfig) -> Result<WorkerRef, WorkerError> {
    enter_sync!(&client.runtime);
    let config: temporal_sdk_core::WorkerConfig = config.try_into()?;
    let worker = temporal_sdk_core::init_worker(
        &client.runtime.core,
        config,
        client.retry_client.clone().into_inner(),
    )
    .map_err(|err| WorkerError {
        code: WorkerErrorCode::InitWorkerFailed,
        message: format!("Failed creating worker: {}", err),
    })?;
    Ok(WorkerRef {
        worker: Some(Arc::new(worker)),
        runtime: client.runtime.clone(),
    })
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_drop_worker(worker: *mut WorkerRef) {
    unsafe { drop(Box::from_raw(worker)) }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_new_worker(
    client: *mut client::ClientRef,
    config: *const CArray<u8>,
    result_slot: *mut *mut WorkerRef,
    error_slot: *mut *mut CWorkerError,
) {
    let client_ref = match unsafe { client.as_ref() } {
        Some(c) => c,
        None => {
            eprintln!("FATAL: client pointer is null");
            unsafe {
                *result_slot = std::ptr::null_mut();
                *error_slot = std::ptr::null_mut();
            }
            return;
        }
    };

    let config_json = match unsafe { CArray::raw_borrow(config) } {
        Ok(json) => json,
        Err(e) => {
            eprintln!("Failed to borrow config: {:?}", e);
            let worker_error = WorkerError {
                code: WorkerErrorCode::InvalidWorkerConfig,
                message: format!("Failed to borrow config: {:?}", e),
            };
            unsafe {
                *error_slot = CWorkerError::c_repr_of(worker_error)
                    .unwrap_or_else(|e| {
                        eprintln!("Failed to convert worker error: {:?}", e);
                        CWorkerError { code: WorkerErrorCode::InvalidWorkerConfig, message: std::ptr::null() }
                    })
                    .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            return;
        }
    };

    let config_vec = match config_json.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert config: {:?}", e);
            let worker_error = WorkerError {
                code: WorkerErrorCode::InvalidWorkerConfig,
                message: format!("Failed to convert config: {:?}", e),
            };
            unsafe {
                *error_slot = CWorkerError::c_repr_of(worker_error)
                    .unwrap_or_else(|e| {
                        eprintln!("Failed to convert worker error: {:?}", e);
                        CWorkerError { code: WorkerErrorCode::InvalidWorkerConfig, message: std::ptr::null() }
                    })
                    .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            return;
        }
    };

    let config = serde_json::from_slice(&config_vec).map_err(|err| {
        WorkerError {
            code: WorkerErrorCode::InvalidWorkerConfig,
            message: format!("{}", err),
        }
    });

    match config {
        Ok(config) => {
            let result = new_worker(client_ref, config);
            match result {
                Ok(worker_ref) => {
                    unsafe { *result_slot = Box::into_raw(Box::new(worker_ref)) };
                }
                Err(worker_error) => {
                    eprintln!("Error: {:?}", worker_error);
                    unsafe {
                        *error_slot = CWorkerError::c_repr_of(worker_error)
                            .unwrap_or_else(|e| {
                                eprintln!("Failed to convert worker error: {:?}", e);
                                CWorkerError { code: WorkerErrorCode::InitWorkerFailed, message: std::ptr::null() }
                            })
                            .into_raw_pointer_mut()
                    };
                }
            }
        }
        Err(worker_error) => {
            eprintln!("Error: {:?}", worker_error);
            unsafe {
                *error_slot = CWorkerError::c_repr_of(worker_error)
                    .unwrap_or_else(|e| {
                        eprintln!("Failed to convert worker error: {:?}", e);
                        CWorkerError { code: WorkerErrorCode::InvalidWorkerConfig, message: std::ptr::null() }
                    })
                    .into_raw_pointer_mut()
            };
        }
    }
}

fn new_replay_worker(
    runtime_ref: &runtime::RuntimeRef,
    config: WorkerConfig,
) -> Result<(WorkerRef, HistoryPusher), WorkerError> {
    enter_sync!(runtime_ref.runtime);
    let config: temporal_sdk_core::WorkerConfig = config.try_into()?;
    let (history_pusher, stream) = HistoryPusher::new(runtime_ref.runtime.clone());
    let worker = WorkerRef {
        worker: Some(Arc::new(
            temporal_sdk_core::init_replay_worker(ReplayWorkerInput::new(config, stream)).map_err(
                |err| WorkerError {
                    code: WorkerErrorCode::InitReplayWorkerFailed,
                    message: format!("Failed creating replay worker: {}", err),
                },
            )?,
        )),
        runtime: runtime_ref.runtime.clone(),
    };

    Ok((worker, history_pusher))
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_new_replay_worker(
    runtime: *mut runtime::RuntimeRef,
    config: *const CArray<u8>,
    worker_slot: *mut *mut WorkerRef,
    history_slot: *mut *mut HistoryPusher,
    error_slot: *mut *mut CWorkerError,
) {
    let runtime_ref = match unsafe { runtime.as_ref() } {
        Some(r) => r,
        None => {
            eprintln!("FATAL: runtime pointer is null");
            unsafe {
                *worker_slot = std::ptr::null_mut();
                *history_slot = std::ptr::null_mut();
                *error_slot = std::ptr::null_mut();
            }
            return;
        }
    };

    let config_json = match unsafe { CArray::raw_borrow(config) } {
        Ok(json) => json,
        Err(e) => {
            eprintln!("Failed to borrow config: {:?}", e);
            let worker_error = WorkerError {
                code: WorkerErrorCode::InvalidWorkerConfig,
                message: format!("Failed to borrow config: {:?}", e),
            };
            unsafe {
                *error_slot = to_c_worker_error!(worker_error, WorkerErrorCode::InvalidWorkerConfig)
                    .into_raw_pointer_mut();
            }
            return;
        }
    };

    let config_vec = match config_json.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert config: {:?}", e);
            let worker_error = WorkerError {
                code: WorkerErrorCode::InvalidWorkerConfig,
                message: format!("Failed to convert config: {:?}", e),
            };
            unsafe {
                *error_slot = to_c_worker_error!(worker_error, WorkerErrorCode::InvalidWorkerConfig)
                    .into_raw_pointer_mut();
            }
            return;
        }
    };

    let config = serde_json::from_slice(&config_vec).map_err(|err| WorkerError {
        code: WorkerErrorCode::InvalidWorkerConfig,
        message: format!("{}", err),
    });

    match config {
        Ok(config) => {
            let result = new_replay_worker(runtime_ref, config);
            match result {
                Ok((worker_ref, history_pusher)) => unsafe {
                    *worker_slot = Box::into_raw(Box::new(worker_ref));
                    *history_slot = Box::into_raw(Box::new(history_pusher));
                },
                Err(worker_error) => {
                    unsafe {
                        *error_slot = to_c_worker_error!(worker_error, WorkerErrorCode::InitReplayWorkerFailed)
                            .into_raw_pointer_mut()
                    };
                }
            }
        }
        Err(worker_error) => {
            unsafe {
                *error_slot = to_c_worker_error!(worker_error, WorkerErrorCode::InvalidWorkerConfig)
                    .into_raw_pointer_mut()
            };
        }
    }
}

impl WorkerRef {
    fn poll_workflow_activation(&self, hs: HsCallback<CArray<u8>, CWorkerError>) {
        let worker = match self.worker.as_ref() {
            Some(w) => w.clone(),
            None => {
                eprintln!("Worker is None, returning error");
                let error = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: "Worker has been finalized".to_string(),
                    },
                    WorkerErrorCode::SDKError
                );
                hs.put_failure(&self.runtime, error);
                return;
            }
        };
        self.runtime.future_result_into_hs(hs, async move {
            let bytes = match worker.poll_workflow_activation().await {
                Ok(act) => Ok(act.encode_to_vec()),
                Err(PollError::ShutDown) => Err(WorkerError {
                    code: WorkerErrorCode::PollShutdownError,
                    message: "Poll shutdown error".to_string(),
                }),
                Err(err) => Err(WorkerError {
                    code: WorkerErrorCode::PollFailure,
                    message: format!("{}", err),
                }),
            };
            let c_bytes = bytes.map_err(|err| to_c_worker_error!(err, err.code))?;
            CArray::c_repr_of(c_bytes).map_err(|e| {
                eprintln!("Failed to convert bytes to CArray: {:?}", e);
                to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: format!("Failed to convert bytes: {:?}", e),
                    },
                    WorkerErrorCode::SDKError
                )
            })
        })
    }

    fn poll_activity_task(&self, hs: HsCallback<CArray<u8>, CWorkerError>) {
        let worker = match self.worker.as_ref() {
            Some(w) => w.clone(),
            None => {
                eprintln!("Worker is None, returning error");
                let error = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: "Worker has been finalized".to_string(),
                    },
                    WorkerErrorCode::SDKError
                );
                hs.put_failure(&self.runtime, error);
                return;
            }
        };
        self.runtime.future_result_into_hs(hs, async move {
            let bytes = match worker.poll_activity_task().await {
                Ok(task) => Ok(task.encode_to_vec()),
                Err(PollError::ShutDown) => Err(WorkerError {
                    code: WorkerErrorCode::PollShutdownError,
                    message: "Poll shutdown error".to_string(),
                }),
                Err(err) => Err(WorkerError {
                    code: WorkerErrorCode::PollFailure,
                    message: format!("Poll failure: {}", err),
                }),
            };
            let c_bytes = bytes.map_err(|err| to_c_worker_error!(err, err.code))?;
            CArray::c_repr_of(c_bytes).map_err(|e| {
                eprintln!("Failed to convert bytes to CArray: {:?}", e);
                to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: format!("Failed to convert bytes: {:?}", e),
                    },
                    WorkerErrorCode::SDKError
                )
            })
        })
    }

    fn complete_workflow_activation(
        &self,
        hs: HsCallback<CUnit, CWorkerError>,
        proto: &[u8],
    ) {
        let worker = match self.worker.as_ref() {
            Some(w) => w.clone(),
            None => {
                eprintln!("Worker is None, returning error");
                let error = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: "Worker has been finalized".to_string(),
                    },
                    WorkerErrorCode::SDKError
                );
                hs.put_failure(&self.runtime, error);
                return;
            }
        };
        let completion = WorkflowActivationCompletion::decode(proto);
        self.runtime.future_result_into_hs(hs, async move {
            let completion = completion.map_err(|err| {
                to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Invalid proto: {}", err),
                    },
                    WorkerErrorCode::InvalidProto
                )
            })?;
            worker
                .complete_workflow_activation(completion)
                .await
                .map_err(|err| {
                    to_c_worker_error!(
                        WorkerError {
                            code: WorkerErrorCode::CompletionFailure,
                            message: format!("{}", err),
                        },
                        WorkerErrorCode::CompletionFailure
                    )
                })?;
            Ok(CUnit {})
        })
    }

    fn complete_activity_task(&self, hs: HsCallback<CUnit, CWorkerError>, proto: &[u8]) {
        let worker = match self.worker.as_ref() {
            Some(w) => w.clone(),
            None => {
                eprintln!("Worker is None, returning error");
                let error = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: "Worker has been finalized".to_string(),
                    },
                    WorkerErrorCode::SDKError
                );
                hs.put_failure(&self.runtime, error);
                return;
            }
        };
        let completion = ActivityTaskCompletion::decode(proto);
        self.runtime.future_result_into_hs(hs, async move {
            let completion = completion.map_err(|err| {
                to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("{}", err),
                    },
                    WorkerErrorCode::InvalidProto
                )
            })?;
            worker
                .complete_activity_task(completion)
                .await
                .map_err(|err| {
                    to_c_worker_error!(
                        WorkerError {
                            code: WorkerErrorCode::CompletionFailure,
                            message: format!("{}", err),
                        },
                        WorkerErrorCode::CompletionFailure
                    )
                })?;
            Ok(CUnit {})
        })
    }

    fn poll_nexus_task(&self, hs: HsCallback<CArray<u8>, CWorkerError>) {
        let worker = self.worker.as_ref().unwrap().clone();
        self.runtime.future_result_into_hs(hs, async move {
            let bytes = match worker.poll_nexus_task().await {
                Ok(task) => Ok(task.encode_to_vec()),
                Err(PollError::ShutDown) => Err(WorkerError {
                    code: WorkerErrorCode::PollShutdownError,
                    message: "Poll shutdown error".to_string(),
                }),
                Err(err) => Err(WorkerError {
                    code: WorkerErrorCode::PollFailure,
                    message: format!("Poll failure: {}", err),
                }),
            };
            Ok(CArray::c_repr_of(bytes.map_err(|err| CWorkerError::c_repr_of(err).unwrap())?)
                .unwrap())
        })
    }

    fn complete_nexus_task(&self, hs: HsCallback<CUnit, CWorkerError>, proto: &[u8]) {
        let worker = self.worker.as_ref().unwrap().clone();
        let completion = NexusTaskCompletion::decode(proto);
        self.runtime.future_result_into_hs(hs, async move {
            let completion = completion.map_err(|err| {
                CWorkerError::c_repr_of(WorkerError {
                    code: WorkerErrorCode::InvalidProto,
                    message: format!("Invalid proto: {}", err),
                })
                .unwrap()
            })?;
            worker
                .complete_nexus_task(completion)
                .await
                .map_err(|err| {
                    CWorkerError::c_repr_of(WorkerError {
                        code: WorkerErrorCode::CompletionFailure,
                        message: format!("{}", err),
                    })
                    .unwrap()
                })?;
            Ok(CUnit {})
        })
    }

    fn record_activity_heartbeat(&self, proto: &[u8]) -> Result<(), WorkerError> {
        enter_sync!(self.runtime);
        let heartbeat = ActivityHeartbeat::decode(proto).map_err(|err| WorkerError {
            code: WorkerErrorCode::InvalidProto,
            message: format!("{}", err),
        });

        match self.worker.as_ref() {
            None => Ok(()),
            Some(worker) => {
                worker.record_activity_heartbeat(heartbeat?);
                // TODO return error
                Ok(())
            }
        }
    }

    fn request_workflow_eviction(&self, run_id: &str) {
        enter_sync!(self.runtime);
        if let Some(worker) = self.worker.as_ref() {
            worker.request_workflow_eviction(run_id);
        } else {
            eprintln!("Worker is None, cannot request workflow eviction");
        }
    }

    fn initiate_shutdown(&self) {
        if let Some(worker) = self.worker.as_ref() {
            let worker = worker.clone();
            worker.initiate_shutdown();
        } else {
            eprintln!("Worker is None, cannot initiate shutdown");
        }
    }

    fn finalize_shutdown(&mut self, hs: HsCallback<CUnit, CWorkerError>) {
        // Take the worker out of the option and leave None. This should be the
        // only reference remaining to the worker so try_unwrap will work.
        let worker_arc = match self.worker.take() {
            Some(w) => w,
            None => {
                eprintln!("Worker is None, returning error");
                let error = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: "Worker has already been finalized".to_string(),
                    },
                    WorkerErrorCode::SDKError
                );
                hs.put_failure(&self.runtime, error);
                return;
            }
        };

        let core_worker = match Arc::try_unwrap(worker_arc) {
            Ok(core_worker) => Ok(core_worker),
            Err(arc) => Err(WorkerError {
                code: WorkerErrorCode::SDKError,
                message: format!(
                    "Cannot finalize, expected 1 reference, got {}",
                    Arc::strong_count(&arc)
                ),
            }),
        };
        self.runtime.clone().future_result_into_hs(hs, async move {
            match core_worker {
                Ok(worker) => {
                    worker.finalize_shutdown().await;
                    Ok(CUnit {})
                }
                Err(err) => Err(to_c_worker_error!(err, err.code)),
            }
        })
    }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_validate_worker(
    worker: *mut WorkerRef,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerValidationError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &mut *worker };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };

    let w = match worker.worker.as_ref() {
        Some(w) => w.clone(),
        None => {
            eprintln!("Worker is None, returning error");
            let error = CWorkerValidationError::c_repr_of(FormattedError {
                message: "Worker has been finalized".to_string(),
            })
            .unwrap_or_else(|e| {
                eprintln!("Failed to convert validation error: {:?}", e);
                CWorkerValidationError {
                    message: std::ptr::null(),
                }
            });
            hs.put_failure(&worker.runtime, error);
            return;
        }
    };
    worker.runtime.future_result_into_hs(hs, async move {
        let result = w.validate().await;
        match result {
            Ok(()) => Ok(CUnit {}),
            Err(err) => Err(CWorkerValidationError::c_repr_of(FormattedError {
                message: format!("{}", err),
            })
            .unwrap_or_else(|e| {
                eprintln!("Failed to convert validation error: {:?}", e);
                CWorkerValidationError {
                    message: std::ptr::null(),
                }
            })),
        }
    })
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_poll_workflow_activation(
    worker: *mut WorkerRef,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CArray<u8>,
) {
    let worker = unsafe { &*worker };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.poll_workflow_activation(hs)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_poll_activity_task(
    worker: *mut WorkerRef,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CArray<u8>,
) {
    let worker = unsafe { &*worker };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.poll_activity_task(hs)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_complete_workflow_activation(
    worker: *mut WorkerRef,
    proto: *const CArray<u8>,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &*worker };
    let proto_array = match unsafe { CArray::raw_borrow(proto) } {
        Ok(arr) => arr,
        Err(e) => {
            eprintln!("Failed to borrow proto: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to borrow proto: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            worker.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let proto_vec = match proto_array.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert proto: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to convert proto: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            worker.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.complete_workflow_activation(hs, &proto_vec)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_complete_activity_task(
    worker: *mut WorkerRef,
    proto: *const CArray<u8>,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &*worker };
    let proto_array = match unsafe { CArray::raw_borrow(proto) } {
        Ok(arr) => arr,
        Err(e) => {
            eprintln!("Failed to borrow proto: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to borrow proto: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            worker.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let proto_vec = match proto_array.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert proto: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to convert proto: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            worker.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.complete_activity_task(hs, &proto_vec)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_poll_nexus_task(
    worker: *mut WorkerRef,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CArray<u8>,
) {
    let worker = unsafe { &*worker };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.poll_nexus_task(hs)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_complete_nexus_task(
    worker: *mut WorkerRef,
    proto: *const CArray<u8>,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &*worker };
    let proto: &CArray<u8> = unsafe { CArray::raw_borrow(proto).unwrap() };
    let proto: &[u8] = &proto.as_rust().unwrap().clone();
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.complete_nexus_task(hs, proto)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_record_activity_heartbeat(
    worker: *mut WorkerRef,
    proto: *const CArray<u8>,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &*worker };
    let proto_array = match unsafe { CArray::raw_borrow(proto) } {
        Ok(arr) => arr,
        Err(e) => {
            eprintln!("Failed to borrow proto: {:?}", e);
            let err = to_c_worker_error!(
                WorkerError {
                    code: WorkerErrorCode::InvalidProto,
                    message: format!("Failed to borrow proto: {:?}", e),
                },
                WorkerErrorCode::InvalidProto
            );
            unsafe {
                *error_slot = err.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            return;
        }
    };
    let proto_vec = match proto_array.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert proto: {:?}", e);
            let err = to_c_worker_error!(
                WorkerError {
                    code: WorkerErrorCode::InvalidProto,
                    message: format!("Failed to convert proto: {:?}", e),
                },
                WorkerErrorCode::InvalidProto
            );
            unsafe {
                *error_slot = err.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            return;
        }
    };
    let result = worker.record_activity_heartbeat(&proto_vec);
    match result {
        Ok(_) => unsafe {
            *error_slot = std::ptr::null_mut();
            *result_slot = std::ptr::null_mut();
        },
        Err(err) => {
            let err = to_c_worker_error!(err, err.code);
            unsafe {
                *error_slot = err.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
        }
    }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_request_workflow_eviction(
    worker: *mut WorkerRef,
    run_id: *const CArray<u8>,
) {
    let worker = unsafe { &*worker };
    let run_id_array = match unsafe { CArray::raw_borrow(run_id) } {
        Ok(arr) => arr,
        Err(e) => {
            eprintln!("Failed to borrow run_id: {:?}", e);
            return;
        }
    };
    let run_id_vec = match run_id_array.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert run_id: {:?}", e);
            return;
        }
    };
    let run_id_str = match str::from_utf8(&run_id_vec) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("Failed to convert run_id to UTF-8: {}", e);
            return;
        }
    };
    worker.request_workflow_eviction(run_id_str)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_initiate_shutdown(worker: *mut WorkerRef) {
    let worker = unsafe { &*worker };
    worker.initiate_shutdown()
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_worker_finalize_shutdown(
    worker: *mut WorkerRef,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &mut *worker };
    let hs = HsCallback {
        mvar,
        cap,
        error_slot,
        result_slot,
    };
    worker.finalize_shutdown(hs)
}

pub struct HistoryPusher {
    tx: Option<Sender<HistoryForReplay>>,
    runtime: runtime::Runtime,
}

impl HistoryPusher {
    fn new(runtime: runtime::Runtime) -> (Self, ReceiverStream<HistoryForReplay>) {
        let (tx, rx) = channel(1);
        (
            Self {
                tx: Some(tx),
                runtime,
            },
            ReceiverStream::new(rx),
        )
    }
}

impl HistoryPusher {
    fn push_history(
        &self,
        workflow_id: &str,
        history_proto: &[u8],
        hs: HsCallback<CUnit, CWorkerError>,
    ) {
        let history = History::decode(history_proto).map_err(|err| WorkerError {
            code: WorkerErrorCode::InvalidProto,
            message: format!("Invalid proto: {}", err),
        });
        self.send_history(workflow_id, history, hs)
    }

    fn push_history_json(
        &self,
        workflow_id: &str,
        history_json: &[u8],
        hs: HsCallback<CUnit, CWorkerError>,
    ) {
        let history = serde_json::from_slice::<History>(history_json).map_err(|err| WorkerError {
            code: WorkerErrorCode::InvalidProto,
            message: format!("Invalid history JSON: {}", err),
        });
        self.send_history(workflow_id, history, hs)
    }

    fn send_history(
        &self,
        workflow_id: &str,
        history: Result<History, WorkerError>,
        hs: HsCallback<CUnit, CWorkerError>,
    ) {
        let wfid = workflow_id.to_string();
        let tx = if let Some(tx) = self.tx.as_ref() {
            Ok(tx.clone())
        } else {
            Err(WorkerError {
                code: WorkerErrorCode::ReplayWorkerClosed,
                message: "Replay worker is no longer accepting new histories".to_string(),
            })
        };
        self.runtime.future_result_into_hs(hs, async move {
            let history = history.map_err(|err| to_c_worker_error!(err, err.code))?;
            let tx = tx.map_err(|err| to_c_worker_error!(err, err.code))?;

            tx.send(HistoryForReplay::new(history, wfid))
                .await
                .map_err(|_| {
                    to_c_worker_error!(
                        WorkerError {
                            code: WorkerErrorCode::SDKError,
                            message: "Channel for history replay was dropped, this is an SDK bug.".to_string(),
                        },
                        WorkerErrorCode::SDKError
                    )
                })?;
            Ok(CUnit {})
        })
    }

    fn close(&mut self) {
        self.tx.take();
    }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_history_pusher_push_history(
    history_pusher: *mut HistoryPusher,
    workflow_id: *const CArray<u8>,
    history_proto: *const CArray<u8>,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let history_pusher = unsafe { &mut *history_pusher };

    let wf_id_array = match unsafe { CArray::raw_borrow(workflow_id) } {
        Ok(arr) => arr,
        Err(e) => {
            eprintln!("Failed to borrow workflow_id: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to borrow workflow_id: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            history_pusher.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let wf_id_vec = match wf_id_array.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert workflow_id: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to convert workflow_id: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            history_pusher.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let wf_id_str = match str::from_utf8(&wf_id_vec) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("Failed to convert workflow_id to UTF-8: {}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to convert workflow_id to UTF-8: {}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            history_pusher.runtime.put_mvar(cap, mvar);
            return;
        }
    };

    let history_array = match unsafe { CArray::raw_borrow(history_proto) } {
        Ok(arr) => arr,
        Err(e) => {
            eprintln!("Failed to borrow history_proto: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to borrow history_proto: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            history_pusher.runtime.put_mvar(cap, mvar);
            return;
        }
    };
    let history_vec = match history_array.as_rust() {
        Ok(v) => v.clone(),
        Err(e) => {
            eprintln!("Failed to convert history_proto: {:?}", e);
            unsafe {
                *error_slot = to_c_worker_error!(
                    WorkerError {
                        code: WorkerErrorCode::InvalidProto,
                        message: format!("Failed to convert history_proto: {:?}", e),
                    },
                    WorkerErrorCode::InvalidProto
                )
                .into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            history_pusher.runtime.put_mvar(cap, mvar);
            return;
        }
    };

    history_pusher.push_history(
        wf_id_str,
        &history_vec,
        HsCallback {
            mvar,
            cap,
            error_slot,
            result_slot,
        },
    )
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_history_pusher_push_history_json(
    history_pusher: *mut HistoryPusher,
    workflow_id: *const CArray<u8>,
    history_json: *const CArray<u8>,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let history_pusher = unsafe { &mut *history_pusher };
    let workflow_id: &CArray<u8> = unsafe { CArray::raw_borrow(workflow_id).unwrap() };
    let workflow_id = workflow_id.as_rust().unwrap().clone();
    let workflow_id: &str = unsafe { str::from_utf8_unchecked(&workflow_id) };
    let history_json: &CArray<u8> = unsafe { CArray::raw_borrow(history_json).unwrap() };
    let history_json: &[u8] = &history_json.as_rust().unwrap().clone();
    history_pusher.push_history_json(
        workflow_id,
        history_json,
        HsCallback {
            mvar,
            cap,
            error_slot,
            result_slot,
        },
    )
}

/// Convert a protobuf-encoded History to canonical protobuf JSON.
/// Useful for testing the JSON replay path.
///
/// # Safety
///
/// `history_proto` must be a valid pointer to a CArray<u8> containing protobuf bytes.
/// `result_slot` and `error_slot` must be valid pointers to output slots.
/// On success, `*result_slot` is set to a heap-allocated CArray<u8> containing JSON bytes.
/// On failure, `*error_slot` is set to a heap-allocated CArray<u8> containing an error message.
/// The caller must free the returned CArray via `hs_temporal_drop_byte_array`.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_history_proto_to_json(
    history_proto: *const CArray<u8>,
    result_slot: *mut *mut CArray<u8>,
    error_slot: *mut *mut CArray<u8>,
) {
    let history_proto: &CArray<u8> = unsafe { CArray::raw_borrow(history_proto).unwrap() };
    let history_proto_bytes: Vec<u8> = history_proto.as_rust().unwrap().clone();

    match History::decode(history_proto_bytes.as_slice()) {
        Ok(history) => match serde_json::to_vec(&history) {
            Ok(json_bytes) => unsafe {
                *result_slot = CArray::c_repr_of(json_bytes)
                    .unwrap()
                    .into_raw_pointer_mut();
            },
            Err(err) => unsafe {
                *error_slot = CArray::c_repr_of(format!("JSON serialization failed: {}", err).into_bytes())
                    .unwrap()
                    .into_raw_pointer_mut();
            },
        },
        Err(err) => unsafe {
            *error_slot = CArray::c_repr_of(format!("Proto decode failed: {}", err).into_bytes())
                .unwrap()
                .into_raw_pointer_mut();
        },
    }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
///
/// The caller must ensure that the argument is a live pointer to a [`HistoryPusher`], typically from across the FFI
/// boundary after having been constructed by [`hs_temporal_new_replay_worker`].
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_history_pusher_close(history_pusher: *mut HistoryPusher) {
    let history_pusher = unsafe { &mut *history_pusher };
    history_pusher.close()
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
///
/// The caller must ensure that the argument is a live pointer to a [`HistoryPusher`], typically from across the FFI
/// boundary after having been constructed by [`hs_temporal_new_replay_worker`].
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_history_pusher_drop(history_pusher: *mut HistoryPusher) {
    let history_pusher = unsafe { Box::from_raw(history_pusher) };
    drop(history_pusher)
}
