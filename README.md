My dotfiles
===========


Requirements and usage
----------------------

1. Install [Dotter](https://github.com/SuperCuber/dotter).
2. Clone with `git clone --recurse-submodules`.
3. Run `dotter deploy` in the cloned repository.
4. Run `sh ./scripts/setup-gnome.sh && sh ./scripts/install-applications.sh`.
5. Enjoy!

When updating, run `git pull && git submodule update`.


Information
-----------

Submodules are used for some configuration, that's why a recursive clone is required.

The `scripts/` directory is used to contain various "installation scripts" that are not linked files.
