#!/usr/bin/env bash

set -e

cbindgen --config cbindgen.toml --crate temporal_bridge --output temporal_bridge.h