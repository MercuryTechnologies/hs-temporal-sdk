{ haskell, fetchFromGitHub, ... }:
hfinal: hprev:
let
  inherit (haskell.lib.compose) dontCheck markUnbroken packageSourceOverrides;

  hs-opentelemetry-src = fetchFromGitHub {
    owner = "iand675";
    repo = "hs-opentelemetry";
    rev = "f9d78fbe89da9e5c149c60a2ba7d75acb471942e";
    hash = "sha256-oBrmeqoltrIfPUhsgtgoahgHi85iBa3H5p6PkiHeKTU=";
  };
  otelPackage =
    name: subdir:
    dontCheck (hfinal.callCabal2nix name "${hs-opentelemetry-src}/${subdir}" { });
in
{
  if-instance = markUnbroken hprev.if-instance;

  thread-utils-context = hfinal.callHackageDirect {
    pkg = "thread-utils-context";
    ver = "0.4.1.0";
    sha256 = "sha256-etbB97HVjo0TL8s09wsgxFoKa8DnNbam0ToPl61jsiw=";
  } { };

  hs-opentelemetry-api-types = otelPackage "hs-opentelemetry-api-types" "api-types";
  hs-opentelemetry-semantic-conventions = otelPackage "hs-opentelemetry-semantic-conventions" "semantic-conventions";
  hs-opentelemetry-otlp = otelPackage "hs-opentelemetry-otlp" "otlp";
  hs-opentelemetry-api = otelPackage "hs-opentelemetry-api" "api";
  hs-opentelemetry-propagator-w3c = otelPackage "hs-opentelemetry-propagator-w3c" "propagators/w3c";
  hs-opentelemetry-propagator-b3 = otelPackage "hs-opentelemetry-propagator-b3" "propagators/b3";
  hs-opentelemetry-propagator-datadog = otelPackage "hs-opentelemetry-propagator-datadog" "propagators/datadog";
  hs-opentelemetry-propagator-jaeger = otelPackage "hs-opentelemetry-propagator-jaeger" "propagators/jaeger";
  hs-opentelemetry-propagator-xray = otelPackage "hs-opentelemetry-propagator-xray" "propagators/xray";
  hs-opentelemetry-exporter-handle = otelPackage "hs-opentelemetry-exporter-handle" "exporters/handle";
  hs-opentelemetry-exporter-otlp = otelPackage "hs-opentelemetry-exporter-otlp" "exporters/otlp";
  hs-opentelemetry-sdk = otelPackage "hs-opentelemetry-sdk" "sdk";
}
// (packageSourceOverrides {
  # any package version pins reflected in 'all-cabal-hashes' should go here.
} hfinal hprev)
