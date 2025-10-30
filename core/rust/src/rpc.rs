use crate::client::{rpc_req, rpc_resp, CRPCError, ClientRef, RPCError, RpcCall, TemporalCall};
use crate::runtime::{Capability, HsCallback, MVar};
use ffi_convert::{CArray, CReprOf};
use temporal_client::OperatorService;
use temporal_client::TestService;
use temporal_client::WorkflowService;

// Helper to create a CRPCError with a fallback if conversion fails
fn make_rpc_error(err: String) -> CRPCError {
    CRPCError::c_repr_of(RPCError {
        code: 0,
        message: err.clone(),
        details: vec![],
    })
    .unwrap_or_else(|e| {
        eprintln!("Failed to convert RPC error '{}': {:?}", err, e);
        // Fallback: create an RPCError with empty message
        CRPCError::c_repr_of(RPCError {
            code: 0,
            message: String::new(),
            details: vec![],
        })
        .expect("Failed to create fallback RPC error")
    })
}

macro_rules! rpc_call {
    ($retry_client:ident, $call:ident, $call_name:ident) => {{
        if $call.retry {
            let req = rpc_req($call).map_err(|err| make_rpc_error(err))?;
            rpc_resp($retry_client.$call_name(req).await)
        } else {
            let req = rpc_req($call).map_err(|err| make_rpc_error(err))?;
            rpc_resp($retry_client.into_inner().$call_name(req).await)
        }
    }};
}

// TODO, these are all quite repetitive, can we generate them?
// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_count_workflow_executions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, count_workflow_executions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_create_schedule(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, create_schedule) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_delete_schedule(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, delete_schedule) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_deprecate_namespace(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, deprecate_namespace) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_describe_namespace(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, describe_namespace) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_describe_schedule(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, describe_schedule) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_describe_task_queue(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, describe_task_queue) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_describe_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, describe_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_cluster_info(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_cluster_info) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_search_attributes(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_search_attributes) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_system_info(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_system_info) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_worker_build_id_compatibility(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_worker_build_id_compatibility) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_workflow_execution_history(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_workflow_execution_history) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_workflow_execution_history_reverse(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_workflow_execution_history_reverse) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_archived_workflow_executions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_archived_workflow_executions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_closed_workflow_executions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_closed_workflow_executions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_namespaces(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_namespaces) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_open_workflow_executions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_open_workflow_executions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_schedule_matching_times(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_schedule_matching_times) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_schedules(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_schedules) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_task_queue_partitions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_task_queue_partitions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_workflow_executions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_workflow_executions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_patch_schedule(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, patch_schedule) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_poll_activity_task_queue(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, poll_activity_task_queue) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_poll_workflow_execution_update(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, poll_workflow_execution_update) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_poll_workflow_task_queue(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, poll_workflow_task_queue) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_query_workflow(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, query_workflow) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_record_activity_task_heartbeat(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, record_activity_task_heartbeat) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_record_activity_task_heartbeat_by_id(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, record_activity_task_heartbeat_by_id) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_register_namespace(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, register_namespace) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_request_cancel_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, request_cancel_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_reset_sticky_task_queue(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, reset_sticky_task_queue) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_reset_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, reset_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_activity_task_canceled(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_activity_task_canceled) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_activity_task_canceled_by_id(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_activity_task_canceled_by_id) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_activity_task_completed(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_activity_task_completed) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_activity_task_completed_by_id(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_activity_task_completed_by_id) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_activity_task_failed(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_activity_task_failed) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_activity_task_failed_by_id(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_activity_task_failed_by_id) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_query_task_completed(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_query_task_completed) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_workflow_task_completed(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_workflow_task_completed) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_respond_workflow_task_failed(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, respond_workflow_task_failed) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_scan_workflow_executions(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, scan_workflow_executions) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_signal_with_start_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, signal_with_start_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_signal_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, signal_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_start_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, start_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_terminate_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, terminate_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_update_namespace(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, update_namespace) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_update_schedule(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, update_schedule) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_update_workflow_execution(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, update_workflow_execution) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_update_worker_build_id_compatibility(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, update_worker_build_id_compatibility) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_get_current_time(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, get_current_time) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_lock_time_skipping(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, lock_time_skipping) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_sleep_until(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, sleep_until) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_sleep(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, sleep) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_unlock_time_skipping_with_sleep(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, unlock_time_skipping_with_sleep) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_unlock_time_skipping(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, unlock_time_skipping) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_add_or_update_remote_cluster(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, add_or_update_remote_cluster) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_add_search_attributes(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, add_search_attributes) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_delete_namespace(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, delete_namespace) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_clusters(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_clusters) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_list_search_attributes(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, list_search_attributes) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_remove_remote_cluster(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, remove_remote_cluster) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell <-> Tokio FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_remove_search_attributes(
    client: *mut ClientRef,
    c_call: *const RpcCall,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CRPCError,
    result_slot: *mut *mut CArray<u8>,
) {
    let client = unsafe { &mut *client };
    let mut retry_client = client.retry_client.clone();
    let call: TemporalCall = unsafe { (&*c_call).into() };

    let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback {
        cap,
        mvar,
        result_slot,
        error_slot,
    };
    client.runtime.future_result_into_hs(callback, async move {
        match rpc_call!(retry_client, call, remove_search_attributes) {
            Ok(resp) => CArray::c_repr_of(resp).map_err(|e| {
                eprintln!("Failed to convert response to CArray: {:?}", e);
                CRPCError::c_repr_of(RPCError {
                    code: 0,
                    message: format!("Failed to convert response: {:?}", e),
                    details: vec![],
                }).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error: {:?}", e);
                    CRPCError::c_repr_of(RPCError { code: 0, message: String::new(), details: vec![] }).expect("Failed to create fallback RPC error")
                })
            }),
            Err(err) => Err(err),
        }
    });
}
