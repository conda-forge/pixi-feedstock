#!/usr/bin/env bash

export OPENSSL_DIR=$PREFIX
cargo install --locked --bins --root ${PREFIX} --path . --no-track
cargo-bundle-licenses --format yaml --output ${SRC_DIR}/THIRDPARTY.yml
