#!/usr/bin/env sh

##
# Python virtualenv facility
#
# Usage: venv <virtualenv-name>
##

test "${VIRTUAL_ENV}" = "" && test "${1}" = "" && exit 0

if [ "${VIRTUAL_ENV}" = "" ]; then
  VENV_SOURCE_PATH="$(pwd)/${1}/bin/activate"

  if [ ! -f "${VENV_SOURCE_PATH}" ]; then
    echo "${1} virtual env does not exist, create it? [y/n]"
    read -r VENV_CREATE

    test "${VENV_CREATE}" != "y" && exit 0
    python3 -m venv "${1}"
  fi

  . "${VENV_SOURCE_PATH}"
  rehash 2>/dev/null || true
elif [ "${1}" = "update" ]; then
  python3 -m pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
else
  deactivate || unset VIRTUAL_ENV
  rehash
fi
