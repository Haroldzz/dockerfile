#!/usr/bin/env bash
#
set -e

if command -v -- "$1" >/dev/null 2>&1 ; then
    set -- "$@"
else
    set -- redis-server "$@" /etc/redis/redis.conf
fi

exec "$@"
