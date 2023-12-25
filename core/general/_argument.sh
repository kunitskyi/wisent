#!/bin/bash

##
#
# Argument Logic
#
#######

# --- Global Variable in File --- #
# - GLOBAL_NEED_RESTART

function folder-argument-logic {
    
    local -n CURRENT_ARGUMENT="$1"
    local ARGUMENT_VALUE="$2"
    local -n REFERENCE_GLOBAL_ARGUMENTS="$3"
    local ARGUMENT_NAME="$4"
    local ARGUMENT_DIR="$5"
    local ARGUMENT_PATTERN="$6"
    local USER_INPUT=""
    
    generate-folder-argument-array REFERENCE_GLOBAL_ARGUMENTS $ARGUMENT_DIR $ARGUMENT_PATTERN
    
    if check-value-in-array "${ARGUMENT_VALUE}" "${REFERENCE_GLOBAL_ARGUMENTS[@]}"
    then
        CURRENT_ARGUMENT="${ARGUMENT_VALUE}"
    else
        
        GLOBAL_NEED_RESTART=1 # !!! BE AWARE GLOBAL VARIABLE HERE
        
        show-header
        echo -e "\033[1;37mSelect \033[33m${ARGUMENT_NAME}\033[37m argument:\033[0m \033[1;2;3;32m(Enter FULL name of argument)\033[0m"
        
        for ITEM in "${REFERENCE_GLOBAL_ARGUMENTS[@]}"
        do
            echo " - ${ITEM}"
        done
        
        custom-read USER_INPUT
        
        if check-value-in-array "$USER_INPUT" "${REFERENCE_GLOBAL_ARGUMENTS[@]}"
        then
            CURRENT_ARGUMENT="${USER_INPUT}"
        else
            folder-argument-logic $CURRENT_ARGUMENT $ARGUMENT_VALUE $REFERENCE_GLOBAL_ARGUMENTS $ARGUMENT_NAME $ARGUMENT_DIR $ARGUMENT_PATTERN
        fi
    fi
    
}

function generate-folder-argument-array {
    
    local -n REFERENCE_OF_GLOBAL_ARGUMENTS="$1"
    local ARGUMENT_DIR="$2"
    local ARGUMENT_PATTERN="$3"
    
    local ARGUMENT_FOLDER_ARRAY=($(ls -d ${ARGUMENT_DIR}/*))
    
    local FOLDER_NAME=""
    
    REFERENCE_OF_GLOBAL_ARGUMENTS=()
    
    for ITEM in "${ARGUMENT_FOLDER_ARRAY[@]}"
    do
        FOLDER_NAME=$(basename "${ITEM}")
        
        if [[ "${FOLDER_NAME}" =~ $ARGUMENT_PATTERN ]]
        then
            REFERENCE_OF_GLOBAL_ARGUMENTS+=("${FOLDER_NAME}")
        fi
    done
}