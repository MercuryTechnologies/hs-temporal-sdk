use temporal_sdk_core::CoreRuntime;
use temporal_sdk_core_api::telemetry::{
    Logger, MetricsExporter, OtelCollectorOptions, TelemetryOptions, TelemetryOptionsBuilder,
    TraceExportConfig, TraceExporter,
};

fn safe_init_runtime(telemetry_config: TelemetryOptions) -> Box<CoreRuntime> {
  let runtime = CoreRuntime::new(
    telemetry_config,
    tokio::runtime::Builder::new_multi_thread(),
  );

  // TODO need to figure out how to handle errors here
  Box::new(runtime.unwrap())
}

#[no_mangle]
pub extern fn hs_temporal_init_runtime() -> *mut CoreRuntime {
  Box::into_raw(safe_init_runtime(TelemetryOptionsBuilder::default().build().unwrap()))
}

fn safe_drop_runtime(runtime: Box<CoreRuntime>) {
  drop(runtime)
}

#[no_mangle]
pub unsafe extern fn hs_temporal_free_runtime(runtime: *mut CoreRuntime) {
  safe_drop_runtime(Box::from_raw(runtime));
}