#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup mirrors
mirrors() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 2-full-setup-mirrors
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed reflector curl
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

iso=$(curl -4 ifconfig.co/country-iso)
echo "RSCRIPT: Country detected: $iso"
echo "RSCRIPT: Starting reflector..."
reflector --country $iso -f 5 --latest 200 --sort rate --save /etc/pacman.d/mirrorlist

}

### Define script logic
mirrors