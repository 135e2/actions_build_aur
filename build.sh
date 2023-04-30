#!/bin/bash

. utils/time_parser.sh

my_pkgs=(
    yay
    paru
    implay
    linux-xanmod-anbox
    linux-xanmod-anbox-headers
    #linux-lqx
)

function build_package() {
    local pkg="$1"
    local SECONDS=0
    info ">>>>>>>>> building $pkg"
    if [ -e "custom/$pkg.sh" ]; then
        "./custom/$pkg.sh"
    elif [ -d "custom/$pkg" ]; then
        . "$H/custom.sh" cd "$pkg"
        . "$H/custom.sh" build
    else
        sudo -u builduser aur sync "$pkg" --no-view --no-confirm #--sign # --rm-deps
    fi
    TOTAL_SECONDS+=SECONDS
    info "<<<<<<<<< $pkg built, time used: $(time_parser $SECONDS)."
}


function build() {
    # Setup makepkg conf
    cat makepkg.conf >>/etc/makepkg.conf
    sed 's/SKIPPGPCHECK=0/SKIPPGPCHECK=1/' /usr/bin/makepkg -i

    H=$(pwd)
    export H
    TOTAL_SECONDS=0

    for my_pkg in "${my_pkgs[@]}"; do
        build_package "$my_pkg"
    done
    info "All builds done, time used: $(time_parser $TOTAL_SECONDS)."
}
