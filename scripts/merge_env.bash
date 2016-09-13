#!/bin/bash

parse-line() {
    local line var value
    line=$1

    if [ "${#line}" -eq 0 ] || [ "${line:0:1}" = "#" ]; then
        printf '%s\n' "$line"
        continue
    fi

    var=${line%%=*};
    value=${line#*=};
    printf '%s\n' "$var";
}

merge_env() {
    local current_file base_file old_ifs current_parsed base_parsed
    current_file=${1:-.env}
    base_file=${2:-.env.base}
    old_ifs=$IFS
    IFS=

    while true; do
        read -r current || break;
        while true; do
            read -r base <&3 || break 2;
            current_parsed=$(parse-line "$current")
            base_parsed=$(parse-line "$base")
            if [[ $current_parsed == $base_parsed ]]; then
                printf '%s\n' "$current"
                break
            else
                printf '%s\n' "$base"
            fi
        done
    done <"$current_file" 3<"$base_file"

    IFS=$old_ifs
}

merge_env "$@"
