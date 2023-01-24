gpg --keyserver keys.openpgp.org --recv-keys 0F43EA08654E5BCA 
curl -o private_key "$GPG_PRIVATE_KEY_URL"
gpg --import --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" private_key
pushd /home/builduser/localrepo
for files in $(find $1 -name "*.pkg.tar.zst"); do
    gpg --detach-sign --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" $files
done
popd
