#!/bin/sh
set -euo pipefail

if [ "${1:-}" = "redis-server" ]; then
    set -- docker-entrypoint.sh redis-server /usr/local/etc/redis/redis.conf
fi

if [ "${1:-}" = watcher -a $# -eq 1 ]; then
    set -- sh /usr/local/bin/entr.sh $0 redis-server
fi

if [ "${1:-}" = 'reload' -a $# -eq 1 ]; then
    set -- touch /reload
fi

exec "$@"
