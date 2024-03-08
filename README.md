My dotfiles
===========


Requirements and usage
----------------------

1. Install [Dotter](https://github.com/SuperCuber/dotter).
2. Clone with `git clone --recurse-submodules`.
3. Create your `.dotter/local.toml` (see below) configuration and run `dotter deploy` in the cloned repository.
4. Run `sh ./scripts/*.sh` (expect if you setup a server, you will only need to run `./scripts/install-helix-runtime.sh`).
5. Enjoy!

When updating, run `git pull && git submodule update`.


### Local Dotter configuration

Useful packages:

* `console` (install everywhere, except when you don't use terminal/console/shell)
* `graphics` (install when using a desktop environment)
* `work` (install when you will use development and devops tool)


Information
-----------

Submodules are used for some configuration, that's why a recursive clone is required.

The `scripts/` directory is used to contain various "installation scripts" that are not linked files.
