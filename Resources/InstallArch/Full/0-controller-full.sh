#!/bin/bash

# Splash
bash Resources/Others/rsplash.sh
sleep 1s
clear

# Controller Full
controller_full() {

bash Resources/InstallArch/Full/1-full-checks.sh

}

# Menus
## Menu Install Arch Full
menu_installarch_full() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Install Arch: Full
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
            # Redirect to Full Installation Script
            controller_full
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
menu_installarch_full