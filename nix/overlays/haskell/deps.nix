{haskell, ...}: hfinal: hprev: let
  inherit (haskell.lib.compose) markUnbroken packageSourceOverrides;
in
  {
    if-instance = markUnbroken hprev.if-instance;
  }
  // (packageSourceOverrides {
      hs-opentelemetry-api = "0.1.0.0";
      hs-opentelemetry-exporter-in-memory = "0.0.1.3";
      hs-opentelemetry-exporter-otlp = "0.0.1.5";
      hs-opentelemetry-instrumentation-cloudflare = "0.2.0.0";
      hs-opentelemetry-instrumentation-conduit = "0.1.0.0";
      hs-opentelemetry-instrumentation-hspec = "0.0.1.1";
      hs-opentelemetry-instrumentation-http-client = "0.1.0.0";
      hs-opentelemetry-instrumentation-persistent = "0.1.0.0";
      hs-opentelemetry-instrumentation-postgresql-simple = "0.1.0.0";
      hs-opentelemetry-instrumentation-wai = "0.1.0.0";
      hs-opentelemetry-instrumentation-yesod = "0.1.0.0";
      hs-opentelemetry-otlp = "0.0.1.0";
      hs-opentelemetry-propagator-b3 = "0.0.1.1";
      hs-opentelemetry-propagator-w3c = "0.0.1.3";
      hs-opentelemetry-sdk = "0.0.3.6";
      hs-opentelemetry-utils-exceptions = "0.2.0.0";
      hs-opentelemetry-vendor-honeycomb = "0.0.1.1";
    }
    hfinal
    hprev)
