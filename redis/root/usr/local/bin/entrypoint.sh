#!/bin/sh
set -euxo pipefail

if [ $# -gt 1 ]; then
    if [ "$1" = 'docker-entrypoint.sh' -a "$2" = 'redis-server' ]; then
        set -- sh -c "echo '/reload' | sh /usr/local/bin/entr.sh $*"
    fi
fi

if [ "$1" = 'reload' ]; then
    set -- touch /reload
fi

exec "$@"
