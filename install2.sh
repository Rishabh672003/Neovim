#!/bin/env bash

sudo pacman -Sy --needed --noconfirm git base-devel unzip \
    curl lua &&\
    sudo pacman -Sy --needed --noconfirm npm python-pip stylua prettier astyle \
    ripgrep unzip npm zsh autopep8 ;
yay -S --needed --noconfirm shellcheck-bin beautysh ;
rm -rf ~/nvim-linux64 > /dev/null 2>&1 ; \
    curl --output-dir ~ \
    -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
    tar -xvf ~/Applications/nvim-linux64.tar.gz;
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim;
echo "alias nnv='~/nvim-linux64/bin/nvim'" >> ~/.bashrc ;
~/Applications/nvim-linux64/bin/nvim
