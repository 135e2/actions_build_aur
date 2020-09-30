#!/bin/bash
set -euxo pipefail

my_pkgs=(
    amazon-corretto-8
    aura-bin
    aurutils
    colorpicker
    fcitx-sogoupinyin
    gccemacs
    haskell-ide-engine
    icdiff
    jetbrains-toolbox
    miniconda3
    notcurses
    pandoc-bin
    stack-static
    # taffybar
    # ungoogled-chromium
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
    else
        sudo -u builduser aur sync "$my_pkg" --no-view --no-confirm # --rm-deps
    fi
    echo "<<<<<<<<< $my_pkg built, $SECONDS seconds used."
done
