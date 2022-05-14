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
after launching the nvim for the first time after installation packer will automatically install all the extension and most likely it will give you some errors, just ignore them and reopen neovim the errors should be resolved

also in my configs i have set tree-sitter to download java, python and lua automatically so if you son't want them remove them from tree-sitter.lua before installation or after installation by doing :TSUninstall java or python or lua

## Preview screenshots
![image](https://user-images.githubusercontent.com/53911515/168277253-37fccf26-4ee9-4550-9fb4-3c6c62a896c7.png)
![image](https://user-images.githubusercontent.com/53911515/168277426-ba588d49-3ba8-45bb-b474-8370543e1753.png)
![image](https://user-images.githubusercontent.com/53911515/168277485-a2822566-1c1d-442a-9c13-db72c0ea764d.png)
![image](https://user-images.githubusercontent.com/53911515/168277629-530bb449-60b8-4f58-940c-d4f871b6d66b.png)

## Uninstallation and Cleanup
```
rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.cache/nvim
```

the credit of this config goes to @ChristianChiarulli from whom and by his playlist https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ i learned to configure neovim with all the extensions and also configuring them,
so watch his playlist and support him for his awesome work. 

