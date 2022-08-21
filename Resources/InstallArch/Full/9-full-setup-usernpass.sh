#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh

# Setup the root user and a new user
rootpass() {
read -rs -p "My desired root password is " ROOTPASSWORD1
read -rs -p "Retype it for confirmation " ROOTPASSWORD2
}

userpass() {
read -rs -p "My desired user password is " USERPASSWORD1
read -rs -p "Retype it for confirmation " USERPASSWORD2
}

usernpass() {

echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT - 9-full-setup-usernpass
--------------------------------------------------------------------------------
"

# Ask for the root password
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: You need to set a root password
--------------------------------------------------------------------------------
"
rootpass
while [[ $ROOTPASSWORD1 != $ROOTPASSWORD2 ]] do
    echo "RSCRIPT: Passwords don't match."
    rootpass
    done

passwd $ROOTPASSWORD1
USERNAME="r"

# Ask for a username
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: You need to create a new user
--------------------------------------------------------------------------------
"
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current username selected is $USERNAME. Is this correct?
--------------------------------------------------------------------------------
"
options=("Yes, it's the corrent username" "Choose another username")
select opt in "${options[@]}"
do
    case $opt in
        "Yes, it's the corrent username")
            break
            ;;
        "Choose another username")
            read -rs -p "My desired username is " USERNAME
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: The current timezone selected is $USERNAME. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        *) echo "Invalid option";;
    esac
done

useradd -m -G wheel,libvirt -s /bin/bash $USERNAME
echo "RSCRIPT: $USERNAME created, home directory created, added to wheel and libvirt group, default shell set to /bin/bash."

# Ask for the user password
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: You need to set a user password
--------------------------------------------------------------------------------
"
userpass
while [[ $USERPASSWORD1 != $USERPASSWORD2 ]] then
    echo "RSCRIPT: Passwords don't match."
    userpass
    fi

passwd $USERNAME $USERPASSWORD1

# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo "RSCRIPT: Sudo rights added..."

}

### Define script logic
usernpass