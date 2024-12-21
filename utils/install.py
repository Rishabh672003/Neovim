#!/usr/bin/env python
# Maintainer: Rishabh672003
# only supported for ArchLinux and Windows

import os
import platform
import shutil
import subprocess
from pathlib import Path

# fmt: off
neovim_linux_config = Path.home() / ".config" / "nvim"
neovim_windows_config = Path.home() / "AppData" / "Local" / "nvim"
repo_link = "https://github.com/Rishabh672003/Neovim"
mason_dependencies = [ "git", "curl", "unzip", "tar", "gzip", "luarocks", "npm", "python-pip", "yarn", "go" ]
# fmt: on


def arch_linux_setup():
    # get the neovim and the dependencies
    if shutil.which("pacman"):
        # fmt: off
        subprocess.run(["sudo", "pacman", "-S", "--needed", "--noconfirm", "neovim" ])
        subprocess.run(["sudo", "pacman", "-S", "--needed", "--noconfirm", *mason_dependencies ])
        # fmt: on
    # make the dir if it doesnt exit
    if not os.path.isdir(neovim_linux_config):
        os.makedirs(neovim_linux_config, exist_ok=True)
        print(f"Created directory: {neovim_linux_config}")
    else:
        pass

    # if already a directory exists and not not empty take a backup
    if os.listdir(neovim_linux_config):
        backup_path = f"{neovim_linux_config}.backup"
        shutil.move(neovim_linux_config, backup_path)
        print(f"Directory was not empty. Backed up to: {backup_path}")

        # Recreate the empty nvim directory for cloning
        os.makedirs(neovim_linux_config, exist_ok=True)
    else:
        print("Directory is empty. No backup needed.")

    # finally clone the rep in the directory
    subprocess.run(["git", "clone", repo_link, neovim_linux_config])


def windown_setup():
    if not shutil.which("winget"):
        return Exception("Winget not found, please install winget")
    else:
        subprocess.run(["winget", "install", "Neovim.Neovim"])
        if not shutil.which("git"):
            subprocess.run(["winget", "install", "Git.Git"])
        subprocess.run(["git", "clone", repo_link, neovim_windows_config])


if __name__ == "__main__":
    if platform.system() == "Windows":
        windown_setup()
    else:
        arch_linux_setup()
