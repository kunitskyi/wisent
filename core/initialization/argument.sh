#!/bin/bash

##
#
# Argument Logic
#
#######

# --- Global Variable in File --- #
# - GLOBAL_NEED_RESTART

function ws:_folder-argument-logic {

    local CURRENT_ARGUMENT_NAME="$1"
    local ARGUMENT_VALUE="$2"
    local ARGUMENTS_NAME="$3"
    local ARGUMENT_NAME="$4"
    local ARGUMENT_DIR="$5"
    local ARGUMENT_PATTERN="$6"
    local -n CURRENT_ARGUMENT_REFERENCE="${CURRENT_ARGUMENT_NAME}"
    local -n ARGUMENTS_REFERENCE="${ARGUMENTS_NAME}"
    local USER_INPUT=""

    ws:_generate-folder-argument-array $ARGUMENTS_NAME $ARGUMENT_DIR $ARGUMENT_PATTERN

    if @check-value-in-array "${ARGUMENT_VALUE}" "${ARGUMENTS_REFERENCE[@]}"; then
        CURRENT_ARGUMENT_REFERENCE="${ARGUMENT_VALUE}"
    else

        GLOBAL_NEED_RESTART=1 # !!! BE AWARE GLOBAL VARIABLE HERE

        @show-header
        echo -e "\033[1;37mSelect \033[33m${ARGUMENT_NAME}\033[37m argument:\033[0m \033[1;2;3;32m(Enter FULL name of argument)\033[0m"

        for ITEM in "${ARGUMENTS_REFERENCE[@]}"; do
            echo " - ${ITEM}"
        done

        @custom-read USER_INPUT

        if @check-value-in-array "$USER_INPUT" "${ARGUMENTS_REFERENCE[@]}"; then
            CURRENT_ARGUMENT_REFERENCE="${USER_INPUT}"
        else
            ws:_folder-argument-logic $CURRENT_ARGUMENT_NAME $ARGUMENT_VALUE $ARGUMENTS_NAME $ARGUMENT_NAME $ARGUMENT_DIR $ARGUMENT_PATTERN
        fi
    fi

}

function ws:_generate-folder-argument-array {

    local -n REFERENCE_OF_GLOBAL_ARGUMENTS="$1"
    local ARGUMENT_DIR="$2"
    local ARGUMENT_PATTERN="$3"

    local ARGUMENT_FOLDER_ARRAY=($(ls -d ${ARGUMENT_DIR}/*))

    local FOLDER_NAME=""

    REFERENCE_OF_GLOBAL_ARGUMENTS=()

    for ITEM in "${ARGUMENT_FOLDER_ARRAY[@]}"; do
        FOLDER_NAME=$(basename "${ITEM}")

        if [[ "${FOLDER_NAME}" =~ $ARGUMENT_PATTERN && "${FOLDER_NAME}" != "NONE" ]]; then # TODO: add regex rules check
            REFERENCE_OF_GLOBAL_ARGUMENTS+=("${FOLDER_NAME}")
        fi
    done
}
