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
grub networkmanager network-manager-applet dialog wpa_supplicant \
mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs \
xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups \
hplip alsa-utils pulseaudio bash-completion openssh rsync reflector acpi acpi_call \
qemu-guest-agent edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat ipset firewalld \
sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font \
git
cargo \ # paru dependency
glu # for metashape

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg
pacman -U paru*.zst
cd ..
rm -rf paru

grub-install --target=i386-pc /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid
systemctl enable qemu-guest-agent


useradd -m anjo
echo anjo:password | chpasswd

echo "anjo ALL=(ALL) ALL" >> /etc/sudoers.d/anjo
echo "SystemMaxUse=100M" >> /etc/systemd/journald.conf


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

### mount shared directory
# sudo mount -t virtiofs /mount/tag /mnt

