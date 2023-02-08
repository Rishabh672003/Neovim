#!/bin/env bash

sudo pacman -Sy --needed --noconfirm git base-devel cmake unzip ninja \
    tree-sitter curl lua &&\
    sudo pacman -Sy --needed --noconfirm npm python-pip stylua prettier astyle \
    ripgrep unzip npm zsh autopep8 ;
yay -S --needed --noconfirm shellcheck-bin beautysh ;
mkdir ~/neovim;
cd ~/neovim || exit ;
rm -rf ~/neovim/squashfs-root/ ~/neovim/nvim.appimage > /dev/null 2>&1 ; \
    curl --output-dir ~/neovim \
    -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage ; \
    chmod +x ~/neovim/nvim.appimage ; \
    ~/neovim/nvim.appimage --appimage-extract > /dev/null 2>&1;
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim;
~/neovim/squashfs-root/AppRun
