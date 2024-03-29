#!/usr/bin/bash
set -e

sudo apt install -y xorg i3 i3blocks rofi lightdm picom lxappearance materia-gtk-theme feh flameshot pavucontrol hicolor-icon-theme kitty fonts-noto libgtk-3-dev pasystray network-manager-gnome lxpolkit cava brightnessctl thunar

# Install i3blocks
rm -rfv ./i3blocks-contrib
git clone --depth 1 https://github.com/vivien/i3blocks-contrib.git
cd i3blocks-contrib
rm -rfv ~/.config/i3blocks
mkdir -p ~/.config/i3blocks
cp -rv ./. ~/.config/i3blocks
cd ..

# Install Icons
rm -rfv ./Wings-Plasma-Themes
git clone --depth 1 https://github.com/L4ki/Wings-Plasma-Themes.git
sudo cp -rv ./Wings-Plasma-Themes/Wings\ Icons\ Themes/* /usr/share/icons/

# Install i3lock-color
sudo apt install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
rm -rfv i3lock-color
git clone --depth 1 https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
cd ..

# Install lockscreen
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system

# Drag and drop support
rm -rfv dragon
git clone --depth 1 https://github.com/mwh/dragon
cd dragon
sudo make PREFIX="/usr/bin" install
cd ..

sudo mkdir -p /usr/share/backgrounds
sudo cp -v ./bg1440.png /usr/share/backgrounds

