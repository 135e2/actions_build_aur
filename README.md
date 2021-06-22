# actions_build_aur
## Features
- Auto build aur packages
- Support own PKGBUILD(submodule)
- GPG sign
## Usage
- Edit [my_pkgs](https://github.com/135e2/actions_build_aur/blob/sinofp/build.sh#L4)
- Configure [GPG_PRIVATE_KEY_URL,GPG_PRIVATE_KEY_PASSWORD](https://github.com/135e2/actions_build_aur/blob/sinofp/.github/workflows/build.yml#L33); [RCLONE_CONFIG_URL](https://github.com/135e2/actions_build_aur/blob/sinofp/.github/workflows/build.yml#L42) in Repo Settings/secrets
## Credits
- https://github.com/sinofp/aur-action
