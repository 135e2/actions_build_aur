#!/bin/bash
# set -euxo pipefail
# shellcheck disable=SC2164

. utils/logging.sh

function prepare() {
    debug "REPO: ${REPO}\tGPGKEY: ${GPGKEY}"

    info "Doing a full system upgrade and installing base pkgs..."
    pacman -Syu base-devel git rclone curl --noconfirm --needed &>/dev/null
    info "Creating a build user for makepkg..."
    useradd builduser -m
    passwd -d builduser
    echo 'builduser ALL=(ALL) ALL' >>/etc/sudoers

    # Fix mkdir: cannot create directory ‘/run/user/1000’: Permission denied
    # https://github.com/AladW/aurutils/commit/5341c059736d3eff59daea5cb52b7d35c98d0824
    info "Applying workaround for aurutils..."
    xdg_runtime_dir="/run/user/$(id -u builduser)"
    mkdir -p "$xdg_runtime_dir"
    chown -R builduser "$xdg_runtime_dir"

    info "Installing aurutils..."
    curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz
    tar -xf aurutils.tar.gz
    chmod a+w aurutils # for builduser
    pushd aurutils
    sudo -u builduser makepkg -sci --needed --noconfirm --noprogressbar
    popd

    info "Creating local repository..."
    printf "[%s]\nSigLevel = Optional TrustAll\nServer = file:///home/builduser/localrepo" "${REPO}" >> /etc/pacman.conf
    sudo -u builduser mkdir /home/builduser/localrepo
    sudo -u builduser repo-add "/home/builduser/localrepo/$REPO.db.tar.zst"
    # Refreshing repo is nedded
    pacman -Sy

    info "Initializing GnuPG..."
    rm -rf /etc/pacman.d/gnupg
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --recv-keys $GPGKEY --keyserver keyserver.ubuntu.com
    while [ $? -ne 0 ]; do
        pacman-key --recv-keys $GPGKEY --keyserver keyserver.ubuntu.com
    done
    pacman-key --lsign-key $GPGKEY

}

prepare
