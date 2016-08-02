#!/bin/sh
set -euo pipefail

if [ "${1:-}" = "start" ]; then
    set -- docker-entrypoint.sh redis-server /usr/local/etc/redis/redis.conf
fi

if [ "${1:-}" = watcher -a $# -eq 1 ]; then
    set -- sh /usr/local/bin/watch.sh $0 start
fi

if [ "${1:-}" = 'reload' -a $# -eq 1 ]; then
    set -- touch /reload
fi

exec "$@"
