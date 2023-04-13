#!/bin/bash

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi

# Prompt for GUI package installation
valid=false
gui_packages=false
while [ "$valid" = false ]; do
	echo "Install GUI packages? [y/N] "
	read choice
	if [ "$choice" == "y" ]; then
		gui_packages=true
		valid=true
	elif [ "$choice" == "n" ]; then	
		valid=true
	elif [ "$choice" == "" ]; then
		valid=true
	else
		echo "Invalid choice. Please enter y or n."
	fi
done

# Install CLI packages
pacman -Syy
pacman -S sudo screen vim vi nano htop neofetch

# Install yay
pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si