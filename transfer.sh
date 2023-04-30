#!/bin/bash
set -euxo pipefail

function transfer() {
    cd /home/builduser
    info "Updating repo database..."
    mv -v "localrepo/135e2.db.tar.zst" "localrepo/135e2.db"
    mv -v "localrepo/135e2.files.tar.zst" "localrepo/135e2.files"
    info "Syncing built packages to server..."
    curl -o rclone.conf "$RCLONE_CONFIG_URL"
    rclone sync /home/builduser/localrepo VPS:../srv/www/htdocs/mirror/archlinux/135e2/x86_64 -P --config rclone.conf
}
