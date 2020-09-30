#!/bin/bash
set -euxo pipefail

. "$H/build-custom.sh" emacs-native-comp-git
# sed 's/CLANG=/CLANG="YES"/' PKGBUILD -i
sed -i 's/LTO=/LTO="YES"/' PKGBUILD
sed -i 's/M17N=/M17N="YES"/' PKGBUILD
# sed 's/FAST_BOOT=/FAST_BOOT="YES"/' PKGBUILD -i
sed -i 's/CFLAGS+=" -g"//' PKGBUILD
sed -i 's/CXXFLAGS+=" -g"//' PKGBUILD
. "$H/build-custom.sh" build
