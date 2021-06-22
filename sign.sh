gpg --keyserver keys.openpgp.org --recv-keys 5443E4D4C99F250F
curl -o private_key "$GPG_PRIVATE_KEY_URL"
gpg --import --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" private_key
gpg --detach-sign --pinentry-mode loopback --batch --passphrase "$GPG_PRIVATE_KEY_PASSWORD" /home/builduser/localrepo/*.pkg.tar.zst