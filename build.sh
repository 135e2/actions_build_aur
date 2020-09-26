#!/bin/bash
set -euxo pipefail

my_pkgs=(
    amazon-corretto-8
    aurutils
    colorpicker
    fcitx-sogoupinyin
    jetbrains-toolbox
    miniconda3
)

sudo -u builduser aur sync "${my_pkgs[@]}" --no-view --no-confirm --rm-deps