#!/bin/bash
clear
# greeter
echo "$(tput setaf 1)] rscript: level 1: autoinstall$(tput setaf 7)"

# menu
select yn in "desktopForVBox 1" "desktopForVBox 2" "desktopForVBox 3" "minimalForVBox" "Return to level 0" "Exit RSCRIPT"; do
    case $yn in
        "desktopForVBox 1" ) bash rscript/level2_install_auto/desktopForVBox_1.sh; break;;
        "desktopForVBox 2" ) bash rscript/level2_install_auto/desktopForVBox_2.sh; break;;
        "desktopForVBox 3" ) bash rscript/level2_install_auto/desktopForVBox_3.sh; break;;
        "minimalForVBox" ) bash rscript/level2_install_auto/minimalForVBox.sh; break;;
        "Return to level 0" ) bash rscript_mgr.sh; break;;
        "Exit RSCRIPT" ) echo "$(tput setaf 1)] RSCRIPT: Exiting...$(tput setaf 7)"; exit; break;;
    esac
done

