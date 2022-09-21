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
options=("Install Arch" "Install Tweaks" "Install KVM Setup" "Other info" "Quit RSCRIPT")
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
        "Install KVM Setup")
            menu_inst_kvm
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
options=("Go back to Main Menu" "Minimal" "Full")
select opt in "${options[@]}"
do
    case $opt in
        "Go back to Main Menu")
            menu_main
            break
            ;;
        "Minimal (root)")
            # Redirect to Minimal Install Script
            bash Resources/InstallArch/Minimal/0-controller-minimal.sh
            break
            ;;
        "Full (root)")
            # Redirect to Full Install Script
            bash Resources/InstallArch/Full/0-controller-full.sh
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
options=("Go back to Main Menu" "Short Shutdown" "No Grub Start Screen")
select opt in "${options[@]}"
do
    case $opt in
        "Go back to Main Menu")
            menu_main
            break
            ;;
        "All the tweaks (root)")
            bash Resources/InstallTweaks/Tweak_ShortShutdown/Tweak_ShortShutdown.sh
            bash Resources/InstallTweaks/Tweak_ShortShutdown/Tweak_ShortShutdown.sh
            break
            ;;
        "Short Shutdown (root)")
            bash Resources/InstallTweaks/Tweak_ShortShutdown/Tweak_ShortShutdown.sh
            break
            ;;
        "No Grub Start Screen (root)")
            bash Resources/InstallTweaks/Tweak_NoGrubStartScreen/Tweak_NoGrubStartScreen.sh
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
echo -ne "  RSCRIPT version beta 0.20220922a1
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

## Menu Install KVM
menu_otherinfo() {

clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - Main Menu > Install KVM Setup
--------------------------------------------------------------------------------
"
echo -ne "  Choose the installation type you want to perform:

"
options=("Go back to Main Menu" "KVMGPU #1 Enable virtualization (root)" "KVMGPU #2 Hijack (root)" "KVMGPU #3 Software (root)" "Looking Glass" "Scream Audio")
select opt in "${options[@]}"
do
    case $opt in
        "Go back to Main Menu")
            menu_main
            break
            ;;
        "KVMGPU #1 Enable virtualization (root)")
            # Redirect to KVM GPU Passthrough Script 1
            bash Resources/InstallKVM/KVMGPU/0-kvmgpu-enablevirt.sh
            break
            ;;
        "KVMGPU #2 Hijack (root)")
            # Redirect to KVM GPU Passthrough Script 1
            bash Resources/InstallKVM/KVMGPU/1-kvmgpu-hijack.sh
            break
            ;;
        "KVMGPU #3 Software (root)")
            # Redirect to KVM GPU Passthrough Script 1
            bash Resources/InstallKVM/KVMGPU/2-kvmgpu-software.sh
            break
            ;;
        "Looking Glass")
            # Redirect to Looking Glass Script
            bash Resources/InstallArch/
            break
            ;;
        "Scream Audio")
            # Redirect to Scream Audio Script
            bash Resources/InstallArch/
            break
            ;;
        *) echo "Invalid option";;
    esac
done
}
### Define script logic
menu_main
