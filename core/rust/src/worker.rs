use ffi_convert::{AsRust, CArray, CDrop, CDropError, CReprOf, RawBorrow, RawPointerConverter};
use libc::c_char;
use prost::Message;
use std::collections::{HashMap, HashSet};
use std::str;
use std::sync::Arc;
use std::time::Duration;
use temporal_sdk_core::replay::{HistoryForReplay, ReplayWorkerInput};
use temporal_sdk_core_api::errors::{PollError, WorkflowErrorType};
use temporal_sdk_core_api::worker::{WorkerDeploymentOptions, WorkerDeploymentVersion, WorkerVersioningStrategy as CoreWorkerVersioningStrategy};
use temporal_sdk_core_api::Worker;
use temporal_sdk_core_api::worker::PollerBehavior;
use temporal_sdk_core_protos::coresdk::workflow_completion::WorkflowActivationCompletion;
use temporal_sdk_core_protos::coresdk::{ActivityHeartbeat, ActivityTaskCompletion};
use temporal_sdk_core_protos::temporal::api::history::v1::History;
use temporal_sdk_core_protos::temporal::api::enums::v1::VersioningBehavior as CoreVersioningBehavior;
use tokio::sync::mpsc::{channel, Sender};
use tokio_stream::wrappers::ReceiverStream;

use crate::client;
use crate::runtime::{self, Capability, HsCallback, MVar};
use serde::{Deserialize, Serialize};

pub struct WorkerRef {
    worker: Option<Arc<temporal_sdk_core::Worker>>,
    runtime: runtime::Runtime,
}

#[derive(Serialize, Deserialize)]
pub enum WorkerPollerBehavior {
    SimpleMaximum(u64),
    Autoscaling {
        minimum: u64,
        maximum: u64,
        initial: u64,
    },
}

impl TryFrom<WorkerPollerBehavior> for PollerBehavior {
    type Error = WorkerError;

    fn try_from(behavior: WorkerPollerBehavior) -> Result<Self, WorkerError> {
        match behavior {
            WorkerPollerBehavior::SimpleMaximum(max) => {
                if max < 1 {
                    return Err(WorkerError {
                        code: WorkerErrorCode::InvalidWorkerConfig,
                        message: "SimpleMaximum poller behavior must be at least 1".to_string(),
                    });
                }
                Ok(PollerBehavior::SimpleMaximum(max as usize))
            }
            WorkerPollerBehavior::Autoscaling { minimum, maximum, initial } => {
                if minimum < 1 {
                    return Err(WorkerError {
                        code: WorkerErrorCode::InvalidWorkerConfig,
                        message: "Autoscaling minimum poller behavior must be at least 1".to_string(),
                    });
                }
                if maximum < minimum {
                    return Err(WorkerError {
                        code: WorkerErrorCode::InvalidWorkerConfig,
                        message: "Autoscaling maximum must be greater than or equal to minimum".to_string(),
                    });
                }
                if initial < minimum || initial > maximum {
                    return Err(WorkerError {
                        code: WorkerErrorCode::InvalidWorkerConfig,
                        message: "Autoscaling initial must be between minimum and maximum".to_string(),
                    });
                }
                Ok(PollerBehavior::Autoscaling {
                    minimum: minimum as usize,
                    maximum: maximum as usize,
                    initial: initial as usize,
                })
            }
        }
    }
}

#[derive(Serialize, Deserialize)]
pub enum WorkerVersioningStrategy {
    NoVersioning {
        build_id: String,
    },
    WorkerDeploymentBased {
        deployment_name: String,
        build_id: String,
        use_worker_versioning: bool,
        default_versioning_behavior: Option<VersioningBehavior>,
    },
    LegacyBuildIdBased {
        build_id: String,
    },
}

#[derive(Serialize, Deserialize)]
pub enum VersioningBehavior {
    Pinned,
    AutoUpgrade,
}

impl TryFrom<VersioningBehavior> for CoreVersioningBehavior {
    type Error = WorkerError;

    fn try_from(behavior: VersioningBehavior) -> Result<Self, WorkerError> {
        match behavior {
            VersioningBehavior::Pinned => Ok(CoreVersioningBehavior::Pinned),
            VersioningBehavior::AutoUpgrade => Ok(CoreVersioningBehavior::AutoUpgrade),
        }
    }
}

impl TryFrom<WorkerVersioningStrategy> for CoreWorkerVersioningStrategy {
    type Error = WorkerError;

    fn try_from(strategy: WorkerVersioningStrategy) -> Result<Self, WorkerError> {
        match strategy {
            WorkerVersioningStrategy::NoVersioning { build_id } => {
                Ok(CoreWorkerVersioningStrategy::None { build_id })
            }
            WorkerVersioningStrategy::WorkerDeploymentBased {
                deployment_name,
                build_id,
                use_worker_versioning,
                default_versioning_behavior,
            } => {
                let version = WorkerDeploymentVersion {
                    deployment_name,
                    build_id,
                };
                let behavior = default_versioning_behavior.map(|b| {
                    CoreVersioningBehavior::try_from(b)
                        .expect("Failed to convert versioning behavior")
                });
                Ok(CoreWorkerVersioningStrategy::WorkerDeploymentBased(
                    WorkerDeploymentOptions {
                        version,
                        use_worker_versioning,
                        default_versioning_behavior: behavior,
                    },
                ))
            }
            WorkerVersioningStrategy::LegacyBuildIdBased { build_id } => {
                if build_id.is_empty() {
                    return Err(WorkerError {
                        code: WorkerErrorCode::InvalidWorkerConfig,
                        message: "LegacyBuildIdBased versioning requires a non-empty build ID".to_string(),
                    });
                }
                Ok(CoreWorkerVersioningStrategy::LegacyBuildIdBased { build_id })
            }
        }
    }
}

#[derive(Serialize, Deserialize)]
pub struct WorkerConfig {
    namespace: String,
    task_queue: String,
    client_identity_override: Option<String>,
    max_cached_workflows: usize,
    // TODO tuner
    max_outstanding_workflow_tasks: usize,
    max_outstanding_activities: usize,
    max_outstanding_local_activities: usize,
    workflow_task_poller_behavior: WorkerPollerBehavior,
    nonsticky_to_sticky_poll_ratio: f32,
    activity_task_poller_behavior: WorkerPollerBehavior,
    no_remote_activities: bool,
    sticky_queue_schedule_to_start_timeout_millis: u64,
    max_heartbeat_throttle_interval_millis: u64,
    default_heartbeat_throttle_interval_millis: u64,
    max_task_queue_activities_per_second: Option<f64>,
    max_activities_per_second: Option<f64>,
    graceful_shutdown_period_millis: u64,
    nondeterminism_as_workflow_fail: bool,
    nondeterminism_as_workflow_fail_for_types: Vec<String>,
    ignore_evicts_on_shutdown: bool,
    fetching_concurrency: usize,
    local_timeout_buffer_for_activities_millis: u64,
    versioning_strategy: WorkerVersioningStrategy,
}

impl TryFrom<WorkerConfig> for temporal_sdk_core::WorkerConfig {
    type Error = WorkerError;

    fn try_from(conf: WorkerConfig) -> Result<Self, WorkerError> {
        let workflow_poller = PollerBehavior::try_from(conf.workflow_task_poller_behavior)?;
        let activity_poller = PollerBehavior::try_from(conf.activity_task_poller_behavior)?;
        let versioning_strategy = CoreWorkerVersioningStrategy::try_from(conf.versioning_strategy)?;

        temporal_sdk_core::WorkerConfigBuilder::default()
            .namespace(conf.namespace)
            .task_queue(conf.task_queue)
            .client_identity_override(conf.client_identity_override)
            .max_cached_workflows(conf.max_cached_workflows)
            .max_outstanding_workflow_tasks(conf.max_outstanding_workflow_tasks)
            .max_outstanding_activities(conf.max_outstanding_activities)
            .max_outstanding_local_activities(conf.max_outstanding_local_activities)
            .workflow_task_poller_behavior(workflow_poller)
            .nonsticky_to_sticky_poll_ratio(conf.nonsticky_to_sticky_poll_ratio)
            .activity_task_poller_behavior(activity_poller)
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
            .ignore_evicts_on_shutdown(conf.ignore_evicts_on_shutdown)
            .fetching_concurrency(conf.fetching_concurrency)
            .local_timeout_buffer_for_activities(Duration::from_millis(
                conf.local_timeout_buffer_for_activities_millis,
            ))
            .versioning_strategy(versioning_strategy)
            .build()
            .map_err(|err| WorkerError {
                code: WorkerErrorCode::InvalidWorkerConfig,
                message: format!("{}", err),
            })
    }
}

macro_rules! enter_sync {
    ($runtime:expr) => {
        if let Some(subscriber) = $runtime.core.telemetry().trace_subscriber() {
            temporal_sdk_core::telemetry::set_trace_subscriber_for_current_thread(subscriber);
        }
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
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_drop_worker_validation_error(
    err: *mut CWorkerValidationError,
) {
    unsafe { drop(CWorkerValidationError::from_raw_pointer_mut(err)) }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[no_mangle]
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
#[no_mangle]
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
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_drop_worker(worker: *mut WorkerRef) {
    unsafe { drop(Box::from_raw(worker)) }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_new_worker(
    client: *mut client::ClientRef,
    config: *const CArray<u8>,
    result_slot: *mut *mut WorkerRef,
    error_slot: *mut *mut CWorkerError,
) {
    let client_ref = unsafe { client.as_ref() }.expect("client is null");
    let config_json = unsafe { CArray::raw_borrow(config).unwrap() };
    let config = serde_json::from_slice(&config_json.as_rust().unwrap().clone()).map_err(|err| {
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
                            .unwrap()
                            .into_raw_pointer_mut()
                    };
                }
            }
        }
        Err(worker_error) => {
            eprintln!("Error: {:?}", worker_error);
            unsafe {
                *error_slot = CWorkerError::c_repr_of(worker_error)
                    .unwrap()
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
            )?),
        ),
        runtime: runtime_ref.runtime.clone(),
    };

    Ok((worker, history_pusher))
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_new_replay_worker(
    runtime: *mut runtime::RuntimeRef,
    config: *const CArray<u8>,
    worker_slot: *mut *mut WorkerRef,
    history_slot: *mut *mut HistoryPusher,
    error_slot: *mut *mut CWorkerError,
) {
    let runtime_ref = unsafe { runtime.as_ref() }.expect("client is null");
    let config_json = unsafe { CArray::raw_borrow(config).unwrap() };
    let config =
        serde_json::from_slice(&config_json.as_rust().unwrap()).map_err(|err| WorkerError {
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
                        *error_slot = CWorkerError::c_repr_of(worker_error)
                            .unwrap()
                            .into_raw_pointer_mut()
                    };
                }
            }
        }
        Err(worker_error) => {
            unsafe {
                *error_slot = CWorkerError::c_repr_of(worker_error)
                    .unwrap()
                    .into_raw_pointer_mut()
            };
        }
    }
}

impl WorkerRef {
    fn poll_workflow_activation(&self, hs: HsCallback<CArray<u8>, CWorkerError>) {
        let worker = self.worker.as_ref().unwrap().clone();
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
            Ok(
                CArray::c_repr_of(bytes.map_err(|err| CWorkerError::c_repr_of(err).unwrap())?)
                    .unwrap(),
            )
        })
    }

    fn poll_activity_task(&self, hs: HsCallback<CArray<u8>, CWorkerError>) {
        let worker = self.worker.as_ref().unwrap().clone();
        self.runtime.future_result_into_hs(hs, async move {
            let bytes = (match worker.poll_activity_task().await {
                Ok(task) => Ok(task.encode_to_vec()),
                Err(PollError::ShutDown) => Err(WorkerError {
                    code: WorkerErrorCode::PollShutdownError,
                    message: "Poll shutdown error".to_string(),
                }),
                Err(err) => Err(WorkerError {
                    code: WorkerErrorCode::PollFailure,
                    message: format!("Poll failure: {}", err),
                }),
            })
            .map_err(|err| CWorkerError::c_repr_of(err).unwrap());
            Ok(CArray::c_repr_of(bytes?).unwrap())
        })
    }

    fn complete_workflow_activation(
        &self,
        hs: HsCallback<CUnit, CWorkerError>,
        proto: &[u8],
    ) {
        let worker = self.worker.as_ref().unwrap().clone();
        let completion = WorkflowActivationCompletion::decode(proto);
        self.runtime.future_result_into_hs(hs, async move {
            let completion = completion.map_err(|err| {
                CWorkerError::c_repr_of(WorkerError {
                    code: WorkerErrorCode::InvalidProto,
                    message: format!("Invalid proto: {}", err),
                })
                .unwrap()
            })?;
            worker
                .complete_workflow_activation(completion)
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

    fn complete_activity_task(&self, hs: HsCallback<CUnit, CWorkerError>, proto: &[u8]) {
        let worker = self.worker.as_ref().unwrap().clone();
        let completion = ActivityTaskCompletion::decode(proto);
        self.runtime.future_result_into_hs(hs, async move {
            let completion = completion.map_err(|err| {
                CWorkerError::c_repr_of(WorkerError {
                    code: WorkerErrorCode::InvalidProto,
                    message: format!("{}", err),
                })
                .unwrap()
            })?;
            worker
                .complete_activity_task(completion)
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
        self.worker
            .as_ref()
            .unwrap()
            .request_workflow_eviction(run_id);
    }

    fn initiate_shutdown(&self) {
        let worker = self.worker.as_ref().unwrap().clone();
        worker.initiate_shutdown();
    }

    fn finalize_shutdown(&mut self, hs: HsCallback<CUnit, CWorkerError>) {
        // Take the worker out of the option and leave None. This should be the
        // only reference remaining to the worker so try_unwrap will work.
        let core_worker = match Arc::try_unwrap(self.worker.take().unwrap()) {
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
                Err(err) => Err(CWorkerError::c_repr_of(err).unwrap()),
            }
        })
    }
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[no_mangle]
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

    let w = worker.worker.as_ref().unwrap().clone();
    worker.runtime.future_result_into_hs(hs, async move {
        let result = w.validate().await;
        match result {
            Ok(()) => Ok(CUnit {}),
            Err(err) => Err(CWorkerValidationError::c_repr_of(FormattedError {
                message: format!("{}", err),
            })
            .unwrap()),
        }
    })
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[no_mangle]
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
#[no_mangle]
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
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_worker_complete_workflow_activation(
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
    worker.complete_workflow_activation(hs, proto)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_worker_complete_activity_task(
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
    worker.complete_activity_task(hs, proto)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_worker_record_activity_heartbeat(
    worker: *mut WorkerRef,
    proto: *const CArray<u8>,
    error_slot: *mut *mut CWorkerError,
    result_slot: *mut *mut CUnit,
) {
    let worker = unsafe { &*worker };
    let proto: &CArray<u8> = unsafe { CArray::raw_borrow(proto).unwrap() };
    let proto: &[u8] = &proto.as_rust().unwrap().clone();
    let result = worker.record_activity_heartbeat(proto);
    match result {
        Ok(_) => unsafe {
            *error_slot = std::ptr::null_mut();
            *result_slot = std::ptr::null_mut();
        },
        Err(err) => {
            let err = CWorkerError::c_repr_of(err).unwrap();
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
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_worker_request_workflow_eviction(
    worker: *mut WorkerRef,
    run_id: *const CArray<u8>,
) {
    let worker = unsafe { &*worker };
    let run_id: &CArray<u8> = unsafe { CArray::raw_borrow(run_id).unwrap() };
    let run_id: &[u8] = &run_id.as_rust().unwrap().clone();
    let run_id: &str = unsafe { str::from_utf8_unchecked(run_id) };
    worker.request_workflow_eviction(run_id)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_worker_initiate_shutdown(worker: *mut WorkerRef) {
    let worker = unsafe { &*worker };
    worker.initiate_shutdown()
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[no_mangle]
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
        let wfid = workflow_id.to_string();
        let tx = if let Some(tx) = self.tx.as_ref() {
            Ok(tx.clone())
        } else {
            Err(WorkerError {
                code: WorkerErrorCode::ReplayWorkerClosed,
                message: "Replay worker is no longer accepting new histories".to_string(),
            })
        };
        // We accept this doesn't have logging/tracing
        self.runtime.future_result_into_hs(hs, async move {
            let history = history.map_err(|err| CWorkerError::c_repr_of(err).unwrap())?;
            let tx = tx.map_err(|err| CWorkerError::c_repr_of(err).unwrap())?;

            tx.send(HistoryForReplay::new(history, wfid))
                .await
                .map_err(|_| {
                    CWorkerError::c_repr_of(WorkerError {
                        code: WorkerErrorCode::SDKError,
                        message: "Channel for history replay was dropped, this is an SDK bug.".to_string(),
                    })
                    .unwrap()
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
#[no_mangle]
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
    let workflow_id: &CArray<u8> = unsafe { CArray::raw_borrow(workflow_id).unwrap() };
    let workflow_id = workflow_id.as_rust().unwrap().clone();
    let workflow_id: &str = unsafe { str::from_utf8_unchecked(&workflow_id) };
    let history_proto: &CArray<u8> = unsafe { CArray::raw_borrow(history_proto).unwrap() };
    let history_proto: &[u8] = &history_proto.as_rust().unwrap().clone();
    history_pusher.push_history(
        workflow_id,
        history_proto,
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
/// Haskell FFI bridge invariants.
///
/// The caller must ensure that the argument is a live pointer to a [`HistoryPusher`], typically from across the FFI
/// boundary after having been constructed by [`hs_temporal_new_replay_worker`].
#[no_mangle]
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
#[no_mangle]
pub unsafe extern "C" fn hs_temporal_history_pusher_drop(history_pusher: *mut HistoryPusher) {
    let history_pusher = unsafe { Box::from_raw(history_pusher) };
    drop(history_pusher)
}
