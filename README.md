# actions_build_aur
## Features
- Build aur packages regularly
- Support own PKGBUILD (through submodules)
- GPG signing
## Usage
- Edit [my_pkgs](https://github.com/135e2/actions_build_aur/blob/sinofp/build.sh#L4) list.
- Configure [GPG_PRIVATE_KEY_URL](https://github.com/135e2/actions_build_aur/blob/eb13ee6c29e540de692c520ca5997797af80f244/.github/workflows/build.yml#L36), [GPG_PRIVATE_KEY_PASSWORD](https://github.com/135e2/actions_build_aur/blob/2c7ea098336f85404762fc73ff4ecb1d503b04d0/.github/workflows/build.yml#L36), [RCLONE_CONFIG_URL](https://github.com/135e2/actions_build_aur/blob/eb13ee6c29e540de692c520ca5997797af80f244/.github/workflows/build.yml#L45) in Repo Settings/Security/Secrets and variables/Actions Page.
## Credits
- https://github.com/sinofp/aur-action
## License
- BSD 2-Clause License
