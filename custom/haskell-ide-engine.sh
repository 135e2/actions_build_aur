#!/bin/bash
set -euxo pipefail

wget --quiet https://aur.archlinux.org/cgit/aur.git/snapshot/haskell-ide-engine.tar.gz
tar -xf haskell-ide-engine.tar.gz
chmod a+w haskell-ide-engine # for builduser
pushd haskell-ide-engine
sed "s/_enabled_ghc_versions=.*/_enabled_ghc_versions=\('8.8.3'\)/" PKGBUILD -i
sudo -u builduser aur build -- -sci --skipchecksums --needed --noconfirm --noprogressbar
popd
