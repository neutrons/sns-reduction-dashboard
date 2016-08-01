#!/bin/sh
set -euo pipefail

if [ "${1:-}" = 'docker-entrypoint.sh' -a "${2:-}" = 'redis-server' ]; then
    set -- sh /usr/local/bin/entr.sh "$@"
fi

if [ "${1:-}" = 'reload' ]; then
    set -- touch /reload
fi

exec "$@"
