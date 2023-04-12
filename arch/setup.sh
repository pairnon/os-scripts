#!/bin/bash

pacman -Syy
pacman -S screen vim vi nano htop neofetch

pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si