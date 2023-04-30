#!/bin/bash

function local_custom_build() {
    chmod a+w "custom/$1"
    pushd "custom/$1" || error "No custom pkg called $1!"
    sudo -u builduser aur build --syncdeps --noconfirm --margs '--needed,--noprogressbar,--skipchecksums'
    popd
}

function fetch_build() {
    CURRENT_PKG="$1"
    aur fetch "$CURRENT_PKG"
    chmod a+w "$CURRENT_PKG" # for builduser
    pushd "$CURRENT_PKG"
    aurdep=$(aur depends "$CURRENT_PKG" | grep -v "$CURRENT_PKG") || true
    unset CURRENT_PKG
    if [[ "" != "$aurdep" ]]; then
        sudo -u builduser aur sync "$aurdep" --no-view --no-confirm --sign
    fi
}
