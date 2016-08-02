#!/bin/sh
set -euo pipefail

if [ "${1:-}" = start -a $# -eq 1 ]; then
    if [ "$PORT" -eq 80 ]; then
        newport=
    else
        newport=:$PORT
    fi

    vars='$HOST,$PORT,$COLONPORT'
    conf=/etc/nginx/conf.d/default.conf

    COLONPORT=$newport \
             envsubst "$vars" \
             < $conf.template \
             > $conf

    set -- nginx -g "daemon off;"
fi

if [ "${1:-}" = watcher -a $# -eq 1 ]; then
    set -- entr.sh $0 start
fi

if [ "${1:-}" = reload -a $# -eq 1 ]; then
    set -- touch /reload
fi

exec "$@"
