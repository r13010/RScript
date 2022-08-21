#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup microcode
microcode() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 6-full-setup-microcode
--------------------------------------------------------------------------------
"

proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    echo "RSCRIPT: Installing Intel microcode..."
    pacman -S --noconfirm --needed intel-ucode
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    echo "RSCRIPT: Installing AMD microcode..."
    pacman -S --noconfirm --needed amd-ucode
fi

}

### Define script logic
microcode