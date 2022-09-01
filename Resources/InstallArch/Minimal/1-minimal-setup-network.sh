#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh
sleep 0.5s

# Setup network
network() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 1-minimal-setup-network
--------------------------------------------------------------------------------
"

timedatectl set-ntp true
timedatectl status
pacman -S --noconfirm archlinux-keyring
pacman -Sy

pacman -S --noconfirm --needed networkmanager dhclient
systemctl enable --now NetworkManager
pacman -S --noconfirm --needed pacman-contrib terminus-font # Will set this again later for when in chroot (not really needed but why not)
setfont ter-v22b

}

### Define script logic
network