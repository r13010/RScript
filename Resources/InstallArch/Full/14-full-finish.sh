#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Finish

echo "RSCRIPT: Removing RScript..."
rm -r home/RScript/

sleep 2s
clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
      If you installed a video driver:
        AFTER THE INSTALLATION THE VIDEO DRIVER MAY NEED
        SOME CHECKING TO ENSURE FUNCTIONALITY, BE CAREFUL!

      If you haven't:
        INSTALL THE VIDEO DRIVER NOW AND THEN RUN:

        arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        arch-chroot /mnt mkinitcpio -P

      AFTER THAT YOU CAN EJECT INSTALLATION MEDIA AND REBOOT
--------------------------------------------------------------------------------
"

# RSCRIPT Finished