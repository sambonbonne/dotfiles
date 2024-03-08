My dotfiles
===========


Requirements and usage
----------------------

1. Install [Dotter](https://github.com/SuperCuber/dotter).
2. Clone with `git clone --recurse-submodules`.
3. Create your `.dotter/local.toml` configuration and run `dotter deploy` in the cloned repository.
4. Run `sh ./scripts/*.sh` (expect if you setup a server, you will only need to run `./scripts/install-helix-runtime.sh`).
5. Enjoy!

When updating, run `git pull && git submodule update`.


Information
-----------

Submodules are used for some configuration, that's why a recursive clone is required.

The `scripts/` directory is used to contain various "installation scripts" that are not linked files.
