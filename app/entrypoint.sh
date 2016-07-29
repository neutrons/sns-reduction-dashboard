#!/bin/sh
set -euo pipefail

waitfor() {
    while ! nc -z $1 $2; do
        echo "Waiting for $1..."
        sleep 1
    done
}

if [ $# -eq 0 ]; then
    # Wait for Postgres and Redis
    waitfor postgres 5432
    waitfor redis 6379

    python3 manage.py collectstatic --noinput
    python3 manage.py makemigrations --noinput
    python3 manage.py migrate --noinput
    python3 manage.py make_my_superuser

    if [ "$USE_WEBPACK_DEV_SERVER" = true ]; then
        NODE_PATH=/node_modules node /server.js &
    else
        NODE_PATH=/node_modules node /node_modules/.bin/webpack
    fi

    set -- uwsgi --ini /etc/uwsgi.ini
fi

exec "$@"
