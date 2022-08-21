#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh

# Setup other firmware
firmware2() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 5-full-setup-chrootsftw
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed base-devel efibootmgr dosfstools openssh os-prober mtools linux-headers networkmanager dhclient nano git systemd yay sudo grub parted
systemctl enable --now NetworkManager
systemctl enable NetworkManager.service

}

### Define script logic
firmware2