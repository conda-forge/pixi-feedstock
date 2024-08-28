#!/usr/bin/env bash

export OPENSSL_DIR=$PREFIX
cargo install --locked --bins --root ${PREFIX} --features native-tls --no-default-features --path .
cargo-bundle-licenses --format yaml --output ${SRC_DIR}/THIRDPARTY.yml
rm $PREFIX/.crates2.json
rm $PREFIX/.crates.toml
