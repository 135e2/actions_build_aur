#!/bin/bash
set -euxo pipefail

__my_pkgs=(
    miniconda3
    fcitx-sogoupinyin
)

sudo -u builduser aur sync "${__my_pkgs[@]}" --no-view --no-confirm --rm-deps