# Neovim

This repo contains all my neovim configs files which i use.

### 🛠️ If you also want to use it

#### My configs are for development branch of neovim so they might not work for any other version (they work as of now for the stable branch)

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

For 0.7.2 branch

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

## Automatting the whole process of building neovim from source and applying the config

```bash
curl https://gist.githubusercontent.com/Rishabh672003/bfbb6495e6a12bc22e94a112a15e3549/raw/5ca7165da2434af9531b36c956555056eae9b7c6/build%2520and%2520apply%2520neovim-config.sh >> $HOME/build-and-apply-neovim.sh && sudo chmod +x $HOME/build-and-apply-neovim.sh && $HOME/build-and-apply-neovim.sh
```

## Preview

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
