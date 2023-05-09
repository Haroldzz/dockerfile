#!/usr/bin/env bash
#
set -e

if command -v -- "$1" >/dev/null 2>&1 ; then
    set -- "$@"
else
    set -- haproxy "$@" -f /etc/haproxy/haproxy.cfg
fi

exec "$@"
