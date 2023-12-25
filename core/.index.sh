#!/bin/bash

##
#
# CORE Index File
#
#######

function CORE-INDEX {
    
    local LOCAL_PWD="${GLOBAL_PWD}/core"
    
    source $LOCAL_PWD/general/.index.sh
    
    source $LOCAL_PWD/initialization.sh
    source $LOCAL_PWD/interface.sh
    
}

CORE-INDEX