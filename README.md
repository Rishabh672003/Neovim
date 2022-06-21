# Neovim

This repo contains all my neovim config files which i use.

### 🛠️  If you also want to use it

#### my configs are for developement branch of neovim so it will not work for any other version of neovim
i use the neovim developement branch, so because of that you will have to build neovim from the source or you can use there nightly released appimages if you dont want to build it

#### Steps to build neovim
```
#build dependencies
sudo pacman -Sy --needed --noconfirm git base-devel cmake unzip ninja tree-sitter curl
```
```
git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
```

#### Make a backup of your current nvim folder
```
mv ~/.config/nvim ~/.config/nvimbackup
```

#### Clone the repository and open nvim

```
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim && nvim
```

## After Installation

after launching the nvim for the first time packer will automatically install all the extension and will give you some errors, just ignore them and reopen neovim the errors should be resolved.

## optional dependencies
As the name suggest these are the optional dependencies if you dont want anything just remove them neovim should work fine either way

For null-ls to work for formating and stuff-
```
sudo pacman -S --needed --noconfirm stylua prettier astyle shfmt
```
For finding text in projects and also bashls lsp requires npm as a dependency
```
sudo pacman -S --needed --noconfirm ripgrep npm
```

## automatting the whole procces
```
curl https://gist.githubusercontent.com/Rishabh672003/bfbb6495e6a12bc22e94a112a15e3549/raw/c7100faa6f3087b5a6bc3eecd4fe9bb6e12d085e/build%2520and%2520apply%2520neovim-config.sh >> $HOME/build-and-apply-neovim.sh && sudo chmod +x $HOME/build-and-apply-neovim.sh && $HOME/build-and-apply-neovim.sh
```

## Preview

![image](https://user-images.githubusercontent.com/53911515/168277253-37fccf26-4ee9-4550-9fb4-3c6c62a896c7.png)
![image](https://user-images.githubusercontent.com/53911515/169095446-128140ee-60c8-4a77-86e4-70eefd7f10e1.png)
![image](https://user-images.githubusercontent.com/53911515/168479997-4969b3f1-fe27-4ff0-86b5-acb629a29a0b.png)

## Uninstallation and Cleanup

```
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

### Credit

the credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author who made this awesome repo and video playlist, this is from where i learned how to make and structure the configs and actually make it work, i used his configs as a base for most of the plugins and modified them for my needs.
also i took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim) and [Astronvim](https://github.com/AstroNvim/AstroNvim)

