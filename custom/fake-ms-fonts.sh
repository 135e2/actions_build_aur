#!/bin/bash
set -euxo pipefail

. "$H/build-custom.sh" fake-ms-fonts
sed -i 's/sans-serif/Noto Sans CJK SC/g' 56-fake-ms-fonts.conf
sed -i 's/monospace/Noto Mono CJK SC/g' 56-fake-ms-fonts.conf
sed -i 's/serif/Noto Serif CJK SC/g' 56-fake-ms-fonts.conf
. "$H/build-custom.sh" build
