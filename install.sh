#!/usr/bin/bash
set -e

arch=$(uname -m)

sudo apt update
./requirements.sh
./get_dotfiles.sh

# Basic CLI tools
sudo apt install -y zsh nnn htop neofetch

# CLI apps
./install_nvim.sh
./copy_cli_dotfiles.sh

# Determine whether to install network manager.
if [[ $arch == "x86_64" || $arch == "x64" ]]; then
    echo "Detected amd64";

    wsl_detect_path="/proc/sys/fs/binfmt_misc/WSLInterop"
    if [[ -f "$wsl_detect_path" ]]; then 
        echo "Detected WSL running on amd64";

        echo "Skipping network manager install."
    else
        echo "Detected plain amd64";

        sudo apt install -y network-manager
    fi
else
    echo "Unknown CPU architecture: $arch.";
    
    sudo apt install -y network-manager
fi

if [[ "Desktop" == $1 ]]; then
    echo "Installing desktop..."
    ./install_desktop.sh

    if [[ $arch == "x86_64" || $arch == "x64" ]]; then
        echo "Detected amd64";
        ./install_apps_amd64.sh
    elif [[ $arch == "aarch64" || $arch = "arm64" ]]; then
        echo "Detected aarch64";
        ./install_apps_arm.sh
    else
        echo "Unknown CPU architecture: $arch.";
    fi
    
    ./copy_gui_dotfiles.sh
fi

# Setup java.
if [[ $arch == "x86_64" || $arch == "x64" ]]; then
    echo "Detected amd64";
    ./install_java_amd64.sh
elif [[ $arch == "aarch64" || $arch = "arm64" ]]; then
    echo "Detected aarch64";
    ./install_java_arm.sh
else
    echo "Unknown CPU architecture: $arch.";
fi

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Haskell
sudo apt install -y libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5
set BOOTSTRAP_HASKELL_NONINTERACTIVE=1
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Install Prolog
sudo apt install -y swi-prolog

mkdir -p ~/dev
mkdir -p ~/server

echo "Changing shell"
chsh -s /usr/bin/zsh

# Boot Config
if [[ $arch == "x86_64" || $arch == "x64" ]]; then
    echo "Detected amd64";
    ./configure_grub.sh
else
    echo "Unknown CPU architecture: $arch.";
fi
