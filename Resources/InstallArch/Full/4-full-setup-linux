#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

# Setup firmware
firmware() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 4-full-setup-linux
--------------------------------------------------------------------------------
"

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

}

### Define script logic
firmware