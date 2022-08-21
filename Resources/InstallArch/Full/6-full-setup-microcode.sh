#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh

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