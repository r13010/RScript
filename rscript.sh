#!/bin/bash

# Splash 
bash Resources/Others/rsplash.sh
sleep 1s
clear

# Menus
## Menu Main
menu_main() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Main Menu
--------------------------------------------------------------------------------
"
echo -ne "  You are in the Main Menu, select an option:

"
options=("Install Arch" "Install Tweaks" "Other info" "Quit RSCRIPT")
select opt in "${options[@]}"
do
    case $opt in
        "Install Arch")
            menu_inst_arch
            break
            ;;
        "Install Tweaks")
            menu_inst_tweaks
            break
            ;;
        "Other info")
            menu_otherinfo
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

## Menu Install Arch
menu_inst_arch() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Main Menu > Install Arch
--------------------------------------------------------------------------------
"
echo -ne "  Choose the installation type you want to perform:

"
options=("Minimal" "Full" "Go back to Main Menu")
select opt in "${options[@]}"
do
    case $opt in
        "Minimal")
            # Redirect to Minimal Install Script
            bash Resources/InstallArch/Minimal/0-controller-minimal.sh
            break
            ;;
        "Full")
            # Redirect to Full Install Script
            bash Resources/InstallArch/Full/0-controller-full.sh
            break
            ;;
        "Go back to Main Menu")
            menu_main
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}

## Menu Install Tweaks
menu_inst_tweaks() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Main Menu > Install Tweaks
--------------------------------------------------------------------------------
"
echo -ne "  Choose the tweak you want to perform:

"
options=("Go back to Main Menu, no tweaks here")
select opt in "${options[@]}"
do
    case $opt in
        "Go back to Main Menu, no tweaks here")
            menu_main
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}

## Menu Other info
menu_otherinfo() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Main Menu > Other info
--------------------------------------------------------------------------------
"
echo -ne "  RSCRIPT version alpha 0.20220820a1
  Check the Github page here: https://github.com/r13010/RScript

"
options=("Go back to Main Menu")
select opt in "${options[@]}"
do
    case $opt in
        "Go back to Main Menu")
            menu_main
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}

### Define script logic
menu_main
