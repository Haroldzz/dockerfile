#!/usr/bin/env bash
#
set -e

if ! command -v -- "$1" >/dev/null 2>&1 ; then
    set -- java -jar "$APP_HOME/start.jar" "$@"
fi

if [ -n "$TMPDIR" ] ; then
    case "$JAVA_OPTIONS" in
        *-Djava.io.tmpdir=*) ;;
        *) JAVA_OPTIONS="-Djava.io.tmpdir=$TMPDIR $JAVA_OPTIONS" ;;
    esac
fi

if [ "$1" = "java" -a -n "$JAVA_OPTIONS" ] ; then
    shift
    set -- java $JAVA_OPTIONS "$@"
fi

exec "$@"
