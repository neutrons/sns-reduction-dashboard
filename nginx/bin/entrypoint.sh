#!/bin/sh
set -euo pipefail

if [ "${1:-}" = start -a $# -eq 1 ]; then
    if [ "$PORT" -eq 80 ]; then
        newport=
    else
        newport=:$PORT
    fi

    LOG_LOC=/dev/null
    if [ "$VERBOSE" = true ]; then
        LOG_LOC=/dev/stdout
    fi

    vars='$HOST,$PORT,$COLONPORT,$LOG_LOC,$LOG_LEVEL,$SERVER_NAME'
    conf=/etc/nginx/conf.d/default.conf

    COLONPORT=$newport \
             LOG_LOC=$LOG_LOC \
             envsubst "$vars" \
             < $conf.template \
             > $conf

    cat $conf

    set -- nginx -g "daemon off;"
fi

if [ "${1:-}" = watcher -a $# -eq 1 ]; then
    set -- watch.sh $0 start
fi

if [ "${1:-}" = reload -a $# -eq 1 ]; then
    set -- touch /reload
fi

exec "$@"
