REM Copy from pixi GitHub rust build ci job
REM
REM These are some environment variables that configure the build so that the binary size is reduced.
REM Inspiration was taken from this blog: https://arusahni.net/blog/2020/03/optimizing-rust-binary-size.html
REM They're only enable it on main and releases.
REM

REM Enable Link Time Optimization (LTO) for our release builds. This increases link time but drastically reduces
REM binary size.
set CARGO_PROFILE_RELEASE_LTO='true'

REM Use a single code gen unit, this effectively disables parallel linking but ensures that everything is linked
REM together in a single unit which reduces the file-size at the cost of link time.
REM Default for a release build is 16
set CARGO_PROFILE_RELEASE_CODEGEN_UNITS='1'

REM Strip the binaries. This reduces the filesize of the final release.
set CARGO_PROFILE_RELEASE_STRIP='symbols'

REM Optimize the binary for size. This reduces the filesize at the cost of a slower binary.
REM Options are 's' (size), 'z' (size and speed), '0-3' (speed, 0 being no optimization, 3 being max optimization)
set CARGO_PROFILE_OPT_LEVEL='s'


set CARGO_HOME=D:\cargo
cargo install --locked --bins --root %PREFIX% --path .
if %errorlevel% NEQ 0 exit /b %errorlevel%
cargo-bundle-licenses --format yaml --output %SRC_DIR%/THIRDPARTY.yml
if %errorlevel% NEQ 0 exit /b %errorlevel%
del %PREFIX%\.crates2.json
if %errorlevel% NEQ 0 exit /b %errorlevel%
del %PREFIX%\.crates.toml
if %errorlevel% NEQ 0 exit /b %errorlevel%
