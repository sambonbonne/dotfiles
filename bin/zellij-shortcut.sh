#!/usr/bin/env sh

function zj() {
  SESSIONS_LIST="$(zellij list-sessions --no-formatting | grep -vF EXITED | sed -e 's/(current)//g' | tr -s '[:blank:]')"

  if [ ! -z "${SESSIONS_LIST}" ]; then
    if which sk 2>&1 >/dev/null; then
      if [ -z "${1}" ]; then
        zellij attach "$(echo "${SESSIONS_LIST}" | sk)"
      else
        SELECTED_SESSION="$(echo "${SESSIONS_LIST}" | sk -0 -1 --query "${1}")"

        if [ -z "${SELECTED_SESSION}" ]; then
          zellij attach --create "${1}"
        else
          zellij attach "${SELECTED_SESSION}"
        fi
      fi
    else
      echo "${SESSIONS_LIST}"
    fi
  elif [ ! -z "${1}" ]; then
    zellij attach --create "${1}"
  fi
}
