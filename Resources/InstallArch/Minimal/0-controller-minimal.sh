#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh
sleep 1s
clear

# Menus
## Menu Install Arch Minimal
menu_installarch_minimal() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install Arch: Minimal
--------------------------------------------------------------------------------
"
echo -ne "  BE CAREFUL!
  You are about to go to the installation process.
  We recommend disconnecting the unused drives to prevent
  accidental data loss.
  You will be asked questions throughout the installation.

"
options=("Continue" "Quit RSCRIPT")
select opt in "${options[@]}"
do
    case $opt in
        "Continue")
            # Redirect to Minimal Installation Script
            echo "not done yet"
            break
            ;;
        "Quit RSCRIPT")
            bash Resources/Others/rsplash.sh
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Quitting...
--------------------------------------------------------------------------------
"
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}

### Define script logic
menu_installarch_minimal