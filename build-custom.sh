#!/bin/bash
set -euxo pipefail

if [[ build == "$1" ]]; then
    aurdep=$(aur depends "$CURRENT_PKG" | grep -v "$CURRENT_PKG") || true
    unset CURRENT_PKG
    if [[ "" != "$aurdep" ]]; then
	sudo -u builduser aur sync "$aurdep" --no-view --no-confirm
    fi
    sudo -u builduser aur build -- -sci --needed --noconfirm --noprogressbar --skipchecksums
    popd
else
    export CURRENT_PKG="$1"
    aur fetch "$CURRENT_PKG"
    chmod a+w "$CURRENT_PKG" # for builduser
    pushd "$CURRENT_PKG"
fi

