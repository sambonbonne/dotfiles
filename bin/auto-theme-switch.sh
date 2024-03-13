#!/usr/bin/env sh

set -e
set -o pipefail

##
# This script toggle light and dark themes following the freedesktop preference: if you change the theme using Gnome's theme variant setting, it will change the theme on other softwares
#
# The script users freedesktop's settings portal so it sets the Gnome preference "just in case"
##

ALACRITTY_CONFIG_FILE="${HOME}/.config/alacritty/alacritty.toml"
BAT_CONFIG_FILE="${HOME}/.config/bat/config"
DELTA_CONFIG_FILE="${HOME}/.gitconfig"
HELIX_CONFIG_FILE="${HOME}/.config/helix/config.toml"
ZELLIJ_CONFIG_FILE="${HOME}/.config/zellij/config.kdl"

update_file_parameter() {
  FILE_PATH="${1}"
  SEARCH_LINE="${2}"
  LIGHT_PARAMETER="${3}"
  DARK_PARAMETER="${4}"

  if [ -f "${FILE_PATH}" ]; then
    if [ "${SET_THEME_VARIANT_TO}" = "dark" ]; then
      sed --follow-symlinks --in-place "/${SEARCH_LINE}/s/${LIGHT_PARAMETER}/${DARK_PARAMETER}/g" "${FILE_PATH}"
    elif [ "${SET_THEME_VARIANT_TO}" = "light" ]; then
      sed --follow-symlinks --in-place "/${SEARCH_LINE}/s/${DARK_PARAMETER}/${LIGHT_PARAMETER}/g" "${FILE_PATH}"
    else
      echo "The dark|light argument is invalid" >&2
      exit 1
    fi
  fi
}

set_theme() {
  echo "Setting theme to variant: ${SET_THEME_VARIANT_TO}"

  update_file_parameter "${ALACRITTY_CONFIG_FILE}" "themes" "gruvbox_light" "gruvbox_dark"
  update_file_parameter "${BAT_CONFIG_FILE}" "--theme" "gruvbox-light" "gruvbox-dark"
  update_file_parameter "${HELIX_CONFIG_FILE}" "theme =" "gruvbox_light" "gruvbox"
  update_file_parameter "${ZELLIJ_CONFIG_FILE}" "theme" "gruvbox-light" "gruvbox-dark"
  update_file_parameter "${DELTA_CONFIG_FILE}" "syntax-theme" "gruvbox-light" "gruvbox-dark"

  if [ "${SET_THEME_VARIANT_TO}" = "light" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'default'
  elif [ "${SET_THEME_VARIANT_TO}" = "dark" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  else
    echo "Called theme update with unknown variant: ${SET_THEME_VARIANT_TO}" >&2
  fi
}

echo "Starting to listen theme switch event with dbus-monitor"

# monitor theme changes
dbus-monitor --session \
  'path=/org/freedesktop/portal/desktop' \
  'interface=org.freedesktop.impl.portal.Settings' \
  'member=SettingChanged' \
  | grep --line-buffered --fixed-strings 'variant' \
  | grep --line-buffered --fixed-strings 'uint32' \
  | stdbuf -oL tr --squeeze-repeats '[:blank:]' \
  | sed --unbuffered --expression 's/^[[:space:]]*//' \
  | stdbuf -oL cut --delimiter ' ' --fields 3 \
  | stdbuf -oL uniq \
  | while IFS= read -r THEME_VARIANT; do
    if [ "${THEME_VARIANT}" = "0" ]; then
      echo "Detected switch to theme variant: light"
      SET_THEME_VARIANT_TO="light" set_theme
    elif [ "${THEME_VARIANT}" = "1" ]; then
      echo "Detected switch to theme variant: dark"
      SET_THEME_VARIANT_TO="dark" set_theme
    else
      echo "Detected switch to unknown theme variant: ${THEME_VARIANT}" >&2
    fi

  done
