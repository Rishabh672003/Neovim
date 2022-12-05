#!/bin/env bash

sudo pacman -Sy --needed --noconfirm git base-devel cmake unzip ninja \
    tree-sitter curl lua &&\
    sudo pacman -Sy -needed --noconfirm npm pip stylua prettier astyle \
    ripgrep unzip npm zsh autopep8 ;
yay -S shellcheck-bin beautysh ;
git clone https://github.com/neovim/neovim &&
cd neovim &&
make CMAKE_BUILD_TYPE=RelWithDebInfo &&
sudo make install &&
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim &&
nvim
