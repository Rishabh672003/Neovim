# Neovim

This repo contains all my [neovim](https://github.com/neovim/neovim) configs files which i use. Now made with [lazy.nvim](https://github.com/folke/lazy.nvim)

### 🛠️ If you also want to use it

#### The Main branch of this repo is configured by me for the developement branch of Neovim which i use, if you are not using the developement branch but the 0.7.2 version of Neovim use that branch, its very stable and will always work for 0.7 version of Neovim

#### Neovim-nightly as an appimage

```bash
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage && sudo chmod +x nvim.appimage
```

#### Steps to build neovim

```bash
#build dependencies
sudo pacman -Sy --needed --noconfirm git base-devel cmake unzip ninja tree-sitter curl
```

```bash
git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
```

#### Make a backup of your current nvim folder

```bash
mv ~/.config/nvim ~/.config/nvimbackup
```

#### Clone the repository and open nvim

For main branch

```bash
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim && nvim
```

## After Installation

After launching neovim for the first time, packer will automatically install all the extension and will give you some errors, just ignore them and reopen neovim the errors should be resolved.

## optional dependencies

These are all the optional dependencies if you dont want anything just remove them neovim should work fine either way

For null-ls to work for formatting and stuff

```bash
sudo pacman -S --needed --noconfirm stylua prettier astyle zsh autopep8 ; yay -S beautysh shellcheck-bin
```

For finding text in projects and also bashls lsp requires npm as a dependency

```bash
sudo pacman -S --needed --noconfirm ripgrep npm unzip
```

## Automatting the whole process of building neovim from source and applying the config

```bash
sh <(curl -s https://raw.githubusercontent.com/Rishabh672003/Neovim/main/install.sh)
```

## Preview

You can change the startup-screen if you dont like this one go to lua/rj/plugins/alpha-themes and read the readme there
![image](https://user-images.githubusercontent.com/53911515/216835823-ff85c1d6-ab03-408c-9d7b-83c0f56a5445.png)
![image](https://user-images.githubusercontent.com/53911515/213927853-5e6460ed-a54d-414a-9151-f283d0ca9299.png)
![image](https://user-images.githubusercontent.com/53911515/213927964-90035c3a-cd4b-4983-9e30-604bd15f0fc4.png)
![image](https://user-images.githubusercontent.com/53911515/213927987-5e764e77-e82d-41fd-a97a-1be6952137e3.png)

## Uninstallation and Cleanup

```bash
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

### Credit

the credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author [Christian](https://github.com/ChristianChiarulli) who made this awesome repo and video playlist, this is from where i learned how to make and structure the configs and actually made it work, i used his configs as a base for most of the plugins and modified them for my needs.
also i took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim), [Astronvim](https://github.com/AstroNvim/AstroNvim) and [LazyVim](https://github.com/LazyVim/LazyVim) 

<div align="center" id="madewithlua">

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](#madewithlua)

</div>
