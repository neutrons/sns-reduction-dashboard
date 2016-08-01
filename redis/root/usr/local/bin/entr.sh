#!/bin/bash
set -euo pipefail

getmodtime() {
    date +%s -r "$1"
}

main() {
    read file || exit 1
    lasttime=0
    pid=

    while sleep 1; do
        curtime=$(getmodtime "$file")
        if [ "$curtime" -gt "$lasttime" ]; then
            if [ -n "$pid" -a "$pid" -gt 0 ]; then
                kill "$pid"
                wait
            fi

            echo "$@"
            "$@" &
            pid=$!

            lasttime=$curtime
        fi
    done
}

main "$@"
