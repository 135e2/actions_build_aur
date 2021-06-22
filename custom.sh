#!/bin/bash
set -euxo pipefail

if [[ build == "$1" ]]; then
    sudo -u builduser aur build --syncdeps --noconfirm --margs '--needed,--noprogressbar,--skipchecksums'
    popd
elif [[ fetch == "$1" ]]; then
    CURRENT_PKG="$2"
    aur fetch "$CURRENT_PKG"
    chmod a+w "$CURRENT_PKG" # for builduser
    pushd "$CURRENT_PKG"
    aurdep=$(aur depends "$CURRENT_PKG" | grep -v "$CURRENT_PKG") || true
    unset CURRENT_PKG
    if [[ "" != "$aurdep" ]]; then
	sudo -u builduser aur sync "$aurdep" --no-view --no-confirm --sign
    fi
elif [[ cd == "$1" ]]; then
    chmod a+w "custom/$2"
    pushd "custom/$2"
fi

