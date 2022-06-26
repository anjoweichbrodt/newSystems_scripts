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

pacman -S grub os-prober base-devel linux-headers sof-firmware acpi acpi_call acpid networkmanager avahi wpa_supplicant firewalld ipset openssh iwd openbsd-netcat inetutils dnsutils reflector mtools dosfstools gvfs gvfs-smb nfs-utils ntfs-3g git neovim cargo fish rsync htop man

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

useradd -m anjo
echo anjo:password | chpasswd

echo "anjo ALL=(ALL) ALL" >> /etc/sudoers.d/anjo
echo "SystemMaxUse=100M" >> /etc/systemd/journald.conf

chsh -s "which fish"

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
