#!/bin/bash

##
#
# Base Interface Logic Functions
#
#######

function @wip {
    echo -e "\033[1;33mFunction in development...\033[0m"
    @stop
    ws:module-entrypoint
}

function @show-header { #TODO: replace text with vars& change text
    clear
    @center-text " WISENT V0.7-12/26/2023 " ".\`" "3;36"
    echo -e "\033[2mWORKING MODULE:\033[0m \033[1;32m| ${GLOBAL_CURRENT_MODULE} |\033[0m"
}

function @stop {
    echo -en "To continue press \033[1;34mENTER\033[0m\033[3m (Or type - \033[1mstop\033[0m\033[3m, to return in Main Menu) \033[0m"
    read -r USER_INPUT

    if [ "$USER_INPUT" = "stop" ]; then
        ws:module-entrypoint
    elif [ "$USER_INPUT" != "" ]; then
        @stop
    fi
}

function @custom-read { #TODO: replace vars

    local -n INPUT_VAR_REFERENCE="$1"

    echo -e "\033[3m(For \033[1mexit\033[2m(q)\033[0m\033[3m, just type so...)\033[0m"
    echo -en "\033[1m[\033[0m\033[1;32m$GLOBAL_CURRENT_ENVIRONMENT\033[0m\033[1m]\033[0m "
    read -r INPUT_VAR_REFERENCE

    if [ "${INPUT_VAR_REFERENCE}" = "exit" ] || [ "${INPUT_VAR_REFERENCE}" = "q" ]; then
        echo -e "\033[1;36mScript made by Kunitskyi Vladyslav\033[0m"
        echo -e "\033[1;36mExiting...\033[0m"
        exit 1
    elif @check-value-in-array "${GLOBAL_CURRENT_ENVIRONMENT}" "${GLOBAL_ENVIRONMENTS[@]}"; then
        if @check-value-in-array "${INPUT_VAR_REFERENCE}" "${!GLOBAL_SHORTCUTS[@]}"; then
            eval "${GLOBAL_SHORTCUTS[$INPUT_VAR_REFERENCE]}"
        fi
    fi
}
