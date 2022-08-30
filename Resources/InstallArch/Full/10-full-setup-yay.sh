#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup yay aur helper
yay() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 10-full-setup-yay
--------------------------------------------------------------------------------
"

echo "RSCRIPT: Installing Yay Aur Helper..."
cd /home/RScript/yay
makepkg -si

echo sex
sleep 20s
}

### Define script logic
yay