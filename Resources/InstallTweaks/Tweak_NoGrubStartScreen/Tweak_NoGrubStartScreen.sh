#!/bin/bash

# Splash 
bash Resources/Others/rsplash.sh
sleep 0.5s
clear

# Checks
root_check() {
    if [[ "$(id -u)" != "0" ]]; then
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - ERROR! This script must be run under the 'root' user!
--------------------------------------------------------------------------------
"
        exit 0
    fi
}

# Tweak_NoGrubStartScreen
tweak2() {
root_check

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Tweak_NoGrubStartScreen
    
    Desc:
        Adds Grub hidden timeout
        THIS TWEAK REQUIRES ROOT
--------------------------------------------------------------------------------
"
sleep 1s

# Modify Grub params
cp /etc/default/grub /etc/default/grub_backup
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0\nGRUB_HIDDEN_TIMEOUT_QUIET=true/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "RSCRIPT: Done!"

}

### Define script logic
tweak2