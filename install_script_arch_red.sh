#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us-acentos" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

pacman -S grub wayland qt5-wayland glfw-wayland pipewire efibootmgr networkmanager base-devel bluez bluez-utils cups openssh rsync tlp

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable tlp

useradd -m anjo
echo anjo:password | chpasswd

echo "anjo ALL=(ALL) ALL" >> /etc/sudoers.d/anjo


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"