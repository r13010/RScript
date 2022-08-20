#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup network
network(){

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 1-full-network
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed networkmanager dhclient
systemctl enable --now NetworkManager

}

### Define script logic
network