# Neovim

[![Plugins](https://dotfyle.com/Rishabh672003/neovim/badges/plugins?style=for-the-badge)](https://dotfyle.com/Rishabh672003/neovim)
[![Leader Key](https://dotfyle.com/Rishabh672003/neovim/badges/leaderkey?style=for-the-badge)](https://dotfyle.com/Rishabh672003/neovim)
[![Plugin Manager](https://dotfyle.com/Rishabh672003/neovim/badges/plugin-manager?style=for-the-badge)](https://dotfyle.com/Rishabh672003/neovim)

This repo contains all my [neovim](https://github.com/neovim/neovim) configs files, which I use. Now made with [lazy.nvim](https://github.com/folke/lazy.nvim)

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
bash <(curl -s https://raw.githubusercontent.com/Rishabh672003/Neovim/main/install.sh)
```

### Preview

![image](https://github.com/Rishabh672003/Neovim/assets/53911515/20c2dde6-c369-4bea-be24-eaf9ff359581)
![image](https://github.com/Rishabh672003/Neovim/assets/53911515/be32d082-6ade-4166-a63b-032749cef49d)
![image](https://github.com/Rishabh672003/Neovim/assets/53911515/2003cd47-61b3-4244-a2c0-5866c5159673)
![image](https://github.com/Rishabh672003/Neovim/assets/53911515/80b9cde3-af3e-477d-bb30-53358c7e5959)

## Uninstallation and Cleanup

```bash
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

### Credit

The credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author [Christian](https://github.com/ChristianChiarulli) who made this awesome repo and video playlist, this is from where I learned how to make and structure the configs and actually made it work, I used his configs as a base for most of the plugins and modified them for my needs.
also I took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim), [Astronvim](https://github.com/AstroNvim/AstroNvim), [LazyVim](https://github.com/LazyVim/LazyVim) and [nvim-basic-ide](https://github.com/lunarvim/nvim-basic-ide)

<div align="center" id="madewithlua"></div>
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](#madewithlua)

</div>
