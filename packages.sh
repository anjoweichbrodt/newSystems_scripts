#!/bin/bash

echo  "install basics"
sudo pacman -S --needed base-devel git wget htop nmtui man


echo "install AUR helper"
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si
cd .. && rm -rf paru


echo "install wayland"
sudo pacman -S wayland wayland-xorg qt5-wayland glfw-wayland
sudo echo MOZ_ENABLE_WAYLAND=1 > /etc/environment


echo "install tilemanager"
sudo pacman -S sway swaybg swayidle swaylock waybar wf-recorder brightnessctl gdm
paru -S sway-laucher-desktop 


echo "install filemanager & utilities"
sudo pacman -S nautilus gvfs ntfs-3g cifs-utils sshfs fzf
sudo echo 'image/x-xpixmap;image/x-canon-cr2;image/x-adobe-dng;' >> /usr/share/thumbnailers/gdk-pixbuf-thumbnailer.thumbnailer


echo "install shell & terminal"
sudo pacman -S kitty imagemagic fish
chsh -s `which fish`
chsh -s `which fish` anjo
paru -S nautilus-open-any-terminal
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty


echo "install sound"
sudo pacman -S pipewire pipwire-pulse
paru -S ncpamixer
## following should might be fixed by now
# /etc/pipewire/pipewire.conf
# exec /usr/bin/pipewire-media-session -e bluez5

echo "install browsing & email"
sudo pacman -S vivaldi qutebrowser thunderbird
paru -S protonmail-bridge


echo "install latex"
sudo pacman -S texlive-core
paru -S tllocalmgr-git
tllocalmgr install lastpage
tllocalmgr install siunitx
tllocalmgr install titlesec
texhash

echo "install editor"
sudo pacman -S neovim
paru -S neovim-coc # or coc through nodejs
# install nvim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


echo "install security tools"
sudo pacman -S keepassxc


echo "install work tools"
sudo pacman -S freecad qpdf libreoffice krita geeqie inkscape rawtherapee qgis vlc wireshark

echo "install fonts&appearances"
sudo pacman -S gnome-tweak-tool ttf-inconsolata breeze-gtkt 
paru -S zafiro-icon-theme

echo "set up zoom"
sudo pacman -S xdg-desktop-portal-wlr # enables screensharing on sway
paru -S zoom


echo "install developping tools"
sudo pacman -S python python-pip python-black python-pytest python-pytest-cov python-pynvim pyright
paru -S pycharm-professional datagrip-jre

# allow install pip-packages only in virtual environments
sudo echo PIP_REQUIRE_VIRTUALENV true > /etc/environment 
# echo "set -gx PIP_REQUIRE_VIRTUALENV true" > .config/fish/config.fish


echo "set up docker"
sudo pacman docker docker-compose
systemctl enable docker.service
usermod -aG docker $USER


echo "set up networking"
sudo pacman -S networkmanager
sudo pacman -S networkmanager-vpnc # for ETH
sudo pacman -S nm-connection-editor # options for connect with VPN


# echo "install syncthing" # file synching between different devices
# sudo pacman -S syncthing
# sudo systemctl --user enable syncthing


## pass
# passw
# gnupg
# gpg --full-gen-key
# pass init <user>
# https://blog.larsveelaert.be/2017/09/23/gnupg-based-password-manager/


## GNOME ##
# 
# echo "install gnome"
# sudo pacman -S gnome
# 
# echo "set up gnome shell extensions"
# paru -S gnome-shell-extension-pop-shell-git gnome-shell-extension-no-title-bar
# 
# https://www.addictivetips.com/ubuntu-linux-tips/back-up-the-gnome-shell-desktop-settings-linux/


## EXTRA CONNECTION SETUP ETH & eduraoam
# nmcli con add type wifi ifname wlan0 con-name CONNECTION_NAME ssid SSID
# nmcli con edit id CONNECTION_NAME
# nmcli> set ipv4.method auto
# nmcli> set 802-1x.eap peap
# nmcli> set 802-1x.phase2-auth mschapv2
# nmcli> set 802-1x.identity USERNAME
# nmcli> save
# nmcli> activate
# You may also need to add
# 
# nmcli> set 802-1x.password PASSWORD
# nmcli> set 802-1x.anonymous-identity ANONYMOUS-IDENTITY for eduroam same as identity
# nmcli> set wifi-sec.key-mgmt wpa-eap
# 
# ## --> translate networkmanager-editor clicks into nmcli command lines
# #
# ## maybe through cli
# https://gist.github.com/pastleo/aa3a9524664864c505d637b771d079c9
# 
# nmcli c add con-name CON_NAME type vpn vpn-type l2tp vpn.data 'gateway=GATEWAY_HOST, ipsec-enabled=yes, ipsec-psk=PRE_SHARED_KEY, password-flags=2, user=USERNAME'
# nmcli c edit CON_NAME # interactive mode, type help for manual
# nmcli c up CON_NAME
# nmcli c down CON_NAME
# nmcli c delete CON_NAME

