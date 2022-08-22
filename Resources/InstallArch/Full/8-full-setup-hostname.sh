#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup hostname
hostname() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 8-full-setup-hostname
--------------------------------------------------------------------------------
"

HOSTNAME="RsPC"

# Ask for the hostname
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current hostname selected is $HOSTNAME. Is this correct?
--------------------------------------------------------------------------------
"
options=("Yes, it's the correct hostname" "Choose another hostname (name for machine)")
select opt in "${options[@]}"
do
    case $opt in
        "Yes, it's the correct hostname")
            break
            ;;
        "Choose another hostname (name for machine)")
            read -rs -p "My desired hostname is " HOSTNAME
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current hostname selected is $HOSTNAME. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        *) echo "Invalid option";;
    esac
done

echo $HOSTNAME > /etc/hostname

}

### Define script logic
hostname