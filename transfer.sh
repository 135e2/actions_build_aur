#!/bin/bash
set -euxo pipefail
cd /home/builduser
mv "localrepo/135e2.db.tar.zst" "localrepo/135e2.db"
mv "localrepo/135e2.files.tar.zst" "localrepo/135e2.files"
pacman -S rclone curl --noconfirm --needed &>/dev/null
curl -o rclone.conf "$RCLONE_CONFIG_URL" 
rclone sync /home/builduser/localrepo VPS:../www/wwwroot/mirror.135e2.eu.org/archlinux/135e2/x86_64 -P --config rclone.conf
