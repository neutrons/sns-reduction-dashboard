#!/bin/bash

get_targets_and_help() {
    local makefile first line re target comment temp flag
    makefile=$1
    first=$2
    flag=

    while IFS= read -r line; do
        re=$'## '
        if [[ ! $line =~ $re ]]; then
            continue
        fi

        re=$'^([^:]+):.*## (.+)'
        if [[ ! $line =~ $re ]]; then
            printf $'Line does not follow the right comment style\n'
            printf $'  "%s"\n' "$line"
            continue
        fi

        if [ -z "$flag" -a -z "$first" ]; then
            printf $'\n'

            # printf -v temp $'%*s' "$(($COLUMNS - ${#makefile} - 4))" ''
            # temp=${temp// /#}

            # printf $'## %s %s\n' "$makefile" "$temp"
            flag=1
        fi

        target=${BASH_REMATCH[1]}
        comment=${BASH_REMATCH[2]}

        if [[ $target == all ]]; then
            target=
        fi

        printf -v temp $'make %s' "$target"
        printf $'%-30s %s\n' "$temp" "$comment"
    done <"$makefile"
}

print_help() {
    local makefile first
    first=1

    for makefile; do
        get_targets_and_help "$makefile" "$first"
        first=
    done
}

print_help "$@"
