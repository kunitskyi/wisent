#!/bin/bash

##
#
# Base Interface Logic Functions
#
#######

function show-header { #TODO: replace text with vars& change text
    clear
    center-text " WISENT-AG V0.5.1e from 9/1/2023 " ".\`" "3;36"
    echo -e "WORKING MODULE: \033[1;32m| ${GLOBAL_CURRENT_MODULE} |\033[0m"
}

function wip {
    echo -e "\033[1;33mFunction in development...\033[0m"
    confirm-next-actions
    main_menu
}

function confirm-next-actions { #mb, change to confirm-next-step
    echo -en "To continue press \033[1;34mENTER\033[0m\033[3m (Or type - \033[1mstop\033[0m\033[3m, to return in Main Menu) \033[0m"
    read -r USER_INPUT
    
    if [ "$USER_INPUT" = "stop" ]
    then
        main_menu
    elif [ "$USER_INPUT" != "" ]
    then
        confirm-next-actions
    fi
}
#!!!SEALED
# function go-to { # @- meant stepper instead od action
#     if [ "$1" = "@skip" ]
#     then
#         echo -e "\033[3;34mConfirmation Skipping...\033[0m"
#     elif [ "$1" = "@next" ]
#     then
#         confirm_next_actions
#     elif [ "$1" = "@project" ]
#     then
#         confirm_next_actions
#         project_action_selector
#     elif [ "$1" = "@container" ]
#     then
#         confirm_next_actions
#         container_selector
#     elif [ "$1" = "@container_action" ]
#     then
#         confirm_next_actions
#         container_action_selector "" $2
#     elif [ "$1" = "@docker" ]
#     then
#         confirm_next_actions
#         docker_actions_selector
#     elif [ "$1" = "@main" ]
#     then
#         confirm_next_actions
#         main_action_selector
#     else
#         confirm_next_actions
#         main_action_selector
#     fi
# }

function custom-read { #TODO: replace vars
    echo -e "\033[3m(For \033[1mexit\033[0m\033[3m, just type so...)\033[0m"
    echo -en "\033[1m[\033[0m\033[1;32m$GLOBAL_CURRENT_ENVIRONMENT\033[0m\033[1m]\033[0m "
    read -r "$1"
    
    if [ "${!1}" = "exit" ] || [ "${!1}" = "q" ]
    then
        echo -e "\033[1;36mScript made by Kunitskyi Vladyslav\033[0m"
        echo -e "\033[1;36mExiting...\033[0m"
        exit 1
        #!!!SEALED
        #//  Shortcut access only if module and env var set correct
        # elif [ "${!1}" = "menu" ] || [ "${!1}" = "main" ] || [ "${!1}" = "m" ]
        # then
        #     main_menu
        # elif [ "${!1}" = "project_control" ] || [ "${!1}" = "pc" ]
        # then
        #     project_action_selector
        # elif [ "${!1}" = "docker" ] || [ "${!1}" = "d" ]
        # then
        #     docker_actions_selector
        # elif [ "${!1}" = "container" ] || [ "${!1}" = "c" ]
        # then
        #     container_selector
        # elif [ "${!1}" = "backups" ] || [ "${!1}" = "bu" ]
        # then
        #     backups_action_selector
        # elif [ "${!1}" = "git" ]
        # then
        #     git_action_selector
    fi
}
