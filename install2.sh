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

# Install the LSP packages.
function install_lsp_packages() {

    sudo pacman -S --needed --noconfirm npm python-pip stylua prettier astyle ripgrep unzip \
        npm zsh lldb;
    sudo pacman -S --needed --noconfirm taplo-cli autopep8 lua-language-server bash-language-server \
        pyright typescript-language-server rust-analyzer \
        tailwindcss-language-server;

    # Install the additional LSP packages.
    if command -v yay &> /dev/null ; then
        yay -S --needed --noconfirm lemminx marksman-bin jdtls \
            shellcheck-bin beautysh vscode-langservers-extracted \
            proselint;
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

# install packages
install_lsp_packages

# Install Neovim.
install_neovim

# Install the Neovim configuration files.
install_neovim_configuration

# Launch Neovim.
nvim
