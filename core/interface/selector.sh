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
    local SELECTOR_DESCRIPTION_NAME="$2"
    local i=1
    
    echo -e "\033[1mSelect next step:\033[0m \033[1;2;3;32m(Enter action number)\033[0m"
    
    for ITEM in "${SELECTOR_ARRAY[@]}"
    do
        selector-description-parse $i $ITEM $SELECTOR_DESCRIPTION_NAME
        ((i++))
    done
}

function selector-description-parse {
    
    local INDEX="$1"
    local ITEM="$2"
    local -n SELECTOR_DESCRIPTION="$3"
    local SELECTOR_TEXT="${SELECTOR_DESCRIPTION[$ITEM]}"

    # Parse Adding Tags
    for TAG_TYPE in "${TAGS_ARRAY[@]}"
    do
        local ARRAY_TAGS_SELECTORS=()

        IFS="," read -r -a ARRAY_TAGS_SELECTORS <<< "${TAGS_TO_SELECTORS[$TAG_TYPE]}"

        for TAG_SELECTOR in "${!ARRAY_TAGS_SELECTORS[@]}"
        do
            if [[ "${ARRAY_TAGS_SELECTORS[$TAG_SELECTOR]}" = "${ITEM}" ]]
            then
                SELECTOR_TEXT="${TAGS_SYNTAX[$TAG_TYPE]}${SELECTOR_TEXT}"
            fi
        done
    done
    
    # Parse Adding Shortcut
    for SHORTCUT in "${!GLOBAL_SHORTCUTS[@]}"
    do
        if [[ "${GLOBAL_SHORTCUTS[$SHORTCUT]}" = "${ITEM}" ]]
        then
            SELECTOR_TEXT="\033[1;32m($SHORTCUT)\033[0m$SELECTOR_TEXT"
            break
        fi
    done
    
    echo -e "${INDEX} - ${SELECTOR_TEXT}\033[0m"
    
}