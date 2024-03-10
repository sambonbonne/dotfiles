#!/usr/bin/env sh

usage() {
  echo "Usage: pdf-shrink <s|xs> <input-file.pdf> <output-file.pdf>"
}

DESIRED_SIZE="${1}"
INPUT_FILE="${2}"
OUTPUT_FILE="${3}"
PDF_SETTINGS=""

if [ "${DESIRED_SIZE}" = "" ]; then
  usage
  exit 0
elif [ "${DESIRED_SIZE}" = "s" ]; then
  PDF_SETTINGS="/ebook"
elif [ "${DESIRED_SIZE}" = "xs" ]; then
  PDF_SETTINGS="/screen"
else
  usage
  exit 1
fi

gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 "-dPDFSETTINGS=${PDF_SETTINGS}" -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${OUTPUT_FILE}" "${INPUT_FILE}"
