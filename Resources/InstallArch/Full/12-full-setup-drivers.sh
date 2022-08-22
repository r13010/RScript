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

echo "RSCRIPT: SOUND: Installing pulseaudio..."
pacman -S --noconfirm --needed pulseaudio pulseaudio-jack pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-lirc alsa-utils
# systemctl disable --global pipewire # disable this shit

echo "RSCRIPT: INTERNET: Making sure networkmanager is installed..."
pacman -S --noconfirm --needed networkmanager
systemctl enable --now NetworkManager
systemctl enable NetworkManager.service

echo "RSCRIPT: FIREWALL: Installing firewalld..."
pacman -S --noconfirm --needed firewalld
systemctl enable firewalld.service

echo "RSCRIPT: BLUETOOTH: Installing bluetooth utilites..."
pacman -S --noconfirm --needed bluez bluez-utils bluedevil
systemctl enable bluetooth.service

echo "RSCRIPT: RAZER: Installing openrazer and polychromatic..."
yay -S --noconfirm --needed openrazer-meta polychromatic

echo "RSCRIPT: VIDEO: Waiting for response..."

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: What video driver do you want to install?
        AFTER THE INSTALLATION THE VIDEO DRIVER MAY NEED
        SOME CHECKING TO ENSURE FUNCTIONALITY, BE CAREFUL!
--------------------------------------------------------------------------------
"

options=("AMD driver (amdgpu)" "Nvidia driver (nvidia)" "VBox (virtualbox-guest-utils)" "I'll figure it out myself")
select opt in "${options[@]}"
do
    case $opt in
        "AMD driver (amdgpu)")
            pacman -S mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver
            break
            ;;
        "Nvidia driver (nvidia)")
            pacman -S nvidia
            nvidia-xconfig
            break
            ;;
        "VBox (virtualbox-guest-utils)")
            pacman -S --noconfirm --needed virtualbox-guest-utils
            systemctl enable vboxservice.service
            break
            ;;
        "I'll figure it out myself")
            break
            ;;
        *) echo "Invalid option";;
    esac
done

echo "RSCRIPT: Regenerating..."
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P

sleep 1s

}

### Define script logic
drivers