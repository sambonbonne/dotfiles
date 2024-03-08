#!/usr/bin/env sh

set -e

mkdir -p "${HOME}/.local/share/fonts"

HACK_FONT_PACKAGE="$(mktemp)"
HACK_FONT_RELEASE="$(curl --silent --location https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
  | grep -F '"name":' \
  | head -n 1 \
  | cut -d ':' -f 2 \
  | cut -d '"' -f 2)"

curl --location --output "${HACK_FONT_PACKAGE}" "https://github.com/ryanoasis/nerd-fonts/releases/download/${HACK_FONT_RELEASE}/Hack.tar.xz"
tar -C "${HOME}/.local/share/fonts" -xf "${HACK_FONT_PACKAGE}" --wildcards "*.ttf"

rm "${HACK_FONT_PACKAGE}"
