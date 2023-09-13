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

# Prompt for additional packages
valid=false
add_packages=false
while [ "$valid" = false ]; do
	echo "Install additional packages? [y/N] "
	read choice
	if [ "$choice" == "y" ]; then
		add_packages=true
		valid=true
	elif [ "$choice" == "n" ]; then	
		valid=true
	elif [ "$choice" == "" ]; then
		valid=true
	else
		echo "Invalid choice. Please enter y or n."
	fi
done

# Prompt for Android Tools
valid=false
android_tools=false
while [ "$valid" = false ]; do
	echo "Install Android Tools (ADB)? [y/N] "
	read choice
	if [ "$choice" == "y" ]; then
		android_tools=true
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
sudo pacman -S screen vim vi nano htop neofetch pacman-contrib

# Install yay
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install additional packages if necessary
if [ "$add_packages" == true ]; then
	sudo pacman -S hydra nmap arp-scan john kismet hping wireshark-cli
fi

# Install GUI packages if necessary
if [ "$gui_packages" == true ]; then
	yay -S chromium librewolf-bin visual-studio-code-bin keepassxc
fi

# Install Android Tools if necessary
if [ "$android_tools" == true ]; then
	yay -S android-tools
fi

# End of script
exit 0