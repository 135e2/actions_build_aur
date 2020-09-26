#!/bin/bash
set -euxo pipefail

pacman -S rsync openssh --noconfirm --needed &> /dev/null
echo "$SSH_KEY" > ssh_key

rsync -av --delete -e "ssh -i ./ssh_key -p $SSH_PORT -o StrictHostKeyChecking=no" \
    /home/builduser/localrepo/ "$REMOTE_REPO"