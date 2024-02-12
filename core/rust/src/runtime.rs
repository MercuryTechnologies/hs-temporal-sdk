use std::collections::HashMap;
use ffi_convert::*;
use temporal_sdk_core::{CoreRuntime};
use temporal_sdk_core::telemetry::{construct_filter_string};
use temporal_sdk_core_api::telemetry::{CoreTelemetry, TelemetryOptions, TelemetryOptionsBuilder, Logger};
use std::sync::Arc;
use std::os::raw::c_int;
use std::future::Future;
use std::time::SystemTime;
use serde::Serialize;
use tracing::Level;

pub struct RuntimeRef {
  pub(crate) runtime: Runtime,
}

#[derive(Clone)]
pub(crate) struct Runtime {
  pub(crate) core: Arc<CoreRuntime>,
  pub(crate) try_put_mvar: extern fn(capability: Capability, mvar: *mut MVar) -> (),
}

fn init_runtime(telemetry_config: TelemetryOptions, try_put_mvar: extern fn(capability: Capability, mvar: *mut MVar) -> ()) -> Box<RuntimeRef> {
  let runtime = CoreRuntime::new(
    telemetry_config,
    tokio::runtime::Builder::new_multi_thread(),
  );

  // TODO need to figure out how to handle errors here
  Box::new(
    RuntimeRef {
      runtime: Runtime {
        core: Arc::new(runtime.unwrap()),
        try_put_mvar
      },
    }
  )
}

#[no_mangle]
pub extern "C" fn hs_temporal_init_runtime(try_put_mvar: extern fn(Capability, *mut MVar) -> ()) -> *mut RuntimeRef {
  Box::into_raw(init_runtime(
    TelemetryOptionsBuilder::default()
      .logging(Logger::Forward {
        filter: construct_filter_string(Level::TRACE, Level::ERROR),
      })
      .build()
      .unwrap()
    , try_put_mvar
    )
  )
}

fn safe_drop_runtime(runtime: Box<RuntimeRef>) {
  drop(runtime)
}

#[no_mangle]
pub unsafe extern fn hs_temporal_free_runtime(runtime: *mut RuntimeRef) {
  safe_drop_runtime(Box::from_raw(runtime));
}

#[repr(C)]
pub struct MVar {
    _data: [u8; 0],
    _marker:
        core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
}

#[repr(C)]
pub struct Capability {
  pub cap_num: c_int
}


pub struct HsCallback<A, E> {
  pub cap: Capability,
  pub mvar: *mut MVar,
  pub result_slot: *mut*mut A,
  pub error_slot: *mut*mut E,
}

impl <A, E> HsCallback<A, E> {
  pub(crate) fn put_success(self, runtime: &Runtime, result: A) 
  where
    A: RawPointerConverter<A>,
  {
    unsafe {
      *self.result_slot = result.into_raw_pointer_mut();
      *self.error_slot = std::ptr::null_mut();
      runtime.put_mvar(self.cap, self.mvar);
    }
  }

  pub(crate) fn put_failure(self, runtime: &Runtime, error: E) 
  where
    E: RawPointerConverter<E>,
  {
    unsafe {
      *self.error_slot = error.into_raw_pointer_mut();
      *self.result_slot = std::ptr::null_mut();
      runtime.put_mvar(self.cap, self.mvar);
    }
  }

  pub(crate) fn put_result(self, runtime: &Runtime, result: Result<A, E>) 
  where
    A: RawPointerConverter<A>,
    E: RawPointerConverter<E>,
  {
    match result {
      Ok(result) => self.put_success(runtime, result),
      Err(error) => self.put_failure(runtime, error),
    }
  }
}

impl Runtime {
  // pub fn future_into_hs<F, T>(&self, callback: HsCallback<T, ()>, fut: F)
  // where
  //     F: Future<Output = T> + Send + 'static,
  //     T: RawPointerConverter<T>
  // {
  //   let handle = self.core.tokio_handle();
  //   let _guard = handle.enter();
  //   let result = handle.block_on(fut);
  //   callback.put_success(result);
  // }

  pub fn future_result_into_hs<F, T, E>(&self, callback: HsCallback<T, E>, fut: F)
  where
      F: Future<Output = Result<T, E>> + Send + 'static,
      T: RawPointerConverter<T>,
      E: RawPointerConverter<E>
  {
    let handle = self.core.tokio_handle();
    let _guard = handle.enter();
    let result = handle.block_on(fut);
    callback.put_result(self, result);
  }

  pub fn put_mvar(&self, capability: Capability, mvar: *mut MVar) {
    (self.try_put_mvar)(capability, mvar);
  }
}

#[no_mangle]
pub extern fn hs_temporal_drop_byte_array(str: *const CArray<u8>) {
  unsafe {
    drop(CArray::from_raw_pointer(str));
  }
}

#[derive(Serialize)]
pub struct CoreLogDef {
  pub target: String,
  pub message: String,
  pub timestamp: SystemTime,
  pub level: String,
  pub fields: HashMap<String, serde_json::Value>,
  pub span_contexts: Vec<String>
}

#[no_mangle]
pub extern "C" fn hs_temporal_runtime_fetch_logs(
  runtime: *mut RuntimeRef,
) -> *const CArray<CArray<u8>> {
  let runtime = unsafe { &*runtime };
  let logs = runtime.runtime.core.telemetry().fetch_buffered_logs();
  let hs_logs: Vec<Vec<u8>> = logs.iter().map(|log| {
    let log = CoreLogDef {
      target: log.target.clone(),
      message: log.message.clone(),
      timestamp: log.timestamp,
      level: String::from(log.level.as_str()),
      fields: log.fields.clone(),
      span_contexts: log.span_contexts.clone()
    };
    serde_json::to_vec(&log).expect("Failed to serialize log line")
  }).collect();
  CArray::c_repr_of(hs_logs).unwrap().into_raw_pointer()
}

#[no_mangle]
pub extern "C" fn hs_temporal_runtime_free_logs(
  logs: *const CArray<CArray<u8>>
) {
  unsafe {
    drop(CArray::from_raw_pointer(logs));
  }
}
