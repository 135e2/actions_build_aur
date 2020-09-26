#!/bin/bash
set -euxo pipefail

# Setup ssh files
mkdir ~/.ssh
echo "$SSH_KEY" > ~/.ssh/id_rsa
echo "$SSH_CONFIG" > ~/.ssh/config

# Use rsync to transfer
pacman -S rsync openssh --noconfirm --needed &> /dev/null
rsync -av /home/builduser/localrepo/ host:aur/x86_64