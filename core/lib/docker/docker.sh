#!/bin/bash

# TODO: add GLOBAL helper to handle params if they empty or not correct type.

function ws:docker:set-network { # set_network_docker_logic
    local NETWORK_NAME="$1"

    docker network create -d bridge $NETWORK_NAME
}

function ws:docker:ps { # ps_docker_logic
    docker ps
}

function ws:docker:prune { # prune_docker_logic
    docker system prune -a
}

function ws:docker:use-terminal {

    local CONTAINER_NAME="$1"

    docker exec -it $CONTAINER_NAME bash || docker exec -t $CONTAINER_NAME sh
}

function ws:docker:send-cmd {
    local CONTAINER_NAME="$1"
    local COMMAND="$2"

    docker exec -t $CONTAINER_NAME $COMMAND
}

function ws:docker:compose:send-cmd {
    local ENV_FILE_PATH="$1"
    local FILE_PATH="$2"
    local SERVICE_NAME="$3"
    local COMMAND="$4"

    docker compose --env-file $ENV_FILE_PATH -f $FILE_PATH exec -t $SERVICE_NAME $COMMAND
}

function ws:docker:compose-control {
    local ENV_FILE_PATH="$1"
    local FILE_PATH="$2"
    local COMMAND="$3"

    docker compose --env-file $ENV_FILE_PATH -f $FILE_PATH $COMMAND
}
