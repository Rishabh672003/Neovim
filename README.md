# Neovim

This repo contains all my [neovim](https://github.com/neovim/neovim) configs files, which I use. Now made with [lazy.nvim](https://github.com/folke/lazy.nvim)
Now this doesn't uses Mason, so you would have to install all lsp yourself.

For most of time of this configs existence I did everything on the main branch, but that is changed now i experiment and use the `dev` branch and will only merge stuff once in a while to the main, so now this will be way more stable.

### 🛠️ If you also want to use it

#### I use it with nvim-nightly but it also works with latest stable nvim

I recommend use **bob**:

[Bob](https://github.com/MordechaiHadad/bob) is a neovim version manager, which you can use to download any version of neovim supported by Bob

To use it just install it with AUR:

```sh
yay -Sy --needed --noconfirm bob-bin
```

Or with Cargo:

```sh
# NOTE: this will build from source
cargo install --git https://github.com/MordechaiHadad/bob.git
```

And then you can just do:

```sh
bob use nightly
```

Also note you will need to add bob's nvim install folder to your path for that add this to your bashrc/zshrc

```sh
export XDG_DATA_HOME=$HOME/.local/share
export PATH=$XDG_DATA_HOME/bob/nvim-bin:$PATH
```

But this will also work:

```sh
sudo pacman -Sy --needed --noconfirm neovim
```

Or after installation of bob:

```sh
bob use stable
```

<details>
  <summary><strong>Neovim-nightly Installation</strong></summary>

#### 1. Neovim-nightly as an appimage

```bash
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage && sudo chmod +x nvim.appimage
```

#### 2. Build neovim from Source

```bash
#build dependencies
sudo pacman -Sy --needed --noconfirm git base-devel cmake unzip ninja tree-sitter curl
```

```bash
git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
```

#### 3. Install neovim-git from AUR

```sh
yay -Sy neovim-nightly
```

</details>

#### Make a backup of your current nvim folder

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

#### Clone the repository and open nvim

For main branch

```bash
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim && nvim
```

## Optional dependencies

These are all the optional dependencies if you don't want anything just remove them neovim should work fine either way

#### LSP dependencies as now these configs don't use mason, so you will have to install them yourself

**These may not be up to date so please look at `lua/rj/lsp/lsp-conf.lua` for the list of all servers**

```bash
sudo pacman -Sy --needed --noconfirm lua-language-server rust-analyzer \
	bash-language-server typescript-language pyright taplo-cli \
	tailwindcss-language-server vscode-html-languageserver yaml-language-server
yay -S jdtls lemminx
sudo npm i -g vscode-langservers-extracted docker-langserver
```

For null-ls to work for formatting and stuff

```bash
sudo pacman -S --needed --noconfirm stylua prettier astyle zsh autopep8 python-black
yay -S beautysh shellcheck-bin proselint
```

Other dependencies

```bash
sudo pacman -S --needed --noconfirm ripgrep npm unzip yarn
```

## Automating the whole process of installing neovim, also its dependencies and then applying the config

**Note: this will install a lot of dependencies so use it only after reading the script and if you know what you are doing, I will not be responsible if you break anything on your system**

```bash
bash <(curl -s https://raw.githubusercontent.com/Rishabh672003/Neovim/main/install.sh)
```

## Preview

You can change the startup-screen if you don't like this one go to lua/rj/plugins/alpha-themes and read the readme there
![image](https://user-images.githubusercontent.com/53911515/216835823-ff85c1d6-ab03-408c-9d7b-83c0f56a5445.png)
![image](https://user-images.githubusercontent.com/53911515/227719958-c34ba80a-3ae8-4e32-a7ae-7b6ca0503a13.png)
![image](https://user-images.githubusercontent.com/53911515/213927964-90035c3a-cd4b-4983-9e30-604bd15f0fc4.png)
![image](https://user-images.githubusercontent.com/53911515/213927987-5e764e77-e82d-41fd-a97a-1be6952137e3.png)

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
