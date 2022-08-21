#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup KDE
kdesoftware() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 11-full-setup-kde
--------------------------------------------------------------------------------
"

echo "RSCRIPT: Installing Plasma and Xorg..."
pacman -S --noconfirm --needed xorg plasma sddm
systemctl enable sddm.service

echo "RSCRIPT: Installing Plasma system software..."
# base level software
pacman -S --noconfirm --needed konsole dolphin dolphin-plugins
# all the kde good and useful for me software
pacman -S --noconfirm --needed man kdeconnect krunner spectacle ksystemlog kalarm kalendar kalendar kamoso kcalc kcharselect kcolorchooser kcron kdenlive kfind kolourpaint krdc kmines kmousetool knotes kontrast
# various plugins
pacman -S --noconfirm --needed bluedevil packagekit-qt5 akonadi-calendar-tools akonadi-import-wizard audiocd-kio ffmpegthumbs kdegraphics-thumbnailers kdenetwork-filesharing print-manager

echo "RSCRIPT: Installing Media related software..."
pacman -S --noconfirm --needed kate vlc ark filelight gwenview k3b gparted okular svgpart


}

### Define script logic
kdesoftware