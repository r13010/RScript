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

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

# Unpack Linux
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

}

### Define script logic
firmware