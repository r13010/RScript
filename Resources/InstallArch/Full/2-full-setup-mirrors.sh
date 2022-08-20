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

pacman -S --noconfirm --needed reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "RSCRIPT: Starting reflector.service"
systemctl start reflector.service
journalctl -u reflector.service

}

### Define script logic
mirrors