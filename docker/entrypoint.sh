#!/usr/bin/env bash
set -e

parse_true() {
    [ -n "${1:-}" ] || return 1
    case "${1,,}" in
        1|true|t|yes|y|on)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

eval "$(ssh-agent -s)" > /dev/null

: "${SSH_PRIVATE_KEY:=$(cat /run/secrets/ssh-private-key 2>/dev/null || true)}"
: "${GIT_USER_NAME:=$(cat /run/secrets/git-user-name 2>/dev/null || true)}"
: "${GIT_USER_EMAIL:=$(cat /run/secrets/git-user-email 2>/dev/null || true)}"
: "${SHELL_EXPAND_ALIASES:=false}"

[ -z "${SSH_PRIVATE_KEY}"      ] || tr -d '\r' <<< "${SSH_PRIVATE_KEY}"| ssh-add -
[ -z "${GIT_USER_NAME}"        ] || git config --global user.name "${GIT_USER_NAME}"
[ -z "${GIT_USER_EMAIL}"       ] || git config --global user.email "${GIT_USER_EMAIL}"
! parse_true "${SHELL_EXPAND_ALIASES}" || shopt -s expand_aliases

exec "${@}"
