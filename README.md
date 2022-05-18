# Neovim
This repo contains all my neovim config files which i use.

### 🛠️ If you also want to use it

#### Make a backup of your current nvim folder

```
mv ~/.config/nvim ~/.config/nvimbackup
```

#### Clone the repository

```
git clone https://github.com/Rishabh672003/Neovim ~/.config/nvim
```
```
nvim
```
## After Installation
after launching the nvim for the first time packer will automatically install all the extension and will give you some errors, just ignore them and reopen neovim the errors should be resolved

also in my configs i have set tree-sitter to download java, python and lua automatically so if you son't want them remove them from tree-sitter.lua before installation or after installation by doing :TSUninstall java or python or lua

## Preview screenshots
![image](https://user-images.githubusercontent.com/53911515/168277253-37fccf26-4ee9-4550-9fb4-3c6c62a896c7.png)
![image](https://user-images.githubusercontent.com/53911515/169095326-c2766eb3-a280-4947-bbf7-2b089200fce8.png)
![image](https://user-images.githubusercontent.com/53911515/168479997-4969b3f1-fe27-4ff0-86b5-acb629a29a0b.png)

## Uninstallation and Cleanup
```
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```
### Credit

the credit goes to [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch) and its author who made this awesome repo and video playlist, this is from where i learned how to make and structure the configs and actually make it work, i used his configs as a base for most of the plugins and modified them for my needs.
also i took configs and ideas from [Lunarvim](https://github.com/LunarVim/LunarVim) and [Astronvim](https://github.com/AstroNvim/AstroNvim) 

