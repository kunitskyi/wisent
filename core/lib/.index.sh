#!/bin/bash

##
#
# CORE LIB Index File
#
#######

function CORE-LIB-INDEX {

    local LOCAL_PWD="${GLOBAL_PWD}/core/lib"

    source $LOCAL_PWD/docker/.index.sh

}

CORE-LIB-INDEX
