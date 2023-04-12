#!/bin/bash

sudo pacman -Syy
sudo pacman -S screen vim vi nano htop neofetch

sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si