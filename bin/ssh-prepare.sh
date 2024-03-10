#!/usr/bin/env sh

infocmp | ssh "$@" "tic -x /dev/stdin"
