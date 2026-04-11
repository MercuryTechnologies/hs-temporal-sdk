use crate::runtime::{Capability, HsCallback, MVar, Runtime, RuntimeRef};
use crate::worker::{CUnit, Unit};
use ffi_convert::*;
use serde::Deserialize;
use std::ffi::{c_char, CStr};
use std::time::Duration;
use temporal_sdk_core::ephemeral_server::*;

pub struct EphemeralServerRef {
    pub(crate) server: EphemeralServer,
    runtime: Runtime,
}

impl RawPointerConverter<EphemeralServerRef> for EphemeralServerRef {
    fn into_raw_pointer(self) -> *const EphemeralServerRef {
        convert_into_raw_pointer(self)
    }

    fn into_raw_pointer_mut(self) -> *mut EphemeralServerRef {
        convert_into_raw_pointer_mut(self)
    }

    unsafe fn from_raw_pointer(
        ptr: *const EphemeralServerRef,
    ) -> Result<Self, UnexpectedNullPointerError> {
        unsafe { take_back_from_raw_pointer(ptr) }
    }

    unsafe fn from_raw_pointer_mut(
        ptr: *mut EphemeralServerRef,
    ) -> Result<Self, UnexpectedNullPointerError> {
        unsafe { take_back_from_raw_pointer_mut(ptr) }
    }
}

/// Where to find an executable. Can be a path or download.
#[derive(Deserialize)]
#[serde(tag = "type", content = "contents", remote = "EphemeralExe")]
pub enum EphemeralExeDef {
    /// Existing path on the filesystem for the executable.
    ExistingPath(String),
    /// Download the executable if not already there.
    CachedDownload {
        /// Which version to download.
        #[serde(with = "EphemeralExeVersionDef")]
        version: EphemeralExeVersion,
        /// Destination directory or the user temp directory if none set.
        dest_dir: Option<String>,
        ttl: Option<Duration>
    },
}

/// Which version of the exe to download.
#[derive(Deserialize)]
#[serde(tag = "type", content = "contents", remote = "EphemeralExeVersion")]
pub enum EphemeralExeVersionDef {
    /// Use a default version for the given SDK name and version.
    SDKDefault {
        /// Name of the SDK to get the default for.
        sdk_name: String,
        /// Version of the SDK to get the default for.
        sdk_version: String,
    },
    /// Specific version.
    Fixed(String),
}

#[derive(Deserialize)]
#[serde(remote = "TemporalDevServerConfig")]
pub struct TemporalDevServerConfigDef {
    /// Required path to executable or download info.
    #[serde(with = "EphemeralExeDef")]
    pub exe: EphemeralExe,
    /// Namespace to use.
    pub namespace: String,
    /// IP to bind to.
    pub ip: String,
    /// Port to use or obtains a free one if none given.
    pub port: Option<u16>,
    /// Sqlite DB filename if persisting or non-persistent if none.
    pub db_filename: Option<String>,
    /// Whether to enable the UI.
    pub ui: bool,
    /// What port to run the UI on.
    pub ui_port: Option<u16>,
    /// Log format and level
    pub log: (String, String),
    /// Additional arguments to Temporalite.
    pub extra_args: Vec<String>,
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_start_dev_server(
    runtime: *mut RuntimeRef,
    json_string: *const c_char,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CArray<u8>,
    result_slot: *mut *mut EphemeralServerRef,
) {
    let runtime_ref = match unsafe { runtime.as_ref() } {
        Some(r) => r,
        None => {
            eprintln!("FATAL: runtime pointer is null");
            unsafe {
                *error_slot = std::ptr::null_mut();
                *result_slot = std::ptr::null_mut();
            }
            return;
        }
    };
    let runtime = &runtime_ref.runtime;

    let json_bytes = unsafe { CStr::from_ptr(json_string).to_bytes() };
    let json_str = match std::str::from_utf8(json_bytes) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("Failed to parse JSON string as UTF-8: {}", e);
            let err_msg = format!("Failed to parse JSON string as UTF-8: {}", e).into_bytes();
            let err_array = CArray::c_repr_of(err_msg).unwrap_or_else(|e| {
                eprintln!("Failed to convert error message: {:?}", e);
                CArray { data_ptr: std::ptr::null_mut(), size: 0 }
            });
            unsafe {
                *error_slot = err_array.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            runtime.put_mvar(cap, mvar);
            return;
        }
    };

    let mut de = serde_json::Deserializer::from_str(json_str);
    let conf = match TemporalDevServerConfigDef::deserialize(&mut de) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("Failed to deserialize config: {}", e);
            let err_msg = format!("Failed to deserialize config: {}", e).into_bytes();
            let err_array = CArray::c_repr_of(err_msg).unwrap_or_else(|e| {
                eprintln!("Failed to convert error message: {:?}", e);
                CArray { data_ptr: std::ptr::null_mut(), size: 0 }
            });
            unsafe {
                *error_slot = err_array.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            runtime.put_mvar(cap, mvar);
            return;
        }
    };

    let hs: HsCallback<EphemeralServerRef, CArray<u8>> = HsCallback {
        cap,
        mvar,
        error_slot,
        result_slot,
    };
    runtime.future_result_into_hs(hs, async move {
        let result = conf.start_server().await;
        match result {
            Ok(server) => Ok(EphemeralServerRef {
                server,
                runtime: runtime.clone(),
            }),
            Err(e) => Err(
                CArray::c_repr_of(format!("Failed to start server: {}", e).into_bytes())
                    .unwrap_or_else(|e| {
                        eprintln!("Failed to convert error to CArray: {:?}", e);
                        CArray { data_ptr: std::ptr::null_mut(), size: 0 }
                    }),
            ),
        }
    })
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_shutdown_ephemeral_server(
    server: *mut EphemeralServerRef,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CArray<u8>,
    result_slot: *mut *mut CUnit,
) {
    let server_ref = unsafe { Box::from_raw(server) };
    let mut server = server_ref.server;
    let hs: HsCallback<CUnit, CArray<u8>> = HsCallback {
        cap,
        mvar,
        error_slot,
        result_slot,
    };
    server_ref.runtime.future_result_into_hs(hs, async move {
        let result = server.shutdown().await;
        match result {
            Ok(()) => CUnit::c_repr_of(Unit {}).map_err(|e| {
                eprintln!("Failed to convert CUnit: {:?}", e);
                CArray::c_repr_of(b"Failed to convert result".to_vec()).unwrap_or_else(|e| {
                    eprintln!("Failed to convert error message: {:?}", e);
                    CArray { data_ptr: std::ptr::null_mut(), size: 0 }
                })
            }),
            Err(e) => Err(CArray::c_repr_of(
                format!("Failed to shutdown server: {}", e).into_bytes(),
            )
            .unwrap_or_else(|e| {
                eprintln!("Failed to convert error to CArray: {:?}", e);
                CArray { data_ptr: std::ptr::null_mut(), size: 0 }
            })),
        }
    })
}

/// Configuration for the test server.
#[derive(Deserialize)]
#[serde(remote = "TestServerConfig")]
pub struct TestServerConfigDef {
    /// Required path to executable or download info.
    #[serde(with = "EphemeralExeDef")]
    pub exe: EphemeralExe,
    /// Port to use or obtains a free one if none given.
    pub port: Option<u16>,
    /// Additional arguments to the test server.
    pub extra_args: Vec<String>,
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_start_test_server(
    runtime: *mut RuntimeRef,
    json_string: *const c_char,
    mvar: *mut MVar,
    cap: Capability,
    error_slot: *mut *mut CArray<u8>,
    result_slot: *mut *mut EphemeralServerRef,
) {
    let runtime_ref = match unsafe { runtime.as_ref() } {
        Some(r) => r,
        None => {
            eprintln!("FATAL: runtime pointer is null");
            unsafe {
                *error_slot = std::ptr::null_mut();
                *result_slot = std::ptr::null_mut();
            }
            return;
        }
    };
    let runtime = &runtime_ref.runtime;

    let json_bytes = unsafe { CStr::from_ptr(json_string).to_bytes() };
    let json_str = match std::str::from_utf8(json_bytes) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("Failed to parse JSON string as UTF-8: {}", e);
            let err_msg = format!("Failed to parse JSON string as UTF-8: {}", e).into_bytes();
            let err_array = CArray::c_repr_of(err_msg).unwrap_or_else(|e| {
                eprintln!("Failed to convert error message: {:?}", e);
                CArray { data_ptr: std::ptr::null_mut(), size: 0 }
            });
            unsafe {
                *error_slot = err_array.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            runtime.put_mvar(cap, mvar);
            return;
        }
    };

    let mut de = serde_json::Deserializer::from_str(json_str);
    let conf = match TestServerConfigDef::deserialize(&mut de) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("Failed to deserialize config: {}", e);
            let err_msg = format!("Failed to deserialize config: {}", e).into_bytes();
            let err_array = CArray::c_repr_of(err_msg).unwrap_or_else(|e| {
                eprintln!("Failed to convert error message: {:?}", e);
                CArray { data_ptr: std::ptr::null_mut(), size: 0 }
            });
            unsafe {
                *error_slot = err_array.into_raw_pointer_mut();
                *result_slot = std::ptr::null_mut();
            }
            runtime.put_mvar(cap, mvar);
            return;
        }
    };

    let hs: HsCallback<EphemeralServerRef, CArray<u8>> = HsCallback {
        cap,
        mvar,
        error_slot,
        result_slot,
    };
    runtime.future_result_into_hs(hs, async move {
        let result = conf.start_server().await;
        match result {
            Ok(server) => Ok(EphemeralServerRef {
                server,
                runtime: runtime.clone(),
            }),
            Err(e) => Err(
                CArray::c_repr_of(format!("Failed to start server: {}", e).into_bytes())
                    .unwrap_or_else(|e| {
                        eprintln!("Failed to convert error to CArray: {:?}", e);
                        CArray { data_ptr: std::ptr::null_mut(), size: 0 }
                    }),
            ),
        }
    })
}
