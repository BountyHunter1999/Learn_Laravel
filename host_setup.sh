#!/bin/bash

# 1 to clean the host
creation="${1:-0}"

red='\033[31;1m'
green='\033[32;1m'
yellow='\e[33m'
blue='\e[34m'
reset='\033[0m'

function host_setup() {
    hostname=$1
    if ! [ -n "$(grep "[[:space:]]$hostname" /etc/hosts)" ]; then
        echo -e "${yellow}Adding $hostname${reset}"
        sh -c "echo '127.0.0.1 $hostname' >> /etc/hosts"
    else 
        echo -e "${green}$hostname exists in hostfile${reset}"
    fi
}

function host_cleanup() {
    hostname=$1
    if [ -n "$(grep "[[:space:]]$hostname" /etc/hosts)" ]; then
        echo -e "${red}Removing $hostname${reset}"
        sh -c "sed -i '/127.0.0.1 $hostname/d' /etc/hosts"
    else 
        echo -e "${green}$hostname doesn't exist in hostfile${reset}"
    fi
}
printf "\n------------------------------------------------------------------------------------"
if ! [ "$creation" == "1" ]; then
    echo -e "${blue}\Primo Local Host Setup............${reset}"
    if ! [ -n "$(grep "# For primo" /etc/hosts)" ]; then
        sh -c "echo '\n# For primo' >>  /etc/hosts"
        # Common Services
        host_setup 'db'
        host_setup 'redis'
        host_setup 'meilisearch.test'
        host_setup 'mailpit.test'
        host_setup 'minio.test'
        host_setup 'primo.test'
        echo -e "${blue}Done!!!${reset}"
    else 
        echo -e "${green}Setup Already Ran${reset}"
    fi
    
else
    echo -e "${red}\Primo Local Host Cleanup${reset}"
    sh -c "sed -i '/# For primo/d' /etc/hosts"
    # Common Services
    host_cleanup 'db'
    host_cleanup 'redis'
    host_cleanup 'meilisearch.test'
    host_cleanup 'mailpit.test'
    host_cleanup 'minio.test'
    host_cleanup 'primo.test'
fi
echo "------------------------------------------------------------------------------------"