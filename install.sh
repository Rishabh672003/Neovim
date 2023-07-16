#!/bin/env bash

if command -v pacman &> /dev/null ; then
    sudo pacman -Sy --needed --noconfirm git base-devel unzip curl lua cargo;

    # lsp
    sudo pacman -Sy --needed --noconfirm npm python-pip stylua prettier astyle \
        ripgrep unzip npm zsh autopep8 lua-language-server \
        bash-language-server pyright typescript-language-server ;
else
    echo "This script is only supported for Arch Linux"
    exit 1;
fi

if command -v yay &> /dev/null ; then

    # lsp
    yay -S --needed --noconfirm shellcheck-bin beautysh jdtls lemminx marksman-bin;
else
    echo "yay not installed";
fi

if command -v cargo &> /dev/null ; then

    #lsp
    cargo install --features lsp --locked taplo-cli;
else
    echo "cargo not installed";
fi

if command -v npm &> /dev/null ; then

    # lsp
    npm i -g vscode-langservers-extracted;
else
    echo "npm not installed";
fi

rm -rf ~/nvim-linux64 > /dev/null 2>&1 ; \
    curl --output-dir "$HOME" \
    -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
    tar -xvf ~/nvim-linux64.tar.gz;

if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim;
fi

git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim;

echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.bashrc ;
echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.zshrc ;
echo "alias nvim='~/nvim-linux64/bin/nvim'" >> ~/.config/fish/config.fish ;

touch "$HOME"/.bashrc && source "$HOME"/.bashrc;
touch "$HOME"/.zshrc && source "$HOME"/.zshrc;

~/nvim-linux64/bin/nvim
