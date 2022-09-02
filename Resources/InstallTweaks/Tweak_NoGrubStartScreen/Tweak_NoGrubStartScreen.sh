#!/bin/bash

# Splash 
bash Resources/Others/rsplash.sh
sleep 0.5s
clear

# Tweak_NoGrubStartScreen
tweak2() {

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