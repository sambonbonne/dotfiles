#!/usr/bin/env sh

RESOURCE="${1}"

if [ "${2}" != "" ]; then
  RESOURCE="${RESOURCE}/${2}"
fi

kubectl patch "${RESOURCE}" --type json --patch '[{"op":"remove","path":"/metadata/finalizers"}]'
