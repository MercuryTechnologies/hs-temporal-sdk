use ffi_convert::*;
use once_cell::sync::Lazy;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::future::Future;
use std::net::SocketAddr;
use std::os::raw::c_int;
use std::sync::{Arc, Mutex};
use std::time::{Duration, SystemTime};
use temporal_sdk_core::telemetry::{
    build_otlp_metric_exporter, construct_filter_string, start_prometheus_metric_exporter,
};
use temporal_sdk_core::{CoreRuntime, TokioRuntimeBuilder};
use temporal_sdk_core_api::telemetry::metrics::{CoreMeter, NoOpCoreMeter};
use temporal_sdk_core_api::telemetry::{
    CoreTelemetry, Logger, OtelCollectorOptionsBuilder, PrometheusExporterOptionsBuilder,
    TelemetryOptions, TelemetryOptionsBuilder,
};
use tracing::Level;

pub struct RuntimeRef {
    pub(crate) runtime: Runtime,
}

#[derive(Clone)]
pub(crate) struct Runtime {
    pub(crate) core: Arc<CoreRuntime>,
    pub(crate) try_put_mvar: extern "C" fn(capability: Capability, mvar: *mut MVar) -> (),
}

/// Global registry to keep runtimes alive across GHCi reloads.
/// This prevents expensive re-initialization and avoids issues with
/// persistent Rust state when the dylib stays loaded but Haskell reloads.
///
/// We always reuse runtimes to avoid tracing-subscriber span management issues.
/// See: https://github.com/tokio-rs/tracing/issues/1656
/// When spans are closed while a different subscriber is the default, it can cause
/// panics due to Registry asking the wrong dispatch to close span IDs.
static RUNTIME_REGISTRY: Lazy<Mutex<Option<Arc<CoreRuntime>>>> = Lazy::new(|| Mutex::new(None));

/// Attempts to reuse an existing runtime from the global registry.
/// Returns None if no compatible runtime exists.
fn try_reuse_runtime() -> Option<Arc<CoreRuntime>> {
    RUNTIME_REGISTRY
        .lock()
        .ok()?
        .as_ref()
        .cloned()
}

/// Stores a runtime in the global registry for potential reuse.
fn register_runtime(runtime: Arc<CoreRuntime>) {
    if let Ok(mut registry) = RUNTIME_REGISTRY.lock() {
        *registry = Some(runtime);
    }
}

/// Clears the global runtime registry, forcing new runtimes to be created.
fn clear_runtime_registry() {
    if let Ok(mut registry) = RUNTIME_REGISTRY.lock() {
        *registry = None;
    }
}

/// Initialize a runtime, reusing an existing one from the registry if available.
///
/// We always attempt to reuse runtimes to avoid tracing-subscriber span management issues.
/// See: https://github.com/tokio-rs/tracing/issues/1656
fn init_runtime_impl(
    telemetry_config: TelemetryOptions,
    late_telemetry_options: HsTelemetryOptions,
    try_put_mvar: extern "C" fn(capability: Capability, mvar: *mut MVar) -> (),
) -> Box<RuntimeRef> {
    // Always try to reuse existing runtime to avoid tracing span issues
    if let Some(existing_runtime) = try_reuse_runtime() {
        eprintln!("[TEMPORAL-DEBUG] Reusing existing CoreRuntime from RUNTIME_REGISTRY");
        eprintln!("[TEMPORAL-DEBUG] Arc strong_count: {}", Arc::strong_count(&existing_runtime));
        return Box::new(RuntimeRef {
            runtime: Runtime {
                core: existing_runtime,
                try_put_mvar,
            },
        });
    }

    // Create new runtime only if we couldn't reuse an existing one
    eprintln!("[TEMPORAL-DEBUG] Creating NEW CoreRuntime (no existing runtime in registry)");
    let mut runtime = CoreRuntime::new(telemetry_config, TokioRuntimeBuilder::default()).unwrap();

    let _guard = runtime.tokio_handle().enter();
    let core_meter: Arc<dyn CoreMeter> = match late_telemetry_options {
        HsTelemetryOptions::NoTelemetry => Arc::new(NoOpCoreMeter) as Arc<dyn CoreMeter>,
        HsTelemetryOptions::OtelTelemetryOptions {
            url,
            headers,
            metric_periodicity,
            global_tags,
        } => Arc::new(
            build_otlp_metric_exporter(
                OtelCollectorOptionsBuilder::default()
                    .url(url.parse().expect("Invalid URL"))
                    .metric_periodicity(metric_periodicity.unwrap_or_else(|| Duration::new(1, 0)))
                    .headers(headers)
                    .global_tags(global_tags)
                    .build()
                    .expect("Invalid OTEl configuration"),
            )
            .expect("Otel Metric exporter"),
        ) as Arc<dyn CoreMeter>,
        HsTelemetryOptions::PrometheusTelemetryOptions {
            socket_addr,
            global_tags,
            counters_total_suffix,
            unit_suffix,
        } => {
            let srv = start_prometheus_metric_exporter(
                PrometheusExporterOptionsBuilder::default()
                    .socket_addr(socket_addr)
                    .unit_suffix(unit_suffix)
                    .global_tags(global_tags)
                    .counters_total_suffix(counters_total_suffix)
                    .build()
                    .expect("Invalid Prometheus configuration"),
            )
            .expect("Failed to start prometheus exporter");
            srv.meter as Arc<dyn CoreMeter>
        }
    };
    runtime.telemetry_mut().attach_late_init_metrics(core_meter);

    let core_runtime = Arc::new(runtime);

    // Store the new runtime in the registry for future reuse
    register_runtime(core_runtime.clone());

    Box::new(RuntimeRef {
        runtime: Runtime {
            core: core_runtime,
            try_put_mvar,
        },
    })
}

fn init_runtime(
    telemetry_config: TelemetryOptions,
    late_telemetry_options: HsTelemetryOptions,
    try_put_mvar: extern "C" fn(capability: Capability, mvar: *mut MVar) -> (),
) -> Box<RuntimeRef> {
    init_runtime_impl(telemetry_config, late_telemetry_options, try_put_mvar)
}

#[derive(Serialize, Deserialize)]
#[serde(tag = "tag")]
pub enum HsTelemetryOptions {
    OtelTelemetryOptions {
        url: String,
        headers: HashMap<String, String>,
        metric_periodicity: Option<Duration>,
        global_tags: HashMap<String, String>,
    },
    PrometheusTelemetryOptions {
        socket_addr: SocketAddr,
        global_tags: HashMap<String, String>,
        counters_total_suffix: bool,
        unit_suffix: bool,
    },
    NoTelemetry,
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_init_runtime(
    telemetry_opts: *const CArray<u8>,
    try_put_mvar: extern "C" fn(Capability, *mut MVar) -> (),
) -> *mut RuntimeRef {
    let telemetry_opts = unsafe {
        CArray::raw_borrow(telemetry_opts)
            .unwrap()
            .as_rust()
            .unwrap()
            .clone()
    };
    let telemetry_opts: HsTelemetryOptions =
        serde_json::from_slice(telemetry_opts.as_slice()).expect("Failed to parse");

    let early_options = TelemetryOptionsBuilder::default()
        .logging(Logger::Forward {
            filter: construct_filter_string(Level::INFO, Level::ERROR),
        })
        .attach_service_name(true)
        // .metrics(core_meter)
        .build()
        .expect("Invalid TelemetryOptions");
    let rt = init_runtime(early_options, telemetry_opts, try_put_mvar);
    Box::into_raw(rt)
}

fn safe_drop_runtime(runtime: Box<RuntimeRef>) {
    drop(runtime)
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_free_runtime(runtime: *mut RuntimeRef) {
    unsafe { safe_drop_runtime(Box::from_raw(runtime)) };
}

// TODO: [publish-crate]
/// Clears the global runtime registry, forcing subsequent init calls to create fresh runtimes.
///
/// This is useful for explicit cleanup in test scenarios or when you want to ensure
/// a completely fresh runtime is created.
///
/// # Safety
///
/// Haskell FFI bridge invariants. This function is safe to call multiple times.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_clear_runtime_registry() {
    clear_runtime_registry();
}

#[repr(C)]
pub struct MVar {
    _data: [u8; 0],
    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
}

#[repr(C)]
#[derive(Copy, Clone)]
pub struct Capability {
    pub cap_num: c_int,
}

pub struct HsCallback<A, E> {
    pub cap: Capability,
    pub mvar: *mut MVar,
    pub result_slot: *mut *mut A,
    pub error_slot: *mut *mut E,
}

impl<A, E> HsCallback<A, E> {
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
    pub fn future_result_into_hs<F, T, E>(&self, callback: HsCallback<T, E>, fut: F)
    where
        F: Future<Output = Result<T, E>> + Send + 'static,
        T: RawPointerConverter<T>,
        E: RawPointerConverter<E>,
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

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_drop_byte_array(str: *const CArray<u8>) {
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
    pub span_contexts: Vec<String>,
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_runtime_fetch_logs(
    runtime: *mut RuntimeRef,
) -> *const CArray<CArray<u8>> {
    let runtime = unsafe { &*runtime };
    let logs = runtime.runtime.core.telemetry().fetch_buffered_logs();
    let hs_logs: Vec<Vec<u8>> = logs
        .iter()
        .map(|log| {
            let log = CoreLogDef {
                target: log.target.clone(),
                message: log.message.clone(),
                timestamp: log.timestamp,
                level: String::from(log.level.as_str()),
                fields: log.fields.clone(),
                span_contexts: log.span_contexts.clone(),
            };
            serde_json::to_vec(&log).expect("Failed to serialize log line")
        })
        .collect();
    CArray::c_repr_of(hs_logs).unwrap().into_raw_pointer()
}

// TODO: [publish-crate]
/// # Safety
///
/// Haskell FFI bridge invariants.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn hs_temporal_runtime_free_logs(logs: *const CArray<CArray<u8>>) {
    unsafe {
        drop(CArray::from_raw_pointer(logs));
    }
}
