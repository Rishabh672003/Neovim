#!/usr/bin/env bash
# Maintainer: Rishabh672003
# This script installs Neovim with LSP support on Arch Linux.

# Output that the script is only supported for Arch Linux
if command -v pacman &>/dev/null; then
	sudo pacman -Sy --noconfirm --needed
else
	echo "This script is only supported for Arch Linux"
	exit 1
fi

# Install Neovim.
function install_neovim() {
	if command -v nvim &>/dev/null; then
		echo "neovim is installed"
	else
		if command -v yay &>/dev/null; then
			yay -Sy --needed --noconfirm neovim-git
		else
			sudo pacman -Sy --needed --noconfirm neovim
		fi
	fi
}

# Install the mason packages.
function install_mason_dependency() {
	sudo pacman -S --needed --noconfirm git curl unzip tar gzip luarocks npm python-pip
}

# Install the Neovim configuration files.
function install_neovim_configuration() {
	# Create the Neovim configuration directory.
	if [ ! -d ~/.config/nvim ]; then
		mkdir -p ~/.config/nvim
	fi

	# Clone the Neovim configuration repository.
	git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim
}

# install packages
install_mason_dependency

# Install Neovim.
install_neovim

# Install the Neovim configuration files.
install_neovim_configuration

# Launch Neovim.
nvim
