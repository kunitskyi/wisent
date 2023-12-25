#!/bin/bash

##
#
# Initialization Logic
#
#######

function panel-initialization {
    
    # TODO: check if all SCRIPT COMMANDS works -> throw-handy-error
    # TODO: check if BASE BUNDLE is installed -> try to install base_bundle.sh
    
    local LOCAL_MODULE=${1:-"!"}
    local LOCAL_ENVIRONMENT=${2:-"!"}
    
    change-module $LOCAL_MODULE $LOCAL_ENVIRONMENT
    
}

function change-module {
    
    # TODO: check if none modules installed -> install angavel.wisent -- show warnings
    # TODO: modules must be pattern *.wisent
    # TODO: check basic structure/integrity of modules & environment
    
    local LOCAL_MODULE=${1:-"!"}
    local LOCAL_ENVIRONMENT=${2:-"!"}
    
    folder-argument-logic GLOBAL_CURRENT_MODULE $LOCAL_MODULE GLOBAL_MODULES "MODULE" "./module" "^[a-z][a-z0-9_.-]*$"
    
    if [ "$GLOBAL_CURRENT_MODULE" != "$LOCAL_MODULE" ]
    then
        LOCAL_ENVIRONMENT="!"
    fi
    
    change-environment $LOCAL_ENVIRONMENT
}

function change-environment {
    
    local LOCAL_ENVIRONMENT=${1:-"!"}
    
    folder-argument-logic GLOBAL_CURRENT_ENVIRONMENT $LOCAL_ENVIRONMENT GLOBAL_ENVIRONMENTS  "ENVIRONMENT" "./module/${GLOBAL_CURRENT_MODULE}/env" "^[a-z][a-z0-9_.-]*$"
    
    module-reload
}

function module-reload {
    
    if [ "$GLOBAL_NEED_RESTART" == 1 ]
    then
        exec /bin/bash "$0" -m "$GLOBAL_CURRENT_MODULE" -e "$GLOBAL_CURRENT_ENVIRONMENT"
    fi
    
    GLOBAL_NEED_RESTART=1
    
    source ./module/$GLOBAL_CURRENT_MODULE/entrypoint.sh
    
}