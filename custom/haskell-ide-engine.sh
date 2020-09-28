#!/bin/bash
set -euxo pipefail

aur fetch -t haskell-ide-engine
chmod a+w haskell-ide-engine # for builduser
pushd haskell-ide-engine
sed "s/_enabled_ghc_versions=.*/_enabled_ghc_versions=\('8.8.3'\)/" PKGBUILD -i
sudo -u builduser aur build -- -sci --needed --noconfirm --noprogressbar
popd
