#!/bin/bash

##
#
# CORE INITIALIZATION Index File
#
#######

function CORE-INITIALIZATION-INDEX {
    
    local LOCAL_PWD="${GLOBAL_PWD}/core/initialization"
    
    source $LOCAL_PWD/argument.sh
    source $LOCAL_PWD/bundle.sh
    source $LOCAL_PWD/initialization.sh
    
}

CORE-INITIALIZATION-INDEX