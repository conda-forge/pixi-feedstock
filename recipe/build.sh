#!/usr/bin/env bash

export OPENSSL_DIR=$PREFIX

# Copy from pixi GitHub rust build ci job
#
# These are some environment variables that configure the build so that the binary size is reduced.
# Inspiration was taken from this blog: https://arusahni.net/blog/2020/03/optimizing-rust-binary-size.html
# They're only enable it on main and releases.
#

# Enable Link Time Optimization (LTO) for our release builds. This increases link time but drastically reduces
# binary size.
export CARGO_PROFILE_RELEASE_LTO='true'

# Use a single code gen unit, this effectively disables parallel linking but ensures that everything is linked
# together in a single unit which reduces the file-size at the cost of link time.
# Default for a release build is 16
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS='1'

# Strip the binaries. This reduces the filesize of the final release.
export CARGO_PROFILE_RELEASE_STRIP='symbols'

# Optimize the binary for size. This reduces the filesize at the cost of a slower binary.
# Options are 's' (size), 'z' (size and speed), '0-3' (speed, 0 being no optimization, 3 being max optimization)
export CARGO_PROFILE_OPT_LEVEL='s'

cargo install --locked --bins --root ${PREFIX} --path .
cargo-bundle-licenses --format yaml --output ${SRC_DIR}/THIRDPARTY.yml
rm $PREFIX/.crates2.json
rm $PREFIX/.crates.toml
