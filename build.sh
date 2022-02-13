#!/bin/bash
set -euxo pipefail

# Setup makepkg conf
cat makepkg.conf >>/etc/makepkg.conf
sed 's/SKIPPGPCHECK=0/SKIPPGPCHECK=1/' /usr/bin/makepkg -i

H=$(pwd)
export H

echo ">>>>>>>>> building ${PACKAGE_NAME}"
SECONDS=0
if [ -e "custom/${PACKAGE_NAME}.sh" ]; then
    "./custom/${PACKAGE_NAME}.sh"
elif [ -d "custom/${PACKAGE_NAME}" ]; then
    . "$H/custom.sh" cd "${PACKAGE_NAME}"
    . "$H/custom.sh" build
else
    sudo -u builduser aur sync "${PACKAGE_NAME}" --no-view --no-confirm #--sign # --rm-deps
fi
echo "<<<<<<<<< ${PACKAGE_NAME} built, $SECONDS seconds used."
