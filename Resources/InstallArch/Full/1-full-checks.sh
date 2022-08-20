#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup checks
root_check() {
    if [[ "$(id -u)" != "0" ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! This script must be run under the 'root' user!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

docker_check() {
    if awk -F/ '$2 == "docker"' /proc/self/cgroup | read -r; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! Docker container is not supported!
--------------------------------------------------------------------------------
"
        exit 0
    elif [[ -f /.dockerenv ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! Docker container is not supported!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

arch_check() {
    if [[ ! -e /etc/arch-release ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! This script must be run in Arch Linux!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

pacman_check() {
    if [[ -f /var/lib/pacman/db.lck ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! Pacman is blocked!
              If not running remove /var/lib/pacman/db.lck.
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

background_checks() {
    root_check
    arch_check
    pacman_check
    docker_check
}

### Define script logic
background_checks