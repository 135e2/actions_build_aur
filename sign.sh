#!/bin/bash

function sign() {
    info "Fetching GPG key used for signing..."
    gpg --keyserver keyserver.ubuntu.com --recv-keys "$GPGKEY"
    curl -o private_key "$GPG_PRIVATE_KEY_URL"
    info "Importin private key..."
    gpg --import --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" private_key
    pushd /home/builduser/localrepo
    for files in $(find $1 -name "*.pkg.tar.zst"); do
        info "Signing $files..."
        gpg --detach-sign --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" $files
    done
    popd
}
