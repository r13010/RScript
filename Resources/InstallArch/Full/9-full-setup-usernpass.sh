#!/bin/bash

# Splash
bash home/RScript/Resources/Others/rsplash.sh
sleep 0.5s

# Setup the root user and a new user
rootpass() {
read -rs -p "My desired root password is " ROOTPASSWORD1
echo
read -rs -p "Retype it for confirmation " ROOTPASSWORD2
echo
}

userpass() {
read -rs -p "My desired user password is " USERPASSWORD1
echo
read -rs -p "Retype it for confirmation " USERPASSWORD2
echo
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
passwd

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
    RSCRIPT: The current username selected is $USERNAME. Is this correct?
--------------------------------------------------------------------------------
"
            ;;
        *) echo "Invalid option";;
    esac
done

groupadd wheel
groupadd libvirt
groupadd plugdev
useradd -m -G wheel,libvirt,plugdev -s /bin/fish $USERNAME
echo "RSCRIPT: $USERNAME created, home directory created, added to wheel, libvirt group, default shell set to /bin/fish."

# Ask for the user password
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: You need to set a user password
--------------------------------------------------------------------------------
"
passwd $USERNAME

# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo "RSCRIPT: Sudo rights added..."

# Install yay
echo "RSCRIPT: Installing Yay Aur helper..."
echo -ne "
--------------------------------------------------------------------------------
    RSCRIPT: Enter password for $USERNAME to install Yay Aur helper
--------------------------------------------------------------------------------
"
cd home/RScript/
git clone https://aur.archlinux.org/yay.git
chown $USERNAME yay/
cd /
sudo -u $USERNAME bash home/RScript/Resources/InstallArch/Full/10-full-setup-yay.sh

}

### Define script logic
usernpass