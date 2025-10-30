use ffi_convert::{AsRust, CArray, CDrop, CDropError, CReprOf, RawBorrow, RawPointerConverter};
use libc::c_char;
use prost::Message;
use std::collections::{HashMap, HashSet};
use std::str;
use std::sync::Arc;
use std::time::Duration;
use temporal_sdk_core::replay::{HistoryForReplay, ReplayWorkerInput};
use temporal_sdk_core_api::errors::{PollError, WorkflowErrorType};
use temporal_sdk_core_api::Worker;
use temporal_sdk_core_protos::coresdk::workflow_completion::WorkflowActivationCompletion;
use temporal_sdk_core_protos::coresdk::{ActivityHeartbeat, ActivityTaskCompletion};
use temporal_sdk_core_protos::temporal::api::history::v1::History;
use tokio::sync::mpsc::{channel, Sender};
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
}

impl TryFrom<WorkerConfig> for temporal_sdk_core::WorkerConfig {
    type Error = WorkerError;

    fn try_from(conf: WorkerConfig) -> Result<Self, WorkerError> {
        temporal_sdk_core::WorkerConfigBuilder::default()
            .namespace(conf.namespace)
            .task_queue(conf.task_queue)
            .worker_build_id(conf.build_id)
            .client_identity_override(conf.identity_override)
            .max_cached_workflows(conf.max_cached_workflows)
            .max_outstanding_workflow_tasks(conf.max_outstanding_workflow_tasks)
            .max_outstanding_activities(conf.max_outstanding_activities)
            .max_outstanding_local_activities(conf.max_outstanding_local_activities)
            .max_concurrent_wft_polls(conf.max_concurrent_workflow_task_polls)
            .nonsticky_to_sticky_poll_ratio(conf.nonsticky_to_sticky_poll_ratio)
            .max_concurrent_at_polls(conf.max_concurrent_activity_task_polls)
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
            // Even though grace period is optional, if it is not set then the
            // auto-cancel-activity behavior of shutdown will not occur, so we
            // always set it even if 0.
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
