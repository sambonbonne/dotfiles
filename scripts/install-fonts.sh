#!/usr/bin/env sh

set -e

mkdir -p "${HOME}/.local/share/fonts"

download_nerd_font() {
  FONT_NAME="${1}"
  FONT_FORMAT="${2}"

  NERD_FONT_PACKAGE="$(mktemp)"
  NERD_FONT_RELEASE="$(curl --silent --location https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep -F '"name":' \
    | head -n 1 \
    | cut -d ':' -f 2 \
    | cut -d '"' -f 2)"

  curl --location --output "${NERD_FONT_PACKAGE}" "https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONT_RELEASE}/${FONT_NAME}.tar.xz"
  tar -C "${HOME}/.local/share/fonts" -xf "${NERD_FONT_PACKAGE}" --wildcards "*.${FONT_FORMAT}"

  rm "${NERD_FONT_PACKAGE}"
}

download_nerd_font "Hack" "ttf"
download_nerd_font "OpenDyslexic" "otf"
