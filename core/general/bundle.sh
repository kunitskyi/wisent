#!/bin/bash

##
#
# Base Bundle
#
#######

function install-base-bundle {
    
    install-docker
    
    sudo apt update
    sudo apt install curl git openssl
}

function install-docker {
    
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc
    do
        sudo apt-get remove $pkg
    done
    
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    
    if [ -f /etc/os-release ]
    then
        local DISTRIBUTION=$(grep -oP 'ID=\K\w+' /etc/os-release)
        
        if [ "$DISTRIBUTION" == "kali" ]
        then
            printf '%s\n' "deb https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list
            curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-ce-archive-keyring.gpg
        elif [ "$DISTRIBUTION" == "ubuntu" ]
        then
            sudo install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            sudo chmod a+r /etc/apt/keyrings/docker.gpg
            echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        else
            throw-handy-error 101 "(install-docker) This is another Linux distribution: $DISTRIBUTION"
        fi
    else
        throw-handy-error 102 "(install-docker) Unable to determine the Linux distribution."
    fi
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo groupadd docker && sudo usermod -aG docker $USER
    
}