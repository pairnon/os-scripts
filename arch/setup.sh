#!/bin/bash

# Check if script is being run as root
echo "Checking if root..."
if [[ $EUID -ne 0 ]]; then
	echo "Not root; continuing"
else
	echo "This script cannot be run as root"
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
sudo pacman -Syy
sudo pacman -S screen vim vi nano htop neofetch

# Install yay
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install GUI packages if necessary
if [ "$gui_packages" == true ]; then
	yay -S chromium google-chrome visual-studio-code-bin

# End of script
exit 0