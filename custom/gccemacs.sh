#!/bin/bash
set -euxo pipefail

aur fetch -t emacs-native-comp-git
chmod a+w emacs-native-comp-git
pushd emacs-native-comp-git
# sed 's/CLANG=/CLANG="YES"/' PKGBUILD -i
sed 's/LTO=/LTO="YES"/' PKGBUILD -i
sed 's/M17N=/M17N="YES"/' PKGBUILD -i
# sed 's/FAST_BOOT=/FAST_BOOT="YES"/' PKGBUILD -i
sed 's/CFLAGS+=" -g"//' PKGBUILD -i
sed 's/CXXFLAGS+=" -g"//' PKGBUILD -i
aurdep=$(aur depends emacs-native-comp-git | grep -v emacs-native-comp-git)
sudo -u builduser aur sync "$aurdep" --no-view --no-confirm
sudo -u builduser aur build -- -sci --needed --noconfirm --noprogressbar
popd
