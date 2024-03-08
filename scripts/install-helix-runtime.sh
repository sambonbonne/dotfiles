#!/usr/bin/env sh

set -e

HELIX_PACKAGE="$(mktemp)"

HELIX_RELEASE="$(curl --silent --location https://api.github.com/repos/helix-editor/helix/releases/latest \
  | grep -F '"name":' \
  | head -n 1 \
  | cut -d ':' -f 2 \
  | cut -d '"' -f 2)"

curl --location --output "${HELIX_PACKAGE}" "https://github.com/helix-editor/helix/releases/download/${HELIX_RELEASE}/helix-${HELIX_RELEASE}-x86_64-linux.tar.xz"
tar -C "${HOME}/.config/helix" --strip-components=1 -xf "${HELIX_PACKAGE}" "helix-${HELIX_RELEASE}-x86_64-linux/runtime" "helix-${HELIX_RELEASE}-x86_64-linux/contrib"

rm "${HELIX_PACKAGE}"
