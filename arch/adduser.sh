#!/bin/bash

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi

# Ask for the desired username
read -p "Enter the username you want to add as root: " username

# Create the new user with the given username
useradd -m -G wheel "$username"

# Set a password for the new user
passwd "$username"

# Ensure that sudo is present
pacman -Syy
pacman -S sudo

# Allow members of wheel to execute any command
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers

# Switch to the new user
su "$username"

# End of script
exit 0