#!/bin/bash

##
#
# Helpers
#
#######

function clean-lines {
    local QUANTITY="$1"
    tput cuu "$QUANTITY"
    tput ed
}

function throw-handy-error {
    local CODE=$1
    local TEXT=$2
    echo -e "\033[1;31mError[$CODE]| $TEXT\033[0m"
    exit $CODE
}

function check-value-in-array {
    local VALUE="$1"
    shift
    local ARRAY=("$@")
    for ITEM in "${ARRAY[@]}"
    do
        if [[ "$ITEM" == "$VALUE" ]]
        then
            return 0
        fi
    done
    return 1
}

function edit-env-file {
    if [ -z "$$1" ] || [ -z "$$2" ] || [ -z "$3" ]
    then
        throw-handy-error 1001 "(edit-env-file) Usage: <env_file> <key> <value>"
    fi
    
    local ENV_FILE="$1"
    local KEY="$2"
    local VALUE="$3"
    
    if grep -q "^$KEY=" "$ENV_FILE"
    then
        sed -i "s|^$KEY=.*|$KEY="$VALUE"|" "$ENV_FILE"
    else
        echo "$KEY=$VALUE" >> "$ENV_FILE"
    fi
}

function center-text {
    local TEXT="$1"
    local PATTERN=${2:-" "}
    local STYLE=${3:-"0"}
    local WIDTH=$(tput cols)
    local PADDING_WIDTH=$((WIDTH - ${#TEXT}))
    local PADDING=""
    
    if [ ${#PATTERN} -le 0 ]
    then
        throw-handy-error 1002 "(center-text) Set wrong PATTERN!"
    fi
    
    for ((i = 0; i < PADDING_WIDTH / (${#PATTERN}*2) ; i++))
    do
        PADDING+="${PATTERN}"
    done
    
    echo -e "\033[${STYLE}m${PADDING}${TEXT}${PADDING}\033[0m"
}

function copy-associative-array {
    declare -n SOURCE_ARRAY="$1"
    declare -n TARGET_ARRAY="$2"
    
    for KEY in "${!SOURCE_ARRAY[@]}";
    do
        echo "${SOURCE_ARRAY[$KEY]}"
        TARGET_ARRAY[$KEY]="${SOURCE_ARRAY[$KEY]}"
    done
}