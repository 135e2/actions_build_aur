#!/bin/bash
set -euxo pipefail

REPO=est

# Update system
pacman -Syu base-devel --noconfirm --needed &>/dev/null

# Create non-root user for makepkg
useradd builduser -m
passwd -d builduser
echo 'builduser ALL=(ALL) ALL' >>/etc/sudoers

# Fix mkdir: cannot create directory ‘/run/user/1000’: Permission denied
mkdir -p /run/user/1000
chown -R builduser /run/user/1000

# Install aurutils
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz
tar -xf aurutils.tar.gz
chmod a+w aurutils # for builduser
pushd aurutils
sudo -u builduser makepkg -sci --needed --noconfirm --noprogressbar
popd

# Create local repository
cat <<EOF >>/etc/pacman.conf
[$REPO]
SigLevel = Optional TrustAll
Server = file:///home/builduser/localrepo
EOF
sudo -u builduser mkdir /home/builduser/localrepo
sudo -u builduser repo-add "/home/builduser/localrepo/$REPO.db.tar.zst"
pacman -Sy
