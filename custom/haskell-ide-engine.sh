#!/bin/bash
set -euxo pipefail

. "$H/build-custom.sh" haskell-ide-engine
sed "s/_enabled_ghc_versions=.*/_enabled_ghc_versions=\('8.8.3'\)/" PKGBUILD -i
. "$H/build-custom.sh" build
