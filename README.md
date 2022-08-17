# Neovim

This repo contains all my neovim configs files which i use.

### 🛠️ If you also want to use it

#### Install neovim and apply the configs

```bash
git clone -b neovim-0.7.2 https://github.com/Rishabh672003/Neovim ~/.config/nvim && nvim
```

## After Installation

After launching neovim for the first time, packer will automatically install all the extension and will give you some errors, just ignore them and reopen neovim the errors should be resolved.

## optional dependencies

These are all the optional dependencies if you dont want anything just remove them neovim should work fine either way

For null-ls to work for formating and stuff

```bash
sudo pacman -S --needed --noconfirm stylua prettier astyle zsh ; yay -S beautysh shellcheck-bin
```

For finding text in projects and also bashls lsp requires npm as a dependency

```bash
sudo pacman -S --needed --noconfirm ripgrep npm
```

## Preview

You can change the startup-screen if you dont like this one go to lua/user/startup-screens and read the readme there
![image](https://user-images.githubusercontent.com/53911515/179395376-a42e590d-cf53-4393-86aa-5eb84f77cdef.png)
![image](https://user-images.githubusercontent.com/53911515/179547660-33be75ce-81ae-4a5f-bc5d-0de3b6e7d3c6.png)
![image](https://user-images.githubusercontent.com/53911515/179548270-33d15215-28b7-46ac-bf9a-62f20b32ba21.png)
![image](https://user-images.githubusercontent.com/53911515/179548015-4e6473a8-f9a3-42c0-8018-044190dd3292.png)

## Uninstallation and Cleanup

```bash
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

### Credit

the credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author who made this awesome repo and video playlist, this is from where i learned how to make and structure the configs and actually make it work, i used his configs as a base for most of the plugins and modified them for my needs.
also i took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim) and [Astronvim](https://github.com/AstroNvim/AstroNvim)
