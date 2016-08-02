#!/bin/sh
set -euo pipefail

waitfor() {
    while ! nc -z $1 $2; do
        echo "Waiting for $1..."
        sleep 1
    done
}

if [ $# -eq 1 -a "${1:-}" = start-uwsgi ]; then
    # Wait for Postgres and Redis
    waitfor postgres 5432
    waitfor redis 6379

    cd /usr/src

    export PYTHONPATH=$(pwd)

    python3 manage.py collectstatic --noinput
    python3 manage.py makemigrations --noinput
    python3 manage.py migrate --noinput
    python3 manage.py make_my_superuser

    echo "path: ${PYTHONPATH:-}"
    echo "home: ${PYTHONHOME:-}"

    set -- uwsgi --ini /etc/uwsgi.ini
fi

if [ $# -eq 1 -a "${1:-}" = start-webpack ]; then
    export NODE_PATH=/node_modules
    if [ "$USE_WEBPACK_DEV_SERVER" = true ]; then
        set -- node webpack-server.js
    else
        set -- node /node_modules/.bin/webpack --watch
    fi
fi

if [ $# -eq 1 -a "${1:-}" = watcher ]; then
    $0 start-webpack &
    set -- entr.sh $0 start-uwsgi
fi

if [ $# -eq 1 -a "${1:-}" = reload ]; then
    set -- touch /reload
fi

exec "$@"
