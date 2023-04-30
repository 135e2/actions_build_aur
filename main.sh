#!/bin/bash
set -euo pipefail

. utils/logging.sh
. build.sh
. sign.sh
. transfer.sh

info "Building packages..."
build

debug "Packages list: \n$(ls -lF /home/builduser/localrepo)"

info "Signing packages..."
sign

info "Transfering packages..."
transfer
