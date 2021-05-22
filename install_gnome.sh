#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Switzerland -a 12 --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -S --noconfirm gdm gnome gnome-tweaks chrome-gnome-shell

sudo systemctl enable gdm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
