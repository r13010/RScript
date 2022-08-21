#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup other firmware
firmware2() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 5-full-setup-chrootsftw
--------------------------------------------------------------------------------
"

pacman -S --noconfirm --needed base-devel fdisk
pacman -S --noconfirm --needed efibootmgr
pacman -S --noconfirm --needed dosfstools
pacman -S --noconfirm --needed openssh
pacman -S --noconfirm --needed os-prober
pacman -S --noconfirm --needed mtools
pacman -S --noconfirm --needed linux-headers
pacman -S --noconfirm --needed networkmanager
pacman -S --noconfirm --needed dhclient
pacman -S --noconfirm --needed nano
pacman -S --noconfirm --needed git
pacman -S --noconfirm --needed systemd
pacman -S --noconfirm --needed sudo
pacman -S --noconfirm --needed grub
pacman -S --noconfirm --needed parted
pacman -S --noconfirm --needed util-linux
pacman -S --noconfirm --needed less
pacman -S --noconfirm --needed fish

systemctl enable --now NetworkManager
systemctl enable NetworkManager.service

}

### Define script logic
firmware2