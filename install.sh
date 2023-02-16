#!/bin/env bash

sudo pacman -Sy --needed --noconfirm git base-devel unzip \
    curl lua cargo &&\
    sudo pacman -Sy --needed --noconfirm npm python-pip stylua prettier astyle \
    ripgrep unzip npm zsh autopep8 lua-language-server \
    bash-language-server pyright lemminx ;
yay -S --needed --noconfirm shellcheck-bin beautysh jdtls lemminx;
cargo install --features lsp --locked taplo-cli;
cargo install prosemd-lsp;
npm i -g vscode-langservers-extracted;
rm -rf ~/nvim-linux64 > /dev/null 2>&1 ; \
    curl --output-dir ~ \
    -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
    tar -xvf ~/nvim-linux64.tar.gz;
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim;
echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.bashrc ;
echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.zshrc ;
echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.config/fish/config.fish ;
source "$HOME/.bashrc";
source "$HOME/.zshrc";
~/nvim-linux64/bin/nvim
