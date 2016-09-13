#!/bin/bash

env_vars_to_makefile() {
    local env_file sep
    env_file=${1?:Must supply env filename}
    while true; do
        read line || break;
        [ "${#line}" -eq 0 ] && continue;
        [ "${line:0:1}" = "#" ] && continue;
        var=${line%%=*};
        value=${line#*=};
        printf 'define %s\n' "$var"
        printf '%s\n' "$value"
        printf 'endef\n'
        printf 'export %s\n' "$var"
        printf 'ENV_VARIABLES := $(ENV_VARIABLES) %s\n' "${var:+$var }"
        printf '\n'
    done <"$env_file" | \
        while true; do
            read line || break
            printf "%s@@@" "$line"
        done
}

env_vars_to_makefile "$@"
