#!/bin/bash
clear
# greeter
echo "$(tput setaf 1)] RSCRIPT: Welcome, select an option:$(tput setaf 7)"

# menu
select yn in "ManualInstall" "AutoInstall" "Reload" "About" "Version" "Exit RSCRIPT"; do
    case $yn in
        "ManualInstall" ) bash rscript/level1/install_manual.sh; break;;
        "AutoInstall" ) bash rscript/level1/install_auto.sh; break;;
        "Reload" ) bash rscript_mgr.sh; break;;
        "About" ) bash rscript/level1/info_about.sh; break;;
        "Version" ) bash rscript/level1/info_version.sh; break;;
        "Exit RSCRIPT" ) echo "$(tput setaf 1)] RSCRIPT: Exiting...$(tput setaf 7)"; exit; break;;
    esac
done
