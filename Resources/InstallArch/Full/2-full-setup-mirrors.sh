#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup mirrors
mirrors(){

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 2-full-setup-mirrors
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed pacman-contrib curl
pacman -S --noconfirm --needed reflector rsync grub arch-install-scripts git
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

}

### Define script logic
mirrors