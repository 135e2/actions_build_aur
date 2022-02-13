#!/bin/bash
set -euxo pipefail

gpg --keyserver keys.openpgp.org --recv-keys "$GPG_KEY"
curl -o private_key "$GPG_PRIVATE_KEY_URL"
gpg --import --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" private_key
pushd /home/builduser/localrepo || exit 1
# sign packages
# shellcheck disable=SC2086
for f in $(find $1 -name "*.pkg.tar.zst"); do
    gpg --detach-sign --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" "$f"
    repo-add "$REPO_NAME".db.tar.zst "$f"
done
# sign *.{db,files}
# shellcheck disable=SC2044
# shellcheck disable=SC2086
files=(
  *.db
  *.files
)
for f in "${files[@]}"; do
    gpg --detach-sign --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" "$f"
done
popd || exit 1
