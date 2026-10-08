#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
: "${EMSDK:?Set EMSDK to an Emscripten SDK with version 4.0.20 activated}"
: "${CMAKE:=cmake}"
: "${UNICORN_BUILD_DIR:=$root/build-web-arm}"
source "$EMSDK/emsdk_env.sh"
emcc --version | head -n 1 | grep -q '4\.0\.20' || { echo 'Emscripten 4.0.20 is required' >&2; exit 1; }
emcmake "$CMAKE" -S "$root" -B "$UNICORN_BUILD_DIR" -G Ninja \
  -DCMAKE_BUILD_TYPE=Release -DUNICORN_ARCH=arm -DBUILD_SHARED_LIBS=OFF \
  -DUNICORN_BUILD_SAMPLES=OFF -DUNICORN_INSTALL=OFF \
  -DCMAKE_C_FLAGS="-Wno-error=implicit-function-declaration -Wno-error=incompatible-function-pointer-types -ffile-prefix-map=$root=/unicorn"
"$CMAKE" --build "$UNICORN_BUILD_DIR" --parallel "${BUILD_JOBS:-6}"
test -s "$UNICORN_BUILD_DIR/libunicorn.a"
echo "ARM-only Unicorn 1.0.3/TCI: $UNICORN_BUILD_DIR/libunicorn.a"
