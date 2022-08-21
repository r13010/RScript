#!/bin/bash

# Splash
#bash Resources/Others/rsplash.sh
arch-chroot /mnt bash /home/RScript/Resources/Others/rsplash.sh

# Setup other firmware
firmware2() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 5-full-setup-chrootsftw
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed base-devel efibootmgr dosfstools openssh os-prober mtools linux-headers networkmanager dhclient nano git systemd yay sudo grub
systemctl enable --now NetworkManager
systemctl enable NetworkManager.service

}

### Define script logic
firmware2