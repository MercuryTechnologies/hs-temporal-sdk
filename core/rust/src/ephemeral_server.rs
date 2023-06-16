use temporal_sdk_core::ephemeral_server::*;
use crate::runtime::{RuntimeRef, Runtime, HsCallback, Capability, MVar};
use std::ffi::{CStr, c_char};
// I don't think we really care that much about blocking while we're starting
// up the server, so we can just block on the future.
use futures::executor::block_on;
use serde::Deserialize;
use ffi_convert::*;

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

  unsafe fn from_raw_pointer(ptr: *const EphemeralServerRef) -> Result<Self, UnexpectedNullPointerError> {
    take_back_from_raw_pointer(ptr)
  }

  unsafe fn from_raw_pointer_mut(ptr: *mut EphemeralServerRef) -> Result<Self, UnexpectedNullPointerError> {
    take_back_from_raw_pointer_mut(ptr)
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
    /// Log format and level
    pub log: (String, String),
    /// Additional arguments to Temporalite.
    pub extra_args: Vec<String>,
}

#[no_mangle]
pub extern "C" fn hs_temporal_start_dev_server(
  runtime: *mut RuntimeRef, 
  json_string: *const c_char, 
  mvar: *mut MVar, 
  cap: Capability, 
  error_slot: *mut*mut CArray<u8>, 
  result_slot: *mut*mut EphemeralServerRef
) {
  let runtime = *(unsafe { Box::from_raw(runtime) });
  let runtime = runtime.runtime;
  let mut de = serde_json::Deserializer::from_str(unsafe { std::str::from_utf8_unchecked(CStr::from_ptr(json_string).to_bytes()) });
  let conf = TemporalDevServerConfigDef::deserialize(&mut de).expect("Failed to deserialize config");
  let hs: HsCallback<EphemeralServerRef, CArray<u8>> = HsCallback { cap, mvar, error_slot, result_slot };
  let runtime_copy = runtime.clone();
  runtime.future_result_into_hs(hs, async move {
    let result = conf.start_server().await;
    match result {
      Ok(server) => Ok(EphemeralServerRef {
        server,
        runtime: runtime_copy,
      }),
      Err(e) => Err(CArray::c_repr_of(format!("Failed to start server: {}", e).into_bytes()).expect("Failed to convert error to CArray"))
    }
  })

}

#[no_mangle]
pub extern "C" fn hs_temporal_shutdown_ephemeral_server(server: *mut EphemeralServerRef) {
  let server_ref = unsafe { Box::from_raw(server) };
  let runtime = server_ref.runtime;
  let mut server = server_ref.server;
  let handle = runtime.core.tokio_handle();
  let _guard = handle.enter();
  let _result = handle.block_on(server.shutdown());
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

#[no_mangle]
pub extern "C" fn hs_temporal_start_test_server(json_string: *const c_char) -> *mut EphemeralServer {
  let mut de = serde_json::Deserializer::from_str(unsafe { std::str::from_utf8_unchecked(CStr::from_ptr(json_string).to_bytes()) });
  let conf = TemporalDevServerConfigDef::deserialize(&mut de).expect("Failed to deserialize config");
  let server = conf.start_server();
  Box::into_raw(Box::new(block_on(server).unwrap()))
}
