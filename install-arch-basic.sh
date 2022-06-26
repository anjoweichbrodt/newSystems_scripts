#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us-acentos" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

pacman -S \
grub base-devel linux-headers sof-firmware acpi acpi_call acpid \
networkmanager avahi wpa_supplicant firewalld ipset \
openssh nmtui openbsd-netcat inetutils dnsutils reflector \
mtools dosfstools gvfs gvfs-smb nfs-utils ntfs-3g \
git cargo fish rsync htop man \

# install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg
pacman -U paru*.zst
cd ..
rm -rf paru

paru -S informant

grub-install --target=i386-pc /dev/vda
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
