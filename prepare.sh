#!/bin/bash
# set -euxo pipefail

REPO=135e2

# Update system
pacman -Syu base-devel --noconfirm --needed &>/dev/null

# Create non-root user for makepkg
useradd builduser -m
passwd -d builduser
echo 'builduser ALL=(ALL) ALL' >>/etc/sudoers

# Fix mkdir: cannot create directory ‘/run/user/1000’: Permission denied
# https://github.com/AladW/aurutils/commit/5341c059736d3eff59daea5cb52b7d35c98d0824
xdg_runtime_dir="/run/user/$(id -u builduser)"
mkdir -p "$xdg_runtime_dir"
chown -R builduser "$xdg_runtime_dir"

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

#Install git
pacman -Sy
pacman -S git --noconfirm --needed

#[WIP]Init GPG
GPGKEY=5443E4D4C99F250F
rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman-key --recv-keys $GPGKEY --keyserver keys.openpgp.org
while [ $? -ne 0 ]; do
    pacman-key --recv-keys $GPGKEY --keyserver keys.openpgp.org
done
pacman-key --lsign-key $GPGKEY
