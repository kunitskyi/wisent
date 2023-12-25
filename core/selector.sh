#!/bin/bash

##
#
# Selector
#
#######

function show-selector {
    
    if [ -z "$$1" ] || [ -z "$$2" ]
    then
        throw-handy-error 2101 "(show-selector) Array of items isn't set!"
    fi
    
    local -n SELECTOR_ARRAY="$1"
    local -n SELECTOR_DESCRIPTION="$2"
    local i=1
    
    echo -e "\033[1mSelect next action:\033[0m \033[1;2;3;32m(Enter action number)\033[0m"
    
    for ITEM in "${SELECTOR_ARRAY[@]}"
    do
        echo $ITEM
        echo -e "$((i++))) - ${SELECTOR_DESCRIPTION[$ITEM]}"
    done
}