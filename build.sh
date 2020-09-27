#!/bin/bash
set -euxo pipefail

my_pkgs=(
    amazon-corretto-8
    aurutils
    colorpicker
    fcitx-sogoupinyin
    jetbrains-toolbox
    icdiff
    miniconda3
    pandoc-bin
    # ungoogled-chromium
)

# Dirty trick to do alias makepkg='makepkg --skippgpcheck'
sed 's/SKIPPGPCHECK=0/SKIPPGPCHECK=1/' /usr/bin/makepkg -i
sudo -u builduser aur sync "${my_pkgs[@]}" --no-view --no-confirm --rm-deps
