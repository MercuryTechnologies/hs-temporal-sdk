use temporal_client::{
  ClientOptions, ClientOptionsBuilder, ClientOptionsBuilderError, ConfiguredClient,
  RetryClient, RetryConfig, TemporalServiceClientWithMetrics, TlsConfig,
  WorkflowService,
};
use tonic::{metadata::{MetadataKey, errors::InvalidMetadataValue}};
use ffi_convert::*;
use crate::runtime::{self, Capability, MVar, HsCallback, HaskellText};
use std::collections::HashMap;
use std::sync::Arc;
use parking_lot::RwLock;
use std::ffi::CStr;
use std::time::Duration;
use serde::{Deserialize, Serialize};
use url::Url;
use std::str::{FromStr, from_utf8_unchecked};

type Client = RetryClient<ConfiguredClient<TemporalServiceClientWithMetrics>>;

#[derive(Serialize, Deserialize)]
pub struct ClientConfig {
  target_url: String,
  client_name: String,
  client_version: String,
  metadata: HashMap<String, String>,
  identity: String,
  tls_config: Option<ClientTlsConfig>,
  retry_config: Option<ClientRetryConfig>,
}

#[derive(Serialize, Deserialize)]
struct ClientTlsConfig {
    server_root_ca_cert: Option<Vec<u8>>,
    domain: Option<String>,
    client_cert: Option<Vec<u8>>,
    client_private_key: Option<Vec<u8>>,
}

#[derive(Serialize, Deserialize)]
struct ClientRetryConfig {
    pub initial_interval_millis: u64,
    pub randomization_factor: f64,
    pub multiplier: f64,
    pub max_interval_millis: u64,
    pub max_elapsed_time_millis: Option<u64>,
    pub max_retries: usize,
}

fn client_config_to_options(client_config: ClientConfig) -> Result<ClientOptions, ClientOptionsBuilderError> {
  let mut defaults = ClientOptionsBuilder::default();
  let mut options_builder = defaults
    .target_url(Url::parse(&client_config.target_url).unwrap())
    .client_name(client_config.client_name)
    .client_version(client_config.client_version)
    .identity(client_config.identity);

  match client_config.tls_config {
    Some(tls_config) => {
      let tls_config = TlsConfig {
        server_root_ca_cert: tls_config.server_root_ca_cert,
        domain: tls_config.domain,
        client_tls_config: None 
        // TODO!
        // ClientTlsConfig {
        //   client_cert: tls_config.client_cert,
        //   client_private_key: tls_config.client_private_key,
        // }
      };
      options_builder = options_builder.tls_cfg(tls_config);
    }
    None => {}
  }

  if let Some(retry_config) = client_config.retry_config {
    options_builder = options_builder.retry_config(RetryConfig {
      initial_interval: Duration::from_millis(retry_config.initial_interval_millis),
      randomization_factor: retry_config.randomization_factor,
      multiplier: retry_config.multiplier,
      max_interval: Duration::from_millis(retry_config.max_interval_millis),
      max_elapsed_time: retry_config.max_elapsed_time_millis.map(Duration::from_millis),
      max_retries: retry_config.max_retries,
    });
  }

  options_builder.build()
}

#[repr(C)]
pub struct HaskellHashMapEntries {
  key: *const u8,
  key_len: usize,
  value: *const u8,
  value_len: usize,
  next: *const HaskellHashMapEntries,
}

pub fn convert_hashmap(
  hashmap: *const HaskellHashMapEntries
) -> HashMap<String, String> {
  let mut map = HashMap::new();
  if hashmap.is_null() {
    return map;
  }

  let mut hashmap_ptr = hashmap;
  while !hashmap_ptr.is_null() {
    let hashmap_val = unsafe { &*hashmap_ptr };
    let key = unsafe { 
      from_utf8_unchecked(std::slice::from_raw_parts(hashmap_val.key, hashmap_val.key_len))
    };
    let value = unsafe { 
      from_utf8_unchecked(std::slice::from_raw_parts(hashmap_val.value, hashmap_val.value_len))
    };
    map.insert(key.clone().to_string(), value.clone().to_string());
    hashmap_ptr = unsafe { (*hashmap).next };
  }

  map
}
#[repr(C)]
pub struct RpcCall {
  req: *const CArray<u8>,
  retry: bool,
  metadata: *const HaskellHashMapEntries,
  // nullable
  timeout_millis: *const u64,
}

struct TemporalCall {
  req: Vec<u8>,
  retry: bool,
  metadata: HashMap<String, String>,
  timeout_millis: Option<u64>,
}

impl From<&RpcCall> for TemporalCall {
  fn from(rpc_call: &RpcCall) -> Self {
    TemporalCall {
      req: unsafe {
        let req_array = rpc_call.req;
        let rust_vec = (*req_array).as_rust();
        rust_vec.unwrap()
      },
      retry: rpc_call.retry,
      metadata: convert_hashmap(rpc_call.metadata),
      timeout_millis: if rpc_call.timeout_millis.is_null() {
        None
      } else {
        Some(unsafe { *rpc_call.timeout_millis })
      }
    }
  }
}

pub struct ClientRef {
  pub(crate) retry_client: Client,
  runtime: runtime::Runtime,
}

pub fn connect_client(
  runtime_ref: &runtime::RuntimeRef,
  config: ClientConfig,
  hs_callback: HsCallback<ClientRef, HaskellText>,
) -> () {
  println!("connect_client");
  let headers = if config.metadata.is_empty() {
      None
  } else {
      Some(Arc::new(RwLock::new(config.metadata.clone())))
  };

  println!("make options");
  let opts: ClientOptions = client_config_to_options(config).unwrap();
  let runtime = runtime_ref.runtime.clone();
  runtime_ref.runtime.future_result_into_hs(hs_callback, async move {
    println!("construct client");
    let retry_client_result = opts
          .connect_no_namespace(runtime.core.metric_meter().as_deref(), headers)
          .await;
        
    match retry_client_result {
      Ok(retry_client) => {
        println!("client is good");
        Ok(Box::into_raw(Box::new(ClientRef {
          retry_client,
          runtime,
        })))
      }
      Err(e) => {
        println!("client is sad {}", e);
        let err_message = e.to_string().into_bytes();
        Err(
          CArray::into_raw_pointer_mut(CArray::c_repr_of(err_message).unwrap())
        )
      }
    }
  })
}

#[no_mangle]
pub extern "C" fn hs_temporal_connect_client(
  runtime_ref: *const runtime::RuntimeRef,
  config_json: *const libc::c_char,
  mvar: *mut MVar,
  cap: Capability,
  error_slot: *mut*mut HaskellText,
  result_slot: *mut*mut ClientRef
) {
  println!("get runtime ref");
  let runtime_ref = unsafe { &*runtime_ref };
  println!("get json");
  let config_json = unsafe { CStr::from_ptr(config_json) };
  println!("parse json");
  let config: ClientConfig = serde_json::from_slice(config_json.to_bytes()).unwrap();
  let hs_callback = runtime::HsCallback {
    cap, 
    mvar, 
    error_slot,
    result_slot
  };
  println!("call connect");
  connect_client(runtime_ref, config, hs_callback);
}

#[no_mangle]
pub extern "C" fn hs_temporal_drop_client(client: *mut ClientRef) {
  unsafe {
    drop(Box::from_raw(client));
  }
}

fn rpc_req<P: prost::Message + Default>(call: TemporalCall) -> Result<tonic::Request<P>, String> {
  let buf = call.req.as_slice();
  let proto = P::decode(buf).map_err(|err| err.to_string())?;
  let mut req = tonic::Request::new(proto);
  let metadata = &call.metadata;
  for (k, v) in metadata {
      req.metadata_mut().insert(
          MetadataKey::from_str(k.as_str())
              .map_err(|err| err.to_string())?,
          v.parse()
              .map_err(|err: InvalidMetadataValue| err.to_string())?,
      );
  }
  if let Some(timeout_millis) = call.timeout_millis {
      req.set_timeout(Duration::from_millis(timeout_millis));
  }
  Ok(req)
}

pub struct RPCError {
  pub code: u32,
  pub message: String,
  pub details: Vec<u8>,
}

#[repr(C)]
#[derive(CReprOf, AsRust, CDrop)]
#[target_type(RPCError)]
pub struct CRPCError {
  code: u32,
  message: *const libc::c_char,
  details: CArray<u8>,
}

impl From<String> for CRPCError {
  fn from(err: String) -> Self {
    CRPCError::c_repr_of(
      RPCError {
          code: 0,
          message: err,
          details: vec![],
      }
    ).unwrap()
  }
}

fn rpc_resp<P>(res: Result<tonic::Response<P>, tonic::Status>) -> Result<Vec<u8>, *mut CRPCError>
where
  P: prost::Message,
  P: Default,
{
  match res {
      Ok(resp) => Ok(resp.get_ref().encode_to_vec()),
      Err(err) => Err(Box::into_raw(Box::new(CRPCError::c_repr_of(RPCError {
        code: err.code() as u32,
        message: err.message().to_owned(),
        details: err.details().into(),
      }).unwrap())))
  }
}

macro_rules! rpc_call {
  ($retry_client:ident, $call:ident, $call_name:ident) => {
    {
      if $call.retry {
        let req = rpc_req($call).map_err(|err| 
              Box::into_raw(Box::new(CRPCError::c_repr_of(RPCError {
                code: 0,
                message: err,
                details: vec![],
              }).unwrap())))?;
        rpc_resp($retry_client.$call_name(req).await)
      } else {
        let req = rpc_req($call).map_err(|err| 
              Box::into_raw(Box::new(CRPCError::c_repr_of(RPCError {
                code: 0,
                message: err,
                details: vec![],
              }).unwrap())))?;
        rpc_resp($retry_client.into_inner().$call_name(req).await)
      }
    }
  };
}

pub extern "C" fn hs_count_workflow_executions(cap: Capability, mvar: *mut MVar, error_slot: *mut*mut CRPCError, result_slot: *mut*mut CArray<u8>, client: *mut ClientRef, c_call: *const RpcCall) -> () {
  let client = unsafe { &mut *client };
  let mut retry_client = client.retry_client.clone();
  let call: TemporalCall = unsafe { (&*c_call).into() };

  let callback: HsCallback<CArray<u8>, CRPCError> = HsCallback { cap, mvar, result_slot, error_slot };
  client.runtime.future_result_into_hs(callback, async move {
    match rpc_call!(retry_client, call, count_workflow_executions) {
      Ok(resp) => Ok(CArray::into_raw_pointer_mut(CArray::c_repr_of(resp).unwrap())),
      Err(err) => Err(err)
    }
  });
}