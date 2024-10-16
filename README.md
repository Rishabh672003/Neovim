# Neovim

This repository contains all my [neovim](https://github.com/neovim/neovim) config files, which I use. Now made with [mini.deps](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-deps.md)

## 🛠️ If you also want to use it

Supported Neovim versions: Nightly and Latest Stable

You can see the installation instruction for both here - [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

### Make a backup of your current nvim folder

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

### Clone the repository and open nvim

For main branch

```bash
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim && nvim
```

Note: Installation of the LSP servers need the [Optional dependencies](#Optional-dependencies), Install them before cloning the config

If LSP servers aren't getting installed by default install them using **`:MasonToolsInstall`**

### Optional dependencies

These are all the optional dependencies if you don't want anything just remove them neovim should work fine either way

```bash
sudo pacman -S --needed --noconfirm yarn git curl unzip tar gzip luarocks npm python-pip go
```

For Rust support install `rust-analyzer` yourself.

### Automating the whole process of installing neovim, also its dependencies and then applying the config

**Note: this will install the optional dependencies so use it only after reading the script and if you know what you are doing, I will not be responsible if you break anything on your system**

```bash
bash <(curl -s https://raw.githubusercontent.com/Rishabh672003/Neovim/main/utils/install.sh)
```

### Preview

![image](https://github.com/user-attachments/assets/85680266-ebe3-4edd-82cf-f17e15f9fa7c)
![image](https://github.com/user-attachments/assets/bfb84c0f-5bdf-41ad-ab98-1c69f4699cd5)

## Uninstallation and Cleanup

```bash
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

### Credit

The credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author [Christian](https://github.com/ChristianChiarulli) who made this awesome repo and video playlist, this is from where I learned how to make and structure the configs and actually made it work, I used his configs as a base for most of the plugins and modified them for my needs.
also I took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim), [Astronvim](https://github.com/AstroNvim/AstroNvim), [LazyVim](https://github.com/LazyVim/LazyVim) and [nvim-basic-ide](https://github.com/lunarvim/nvim-basic-ide)

<div align="center" id="madewithlua">

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](#madewithlua)

</div>
