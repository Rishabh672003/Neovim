#!/bin/env bash

# Maintainer: Rishabh672003

# This script installs Neovim with LSP support on Arch Linux.

# Install the required packages.
function install_packages() {
    local packages=("$@")

    for package in "${packages[@]}"; do
        sudo pacman -S --needed --noconfirm "$package"
    done
}

# Check for errors.
function check_error() {
    local error_code=$1
    local error_message=$2

    if [[ $error_code -ne 0 ]]; then
        echo "Error: $error_message"
        exit 1
    fi
}

# Install the LSP packages.
function install_lsp_packages() {

    sudo pacman -Sy &&
    # Install the required packages.
    install_packages npm python-pip stylua prettier astyle ripgrep unzip \
        npm zsh lldb;
    install_packages taplo-cli autopep8 lua-language-server bash-language-server \
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
        npm install -g dockerfile-language-server-nodejs;
    fi
}

# Install Neovim.
function install_neovim() {
    if [[ ! -d ~/Applications ]]; then
        mkdir -p ~/Applications;
    fi

    cd ~/Applications || exit;

    # Download the Neovim tarball.
    if command -v aria2c &> /dev/null; then
        rm -rf ~/Applications/nvim-linux64 ~/Applications/nvim-linux64.tar.gz > /dev/null 2>&1 ;
        aria2c "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
        tar -xvf ~/Applications/nvim-linux64.tar.gz > /dev/null 2>&1
    else
        rm -rf ~/Applications/nvim-linux64 ~/Applications/nvim-linux64.tar.gz > /dev/null 2>&1 ; \
            curl --output-dir ~/Applications/ \
            -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
            tar -xvf ~/Applications/nvim-linux64.tar.gz > /dev/null 2>&1
    fi

    # Check if the download was successful.
    check_error $? "Failed to download Neovim tarball."

    # Extract the Neovim tarball.
    cd "$HOME" && tar -xvf nvim-linux64.tar.gz
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

# Add aliases to the Bash and Zsh configuration files.
function add_aliases() {
    echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.bashrc
    echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.zshrc
    echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.config/fish/config.fish
}

# Update the Bash and Zsh configuration files.
function update_configuration_files() {
    touch "$HOME"/.bashrc && source "$HOME"/.bashrc
    touch "$HOME"/.zshrc && source "$HOME"/.zshrc
}

# install packages
install_lsp_packages

# Install Neovim.
install_neovim

# Install the Neovim configuration files.
install_neovim_configuration

# Add aliases to the Bash and Zsh configuration files.
add_aliases

# Update the Bash and Zsh configuration files.
update_configuration_files

# Launch Neovim.
~/nvim-linux64/bin/nvim
