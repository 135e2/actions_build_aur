gpg --keyserver keys.openpgp.org --recv-keys "$GPG_KEY"
curl -o private_key "$GPG_PRIVATE_KEY_URL"
gpg --import --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" private_key
pushd /home/builduser/localrepo || exit 1
# shellcheck disable=SC2044
for files in $(find $1 -name "*.pkg.tar.zst"); do
    gpg --detach-sign --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" $files
done
popd || exit 1
