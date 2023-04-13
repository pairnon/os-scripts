#!/bin/bash

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

pacman -Syy
pacman -S screen vim vi nano htop neofetch

pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si