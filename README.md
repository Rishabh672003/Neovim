# Neovim

This repo contains all my neovim configs files which i use.

### 🛠️  If you also want to use it

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

```bash
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim && nvim
```

## After Installation

After launching neovim for the first time, packer will automatically install all the extension and will give you some errors, just ignore them and reopen neovim the errors should be resolved.

## optional dependencies

These are all the optional dependencies if you dont want anything just remove them neovim should work fine either way

For null-ls to work for formating and stuff

```bash
sudo pacman -S --needed --noconfirm stylua prettier astyle beautysh
```

For finding text in projects and also bashls lsp requires npm as a dependency

```bash
sudo pacman -S --needed --noconfirm ripgrep npm
```

## Automatting the whole process of building neovim from source and applying the config

```bash
curl https://gist.githubusercontent.com/Rishabh672003/bfbb6495e6a12bc22e94a112a15e3549/raw/7fb3849d2209567222c7ded838f4973f78aaf698/build%2520and%2520apply%2520neovim-config.sh >> $HOME/build-and-apply-neovim.sh && sudo chmod +x $HOME/build-and-apply-neovim.sh && $HOME/build-and-apply-neovim.sh
```

## Preview

![image](https://user-images.githubusercontent.com/53911515/179395376-a42e590d-cf53-4393-86aa-5eb84f77cdef.png)
![image](https://user-images.githubusercontent.com/53911515/169095446-128140ee-60c8-4a77-86e4-70eefd7f10e1.png)
![image](https://user-images.githubusercontent.com/53911515/168479997-4969b3f1-fe27-4ff0-86b5-acb629a29a0b.png)

## Uninstallation and Cleanup

```bash
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

### Credit

the credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author who made this awesome repo and video playlist, this is from where i learned how to make and structure the configs and actually make it work, i used his configs as a base for most of the plugins and modified them for my needs.
also i took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim) and [Astronvim](https://github.com/AstroNvim/AstroNvim)
