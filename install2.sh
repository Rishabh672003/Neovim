#!/bin/env bash
# Maintainer: Rishabh672003

# This script installs Neovim with LSP support on Arch Linux.

# Install Neovim.
function install_neovim() {
    if command -v yay &> /dev/null ; then
        yay -Sy --needed --noconfirm meovim-git
    else
        sudo pacman -Sy --needed --noconfirm neovim
    fi
}

function check_and_install_yay() {
    # Check if yay is installed
    if ! which yay >/dev/null; then
        # If yay is not installed, ask the user if they want to install it
        read -rp "yay is not installed. Would you like to install it? (y/n): " prompt
        if [[ $prompt == [yY] || $prompt == [yY][eE][sS] ]]; then
            # If the user agrees to install yay, download the necessary dependencies
            sudo pacman -S --needed base-devel git &&
            git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin &&
            (cd ~/yay-bin || exit) &&
            makepkg -si &&
            cd .. &&
            rm -rf yay-bin &&
            echo "yay has been installed."
        else
            echo "Not installing yay."
        fi
    else
        echo "yay is already installed."
    fi
}

# Install the LSP packages.
function install_lsp_packages() {

    sudo pacman -S --needed --noconfirm npm python-pip stylua prettier astyle ripgrep unzip \
        npm zsh lldb wl-clipboard;
    sudo pacman -S --needed --noconfirm taplo-cli autopep8 lua-language-server bash-language-server \
        pyright typescript-language-server rust-analyzer \
        tailwindcss-language-server;

    # Install the additional LSP packages.
    if command -v yay &> /dev/null ; then
        yay -S --needed --noconfirm lemminx marksman-bin jdtls \
            shellcheck-bin beautysh vscode-langservers-extracted \
            proselint
    else
        echo "Yay is not Installed, so some dependecies will not be installed"
    fi

    if command -v cargo &> /dev/null ; then
        cargo install --features lsp --locked taplo-cli;
    fi

    if command -v npm &> /dev/null ; then
        sudo npm install -g dockerfile-language-server-nodejs;
    fi
}

# Install the Neovim configuration files.
function install_neovim_configuration() {
    # Create the Neovim configuration directory.
    if [ ! -d ~/.config/nvim ]; then
        mkdir -p ~/.config/nvim;
    fi

    # Clone the Neovim configuration repository.
    git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim;
}

# yay
check_and_install_yay

# install packages
install_lsp_packages

# Install Neovim.
install_neovim

# Install the Neovim configuration files.
install_neovim_configuration

# Launch Neovim.
nvim
