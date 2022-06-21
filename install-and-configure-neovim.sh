#!/bin/env sh
#first get the build dependencies
sudo pacman -Sy --needed --noconfirm git base-devel cmake unzip ninja tree-sitter curl stylua prettier astyle shfmt ripgrep npm &&
  #then clone the neovim repo and build it
  git clone https://github.com/neovim/neovim &&
    cd neovim && 
    make CMAKE_BUILD_TYPE=RelWithDebInfo && 
    sudo make install &&
    git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim &&
    nvim
