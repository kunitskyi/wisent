#!/bin/bash

##
#
# CORE GENERAL Index File
#
#######

function CORE-GENERAL-INDEX {
    
    local LOCAL_PWD="${GLOBAL_PWD}/core/lib/docker"
    
    source $LOCAL_PWD/_argument.sh # "_" - in start of file name, mean that this general file contain some GLOBAL_VARIABLE
    source $LOCAL_PWD/bundle.sh
    source $LOCAL_PWD/helper.sh
    source $LOCAL_PWD/docker.sh
    
}

CORE-GENERAL-INDEX