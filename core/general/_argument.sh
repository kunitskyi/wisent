#!/bin/bash

##
#
# Argument Logic
#
#######

# --- Global Variable in File --- #
# - GLOBAL_NEED_RESTART

function folder-argument-logic {
    
    local PASSTHROUGH_VAR_NAME="$1"
    local PASSTHROUGH_VAR_VALUE="$2"
    local PASSTHROUGH_GLOBAL_ARRAY_NAME="$3"
    local ARGUMENT_NAME="$4"
    local ARGUMENT_DIR="$5"
    local ARGUMENT_PATTERN="$6"
    local LOCAL_ARRAY_REFERENCE=()
    local USER_INPUT=""
    
    generate-folder-argument-array $PASSTHROUGH_GLOBAL_ARRAY_NAME $ARGUMENT_DIR $ARGUMENT_PATTERN
    
    eval "LOCAL_ARRAY_REFERENCE=(\"\${${PASSTHROUGH_GLOBAL_ARRAY_NAME}[@]}\")"
    
    if check-value-in-array "${PASSTHROUGH_VAR_VALUE}" "${LOCAL_ARRAY_REFERENCE[@]}"
    then
        eval "$PASSTHROUGH_VAR_NAME=\"${PASSTHROUGH_VAR_VALUE}\""
    else
        
        GLOBAL_NEED_RESTART=1 # !!! BE AWARE GLOBAL VARIABLE HERE
        
        show-header
        echo -e "\033[1;37mSelect \033[33m${ARGUMENT_NAME}\033[37m argument:\033[0m \033[1;2;3;32m(Enter FULL name of argument)\033[0m"
        
        for ITEM in "${LOCAL_ARRAY_REFERENCE[@]}"
        do
            echo " - ${ITEM}"
        done
        
        custom-read USER_INPUT
        
        if check-value-in-array "$USER_INPUT" "${LOCAL_ARRAY_REFERENCE[@]}"
        then
            eval "$PASSTHROUGH_VAR_NAME=\"$USER_INPUT\""
        else
            folder-argument-logic $PASSTHROUGH_VAR_NAME $PASSTHROUGH_VAR_VALUE $PASSTHROUGH_GLOBAL_ARRAY_NAME $ARGUMENT_NAME $ARGUMENT_DIR $ARGUMENT_PATTERN
        fi
    fi
    
}

function generate-folder-argument-array {
    
    local PASSTHROUGH_GLOBAL_ARRAY_NAME="$1"
    local ARGUMENT_DIR="$2"
    local ARGUMENT_PATTERN="$3"
    
    local ARGUMENT_FOLDER_ARRAY=($(ls -d ${ARGUMENT_DIR}/*))
    
    local FOLDER_NAME=""
    
    eval "$PASSTHROUGH_GLOBAL_ARRAY_NAME=()"
    
    for ITEM in "${ARGUMENT_FOLDER_ARRAY[@]}"
    do
        FOLDER_NAME=$(basename "${ITEM}")
        
        if [[ "${FOLDER_NAME}" =~ $ARGUMENT_PATTERN ]]
        then
            eval "$PASSTHROUGH_GLOBAL_ARRAY_NAME+=(\"${FOLDER_NAME}\")"
        fi
    done
}