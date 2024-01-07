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

function check_and_install_yay() {
	sudo pacman -S which --noconfirm --needed
	# Check if yay is installed
	if ! which yay >/dev/null; then
		# If yay is not installed, ask the user if they want to install it
		read -rp "yay is not installed. Would you like to install it? (y/n): " prompt
		if [[ $prompt == [yY] || $prompt == [yY][eE][sS] ]]; then
			# If the user agrees to install yay, download the necessary dependencies
			sudo pacman -S --needed --noconfirm base-devel git &&
				git clone https://aur.archlinux.org/yay-bin.git "$HOME"/yay-bin &&
				cd "$HOME"/yay-bin &&
				makepkg -si &&
				rm -rf "$HOME"/yay-bin &&
				echo "yay has been installed."
		else
			echo "Not installing yay."
		fi
	else
		echo "yay is already installed."
	fi
}

# Install Neovim.
function install_neovim() {
	if command -v nvim &>/dev/null; then
		echo "neovim is installed"
	else
		if command -v yay &>/dev/null; then
			yay -Sy --needed --noconfirm neovim-nightly-bin
		else
			sudo pacman -Sy --needed --noconfirm neovim
		fi
	fi
}

# Install the mason packages.
function install_mason_dependency() {
	sudo pacman -S --needed --noconfirm git curl unzip tar gzip luarocks npm python-pip yarn
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

# install yay
check_and_install_yay

# install packages
install_mason_dependency

# Install Neovim.
install_neovim

# Install the Neovim configuration files.
install_neovim_configuration

# Launch Neovim.
nvim
