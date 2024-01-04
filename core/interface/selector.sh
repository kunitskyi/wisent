#!/bin/bash

##
#
# Selector
#
#######

function selector-logic {
    
    local SELECTOR_ARRAY_NAME="$1"
    local SELECTOR_DESCRIPTION_NAME="$2"
    local -n SELECTOR_ARRAY_REFERENCE="${SELECTOR_ARRAY_NAME}"
    
    show-header
    show-selector $SELECTOR_ARRAY_NAME $SELECTOR_DESCRIPTION_NAME
    custom-read USER_INPUT
    
    if [[ -n "$USER_INPUT" ]] && [[ "$USER_INPUT" =~ ^[0-9]+$ ]] && (( USER_INPUT >= 1 )) && (( USER_INPUT <= ${#SELECTOR_ARRAY_REFERENCE[@]} ))
    then
        "${SELECTOR_ARRAY_REFERENCE[$((USER_INPUT - 1))]}"
    else
        selector-logic $SELECTOR_ARRAY_NAME $SELECTOR_DESCRIPTION_NAME
    fi
    
}

function show-selector {
    
    if [ -z "$$1" ] || [ -z "$$2" ]
    then
        throw-handy-error 2101 "(show-selector) Array of items isn't set!"
    fi
    
    local -n SELECTOR_ARRAY="$1"
    local -n SELECTOR_DESCRIPTION="$2"
    local i=1
    
    echo -e "\033[1mSelect next step:\033[0m \033[1;2;3;32m(Enter action number)\033[0m"
    
    for ITEM in "${SELECTOR_ARRAY[@]}"
    do
        echo -e "$((i++))) - ${SELECTOR_DESCRIPTION[$ITEM]}"
    done
}

function selector-description-parse {
    # here adds tags shortcut hints etc.
    wip
}