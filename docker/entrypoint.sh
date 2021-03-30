#!/usr/bin/env bash
set -e

eval $(ssh-agent -s)

[ -z "${SSH_PRIVATE_KEY}" ] || echo "${SSH_PRIVATE_KEY}" | tr -d '\r' | ssh-add -
[ -z "${GIT_USER_NAME}" ] || git config --global user.name "${GIT_USER_NAME}"
[ -z "${GIT_USER_EMAIL}" ] || git config --global user.email "${GIT_USER_EMAIL}"

shopt -s expand_aliases

exec "$@"