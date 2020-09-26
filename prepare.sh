#!/bin/bash
set -euxo pipefail

REPO=est

# Update system
pacman -Syu base-devel --noconfirm --needed &> /dev/null

# Create non-root user for makepkg
useradd builduser -m
passwd -d builduser
echo 'builduser ALL=(ALL) ALL' >> /etc/sudoers

# Install aurutils
cp * /home/builduser
cd ~ # default working directory is /__w/aur-action/aur-action
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz
tar -xf aurutils.tar.gz
chmod a+w aurutils # for builduser
pushd aurutils
sudo -u builduser makepkg -sci --needed --noconfirm --noprogressbar
popd

# Create local repository
cat << EOF >> /etc/pacman.conf
[$REPO]
SigLevel = Optional TrustAll
Server = file:///home/builduser/localrepo
EOF
sudo -u builduser mkdir /home/builduser/localrepo
sudo -u builduser repo-add "/home/builduser/localrepo/$REPO.db.tar.zst"
pacman -Sy

cat /home/builduser/makepkg.conf >> /etc/makepkg.conf