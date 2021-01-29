#!/bin/bash
set -euxo pipefail

my_pkgs=(
    aura-bin
    aurutils
    bitwise
    colorpicker
    espresso-logic
    floskell
    fpp
    icdiff
    magic-wormhole
    mellow
    # miniconda3
    notion-enhancer
    # notcurses
    picom-jonaburg-git
    # plan9port-git
    riscv-sifive-elf-gcc
    riscv64-unknown-elf-gcc
    scalafmt-native-bin
    tabbed
    yay-bin
)

# Setup makepkg conf
cat makepkg.conf >>/etc/makepkg.conf
sed 's/SKIPPGPCHECK=0/SKIPPGPCHECK=1/' /usr/bin/makepkg -i

H=$(pwd)
export H

for my_pkg in "${my_pkgs[@]}"; do
    echo ">>>>>>>>> building $my_pkg"
    SECONDS=0
    if [ -e "custom/$my_pkg.sh" ]; then
        "./custom/$my_pkg.sh"
    elif [ -d "custom/$my_pkg" ]; then
	. "$H/custom.sh" cd "$my_pkg"
	. "$H/custom.sh" build
    else
        sudo -u builduser aur sync "$my_pkg" --no-view --no-confirm # --rm-deps
    fi
    echo "<<<<<<<<< $my_pkg built, $SECONDS seconds used."
done
