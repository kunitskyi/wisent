#!/bin/bash

##
#
# Data Init
#
#######

# --- List of GLOBAL variables --- #
GLOBAL_PWD=$(pwd)
GLOBAL_NEED_RESTART=0 #NEED TO RESTART AFTER ANY FAIL ARGUMENT INIT (OR ALL ARGUMENT INIT AND BEFORE ANOTHER ARGUMENT CHANGE)
GLOBAL_MODULES=()
GLOBAL_ENVIRONMENTS=()
GLOBAL_CURRENT_MODULE="NONE" # NONE - reserved word for unset arguments
GLOBAL_CURRENT_ENVIRONMENT="NONE" # NONE - reserved word for unset arguments

# --- Base Libraries Init --- #
source ./core/.index.sh

# --- GET SCRIPT ARGUMENTS --- #
while getopts ":m:e:" flag
do
    case "${flag}" in
        m) ARG_MODULE=${OPTARG};; # module
        e) ARG_ENVIRONMENT=${OPTARG};; # environment
    esac
done

##
#
# Run Panel
#
#######

ws:initialization $ARG_MODULE $ARG_ENVIRONMENT