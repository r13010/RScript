#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Finish

echo "RSCRIPT: Removing RScript..."
rm -r home/RScript/
echo "RSCRIPT: Done!"

sleep 2s
clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT:
      YOU CAN EJECT INSTALLATION MEDIA AND REBOOT
--------------------------------------------------------------------------------
"
exit 0

# RSCRIPT Finished