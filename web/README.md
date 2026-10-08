# ARM-only WebAssembly build

This branch adds a repeatable static-library build to petabyt/unicorn-wasm at
`ce088b992b42ca7f20634b3b1272e3d0726020e2`. It preserves that fork's Unicorn
1.0.3 and TCI implementation. There are no CPU/translator changes here.

Install Emscripten **4.0.20**, CMake and Ninja, then run:

```sh
EMSDK=/path/to/emsdk bash web/build-arm.sh
```

The output is `build-web-arm/libunicorn.a`. `UNICORN_BUILD_DIR`, `CMAKE` and
`BUILD_JOBS` override the output path, CMake executable and build parallelism.
The two compiler diagnostic overrides retain the existing C callback conventions;
consumers must link with `-sEMULATE_FUNCTION_POINTER_CASTS=1`.

The integration and real-guest regression tests live in the
[Speculos embedded fork](https://github.com/tian000/speculos-embedded/tree/embedded-webview/web).
The upstream `COPYING`, `COPYING.LGPL2`, `COPYING_GLIB`, `AUTHORS.TXT` and file
headers remain authoritative. This build does not relicense upstream code.
