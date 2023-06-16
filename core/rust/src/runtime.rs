use ffi_convert::{CArray, RawPointerConverter};
use temporal_sdk_core::CoreRuntime;
use temporal_sdk_core_api::telemetry::{TelemetryOptions, TelemetryOptionsBuilder};
use std::sync::Arc;
use std::os::raw::c_int;
use std::future::Future;

pub struct RuntimeRef {
  pub(crate) runtime: Runtime,
}

#[derive(Clone)]
pub(crate) struct Runtime {
  pub(crate) core: Arc<CoreRuntime>,
}

// Strings that we have sent to Haskell
pub type HaskellText = CArray<u8>;

fn safe_init_runtime(telemetry_config: TelemetryOptions) -> Box<RuntimeRef> {
  let runtime = CoreRuntime::new(
    telemetry_config,
    tokio::runtime::Builder::new_multi_thread(),
  );

  // TODO need to figure out how to handle errors here
  Box::new(
    RuntimeRef {
      runtime: Runtime {
        core: Arc::new(runtime.unwrap()),
      },
    }
  )
}

#[no_mangle]
pub extern fn hs_temporal_init_runtime() -> *mut RuntimeRef {
  Box::into_raw(safe_init_runtime(TelemetryOptionsBuilder::default().build().unwrap()))
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

#[link(name ="HSrts", kind="dylib")]
extern "C" {
  pub fn hs_try_putmvar(capability: Capability, mvar: *mut MVar);
}

pub struct HsCallback<A, E> {
  pub cap: Capability,
  pub mvar: *mut MVar,
  pub result_slot: *mut*mut A,
  pub error_slot: *mut*mut E,
}

impl <A, E> HsCallback<A, E> {
  pub fn put_success(self, result: A) 
  where
    A: RawPointerConverter<A>,
  {
    unsafe {
      *self.result_slot = result.into_raw_pointer_mut();
      *self.error_slot = std::ptr::null_mut();
      hs_try_putmvar(self.cap, self.mvar);
    }
  }

  pub fn put_failure(self, error: E) 
  where
    E: RawPointerConverter<E>,
  {
    unsafe {
      *self.error_slot = error.into_raw_pointer_mut();
      *self.result_slot = std::ptr::null_mut();
      hs_try_putmvar(self.cap, self.mvar);
    }
  }

  pub fn put_result(self, result: Result<A, E>) 
  where
    A: RawPointerConverter<A>,
    E: RawPointerConverter<E>,
  {
    match result {
      Ok(result) => self.put_success(result),
      Err(error) => self.put_failure(error),
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
    callback.put_result(result);
  }
}

#[no_mangle]
pub extern fn hs_temporal_drop_cstring(str: *const HaskellText) {
  unsafe {
    drop(CArray::from_raw_pointer(str));
  }
}

// Actually the same thing as the above, but we want to be explicit about the
// type of what we're dropping for clarity.
#[no_mangle]
pub extern fn hs_temporal_drop_byte_array(str: *const CArray<u8>) {
  unsafe {
    drop(CArray::from_raw_pointer(str));
  }
}
