#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh


# Setup network
network() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 1-full-setup-network
--------------------------------------------------------------------------------
"

timedatectl set-ntp true
timedatectl status
pacman -S --noconfirm archlinux-keyring
pacman -Sy

pacman -S --noconfirm --needed networkmanager dhclient
systemctl enable --now NetworkManager
pacman -S --noconfirm --needed pacman-contrib terminus-font
setfont ter-v22b

}

### Define script logic
network