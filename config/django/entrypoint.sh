#!/bin/sh
set -e

if [ "$1" = "django-server" ]; then
    cd /app
    set -- make
fi

exec "$@"
