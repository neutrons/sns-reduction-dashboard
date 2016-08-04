#!/bin/sh
set -euo pipefail

waitfor() {
    while ! nc -z $1 $2; do
        echo "Waiting for $1..."
        sleep 1
    done
}

if [ $# -eq 1 -a "${1:-}" = start ]; then
    if [ "$USE_WEBPACK_DEV_SERVER" = true ]; then
        set -- webpack-server.js
    else
        set -- node /node_modules/.bin/webpack --watch
    fi
fi

if [ $# -eq 1 -a "${1:-}" = watcher ]; then
    set -- watch.sh $0 start
fi

if [ $# -eq 1 -a "${1:-}" = reload ]; then
    set -- touch /reload
fi

exec "$@"
