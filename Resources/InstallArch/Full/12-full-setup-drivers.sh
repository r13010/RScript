#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup drivers
drivers() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 12-full-setup-drivers
--------------------------------------------------------------------------------
"

echo "RSCRIPT: SOUND: Installing pulseaudio and alsa..."
pacman -S --noconfirm --needed pulseaudio alsa
pacman -R --noconfirm --needed pipewire

echo "RSCRIPT: INTERNET: Making sure network manager is installed..."
pacman -S --noconfirm --needed networkmanager
systemctl enable --now NetworkManager
systemctl enable NetworkManager.service

echo "RSCRIPT: FIREWALL: Installing firewalld..."
pacman -S --noconfirm --needed firewalld
systemctl enable firewalld.service

echo "RSCRIPT: BLUETOOTH: Installing bluetooth utilites..."
pacman -S --noconfirm --needed bluez bluez-utils bluedevil
systemctl enable bluetooth.service

}

### Define script logic
drivers