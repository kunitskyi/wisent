#!/bin/bash

# TODO: add GLOBAL helper to handle params if they empty or not correct type.

function docker_set_network { # set_network_docker_logic
    local NETWORK_NAME="$1"
    
    docker network create -d bridge $NETWORK_NAME
}

function docker-show-running-containers { # ps_docker_logic
    docker ps
}

function docker-prune { # prune_docker_logic
    docker system prune -a
}

function docker-enter-terminal {
    
    local CONTAINER_NAME="$1"
    
    docker exec -it $CONTAINER_NAME bash || docker exec -t $CONTAINER_NAME sh
}

function docker-exec-t { # cmd_docker_logic
    local CONTAINER_NAME="$1"
    local COMMAND="$2"
    
    docker exec -t $CONTAINER_NAME $COMMAND
}

function docker-compose-send-command {
    local ENV_FILE_PATH="$1"
    local FILE_PATH="$2"
    local COMMAND="$3"
    
    docker compose --env-file $ENV_FILE_PATH -f $FILE_PATH $COMMAND
}