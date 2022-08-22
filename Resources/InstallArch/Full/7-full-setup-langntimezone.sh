#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup language and timezone
langntimezone() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 7-full-setup-langntimezone
--------------------------------------------------------------------------------
"

TIMEZONE="$(curl --fail https://ipapi.co/timezone)"

# Ask for the timezone
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current timezone detected is $TIMEZONE. Is this correct?
--------------------------------------------------------------------------------
"
options=("Yes, it's the corrent timezone" "Choose another timezone")
select opt in "${options[@]}"
do
    case $opt in
        "Yes, it's the corrent timezone")
            break
            ;;
        "Choose another timezone")
            read -rs -p "My desired timezone is " TIMEZONE
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current timezone selected is $TIMEZONE. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        *) echo "Invalid option";;
    esac
done

# NEEDS REFACTORING
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone $TIMEZONE
timedatectl --no-ask-password set-ntp true
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
localectl --no-ask-password set-keymap us
hwclock --systohc

}

### Define script logic
langntimezone