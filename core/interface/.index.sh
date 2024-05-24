#!/bin/bash

##
#
# CORE INTERFACE Index File
#
#######

function CORE-INTERFACE-INDEX {

    local LOCAL_PWD="${GLOBAL_PWD}/core/interface"

    source $LOCAL_PWD/interface.sh
    source $LOCAL_PWD/selector.sh

}

CORE-INTERFACE-INDEX
