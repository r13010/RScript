#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup other firmware
basesoftware() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 5-full-setup-basesoftware
--------------------------------------------------------------------------------
"

echo "RSCRIPT: Installing base software..."
pacman -S --noconfirm --needed base-devel efibootmgr dosfstools openssh os-prober mtools linux-headers networkmanager dhclient systemd sudo grub parted util-linux nano git fish less

systemctl enable --now NetworkManager
systemctl enable NetworkManager.service

}

### Define script logic
basesoftware