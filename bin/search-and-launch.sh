#!/usr/bin/env sh

if ! command -v skim >/dev/null; then
  echo "skim is not installed"
  return 1
fi

SEARCH_LIST=""

while read -r SEARCH_LIST_ELEMENT; do
  SEARCH_LIST="${SEARCH_LIST}\n${SEARCH_LIST_ELEMENT}"
done

SEARCH_LIST="$(echo "${SEARCH_LIST}" | sed -e '/^$/d')"

COMMAND="${1}"
QUERY="${2}"

if [ -z "${QUERY}" ] && [ ! -z "${EMPTY_QUERY_COMMAND}" ]; then
  sh -c "${EMPTY_QUERY_COMMAND}"
  return $?
fi

SKIM_PROMPT="❱ "
test ! -z "${SEARCH_PROMPT}" && SKIM_PROMPT="${SEARCH_PROMPT} ${SKIM_PROMPT}"

SKIM_CMD_PROMPT="❱ "
test ! -z "${CMD_PROMPT}" && SKIM_CMD_PROMPT="${CMD_PROMPT} ${SKIM_CMD_PROMPT}"

RESULT=""
if [ -z "${QUERY}" ]; then
  RESULT="$(echo -e "${SEARCH_LIST}" | skim --prompt="${SKIM_PROMPT}" --cmd-prompt="${SKIM_CMD_PROMPT}" --ansi)"
else
  RESULT="$(echo -e "${SEARCH_LIST}" | skim -0 -1 --query "${QUERY}" --prompt="${SKIM_PROMPT}" --cmd-prompt="${SKIM_CMD_PROMPT}" --ansi)"
fi

if [ -n "${RESULT}" ]; then
  eval "${COMMAND} '${RESULT}'"
fi
