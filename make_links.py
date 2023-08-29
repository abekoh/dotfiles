#!/usr/local/bin/python3
import os
import subprocess


def neovim():
    print("setup neovim")
    subprocess.run("ln -sf ~/dotfiles/config/nvim ~/.config/", shell=True)
    subprocess.run("ln -sf ~/dotfiles/config/nvim ~/.config/", shell=True)

def astronvim():
    print("setup astronvim")
    nvim_path = os.path.join(os.environ["HOME"], ".config", "nvim")
    if not os.path.exists(nvim_path):
        os.makedirs(nvim_path)
        subprocess.run(f"git clone --depth 1 https://github.com/AstroNvim/AstroNvim {nvim_path}", shell=True)
    astro_nvim_path = os.path.join(os.environ["HOME"], ".config", "astronvim", "lua")
    if not os.path.exists(astro_nvim_path):
        os.makedirs(astro_nvim_path)
    astro_nvim_user_path = os.path.join(astro_nvim_path, "user")
    if not os.path.exists(astro_nvim_user_path):
        subprocess.run(f"ln -s ~/dotfiles/config/astronvim {astro_nvim_user_path}", shell=True)


def fish():
    print("setup fish")
    dotfiles_path = os.path.join(os.environ["HOME"], "dotfiles/config/fish")
    config_path = os.path.join(os.environ["HOME"], ".config/fish")
    if not os.path.exists(config_path):
        os.mkdir(config_path)
    for root, dirs, files in os.walk(dotfiles_path):
        for d in dirs:
            config_dir_path = os.path.join(config_path, d)
            if not os.path.exists(config_dir_path):
                os.mkdir(config_dir_path)
        for f in files:
            dotfiles_file_path = os.path.join(root, f)
            dir_name = root.replace(dotfiles_path, "")
            if dir_name.split("/")[0] == "":
                dir_name = "/".join(dir_name.split("/")[1:])
            config_file_path = os.path.join(config_path, dir_name, f)
            subprocess.run(["ln", "-sf", dotfiles_file_path, config_file_path])


def zsh():
    print("setup zsh")
    subprocess.run("ln -sf ~/dotfiles/config/zsh/.zshrc ~/.zshrc", shell=True)
    subprocess.run("ln -sf ~/dotfiles/config/zsh/.zshenv ~/.zshenv", shell=True)


def tmux():
    print("setup tmux")
    subprocess.run("ln -sf ~/dotfiles/config/tmux/.tmux.conf ~/.tmux.conf", shell=True)


def ideavim():
    print("setup ideavim")
    subprocess.run(
        "ln -sf ~/dotfiles/config/ideavim/.ideavimrc ~/.ideavimrc", shell=True
    )


def aws():
    print("setup aws")
    os.makedirs(os.path.join(os.environ["HOME"], ".aws", "cli"), exist_ok=True)
    subprocess.run(
        "ln -sf ~/dotfiles/config/aws/cli/alias ~/.aws/cli/alias", shell=True
    )


def git():
    print("setup git")
    os.makedirs(os.path.join(os.environ["HOME"], ".config", "git"), exist_ok=True)
    subprocess.run("ln -sf ~/dotfiles/config/git/ignore ~/.config/git/ignore", shell=True)
    subprocess.run("ln -sf ~/dotfiles/config/git/config ~/.config/git/config", shell=True)


def starship():
    print("setup starship")
    subprocess.run("ln -sf ~/dotfiles/config/starship/starship.toml ~/.config/starship.toml", shell=True)

def asdf():
    print("setup asdf")
    subprocess.run("ln -sf ~/dotfiles/config/asdf/.asdfrc ~/.asdfrc", shell=True)

def zellij():
    print("setup zellij")
    os.makedirs(os.path.join(os.environ["HOME"], ".config", "zellij"), exist_ok=True)
    subprocess.run("ln -sf ~/dotfiles/config/zellij/config.kdl ~/.config/zellij/config.kdl", shell=True)
    layout_path = os.path.join(os.environ["HOME"], ".config", "zellij", "layouts")
    if not os.path.exists(layout_path):
        subprocess.run(f"ln -sf ~/dotfiles/config/zellij/layouts {layout_path}", shell=True)

def alacritty():
    print("setup alacritty")
    os.makedirs(os.path.join(os.environ["HOME"], ".config", "alacritty"), exist_ok=True)
    subprocess.run("ln -sf ~/dotfiles/config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml", shell=True)
    subprocess.run("ln -sf ~/dotfiles/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml", shell=True)


if __name__ == "__main__":
    config_dir_path = os.path.join(os.environ["HOME"], ".config")
    if not os.path.exists(config_dir_path):
        os.mkdir(config_dir_path)
    # neovim()
    astronvim()
    fish()
    zsh()
    tmux()
    ideavim()
    aws()
    git()
    starship()
    asdf()
    zellij()
    alacritty()
