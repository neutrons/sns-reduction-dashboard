#!/bin/sh
set -euo pipefail

if [ $# -eq 0 ]; then
    python3 manage.py collectstatic --noinput
    NODE_PATH=/node_modules /node_modules/.bin/webpack --debug
    set -- uwsgi --ini /etc/uwsgi.ini
fi

exec "$@"
