#!/bin/bash
clear
# greeter
echo "$(tput setaf 1)] rscript: level 1: autoinstall$(tput setaf 7)"

# menu
select yn in "desktopForVBox" "minimalForVBox" "Return to level 0" "Exit RSCRIPT"; do
    case $yn in
        "desktopForVBox" ) bash rscript/level2_install_auto/desktopForVBox.sh; break;;
        "minimalForVBox" ) bash rscript/level2_install_auto/minimalForVBox.sh; break;;
        "Return to level 0" ) bash rscript_mgr.sh; break;;
        "Exit RSCRIPT" ) echo "$(tput setaf 1)] RSCRIPT: Exiting...$(tput setaf 7)"; exit; break;;
    esac
done

