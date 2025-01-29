#!/usr/bin/env bash
# If the linux-aarch64 and linux-ppc64le targets are present, set JEMALLOC_SYS_WITH_LG_PAGE to 16
export OPENSSL_DIR=$PREFIX
cargo install --locked --bins --root ${PREFIX} --path .
cargo-bundle-licenses --format yaml --output ${SRC_DIR}/THIRDPARTY.yml
rm $PREFIX/.crates2.json
rm $PREFIX/.crates.toml
