#!/bin/sh
set -euo pipefail

getmodtime() {
    date +%s -r "$1"
}

main() {
    file=/reload
    lasttime=0
    pid=

    while sleep 1; do
        curtime=$(getmodtime "$file")
        if [ "$curtime" -gt "$lasttime" ]; then
            if [ -n "$pid" ] && kill -0 "$pid"; then
                echo "kill $pid: $@"
                kill -INT "$pid"
                wait
            fi

            echo running "$@"
            "$@" &
            pid=$!
            echo "started $pid: $@"

            lasttime=$curtime
        fi
    done
}

main "$@"
