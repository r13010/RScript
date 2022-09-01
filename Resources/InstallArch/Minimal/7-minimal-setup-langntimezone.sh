#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup language and timezone
langntimezone() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 7-minimal-setup-langntimezone
--------------------------------------------------------------------------------
"

TIMEZONE="$(curl --fail https://ipapi.co/timezone)"

# Ask for the timezone
sleep 0.5s
clear
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
sleep 0.5s
clear
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current timezone selected is $TIMEZONE. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        *) echo "Invalid option";;
    esac
done

# Timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime # set the specified timezone
hwclock --systohc

# Keyboard layout (always set it to en_US.UTF-8, user can change it later)
locale-gen
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

# Language (always set to en_US.UTF-8, user can change it later)
echo "LANG=en_US.UTF-8" > /etc/locale.conf

}

### Define script logic
langntimezone