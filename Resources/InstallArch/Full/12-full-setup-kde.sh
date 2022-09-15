#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup KDE
kdesoftware() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 12-full-setup-kde
--------------------------------------------------------------------------------
"

echo "RSCRIPT: Installing Plasma and Xorg..."
pacman -S --noconfirm --needed xorg plasma sddm
systemctl enable sddm.service

echo "RSCRIPT: Installing Plasma system software..."
# base level software
pacman -S --noconfirm --needed konsole dolphin dolphin-plugins
# all the kde software good and useful for me
pacman -S --noconfirm --needed man kdeconnect krunner spectacle ksystemlog kalarm kalendar kalendar kamoso kcalc kcharselect kcolorchooser kcron kdenlive kfind kolourpaint krdc kmines kmousetool knotes kontrast
# various plugins
pacman -S --noconfirm --needed bluedevil packagekit-qt5 akonadi-calendar-tools akonadi-import-wizard audiocd-kio ffmpegthumbs kdegraphics-thumbnailers kdenetwork-filesharing print-manager libappindicator-gtk3

echo "RSCRIPT: Installing Media related software..."
pacman -S --noconfirm --needed kate kwrite vlc ark filelight gwenview k3b gparted okular svgpart

echo "RSCRIPT: Installing Jre..."
pacman -S --noconfirm --needed jre11-openjdk-headless jre11-openjdk

echo "RSCRIPT: Disabling xorg sddm mouse acceleration..."
echo -ne 'Section "InputClass"
	Identifier "My Mouse"
	MatchIsPointer "yes"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "-1"
EndSection
' > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

}

### Define script logic
kdesoftware