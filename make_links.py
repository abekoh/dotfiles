import os
import subprocess


def neovim():
    print('setup neovim')
    subprocess.run('ln -sf ~/dotfiles/config/nvim ~/.config/', shell=True)


def vim():
    print('setup vim')
    subprocess.run('ln -sf ~/dotfiles/config/nvim/init.vim ~/.vimrc', shell=True)
    vim_dir_path = os.path.join(os.environ['HOME'], '.vim')
    if not os.path.exists(vim_dir_path):
        os.mkdir(vim_dir_path)
    subprocess.run('ln -sf ~/dotfiles/config/nvim/options.rc.vim ~/.vim/', shell=True)
    subprocess.run('ln -sf ~/dotfiles/config/nvim/keymap.rc.vim ~/.vim/', shell=True)
    subprocess.run('ln -sf ~/dotfiles/config/nvim/ftplugin ~/.vim/', shell=True)


def fish():
    print('setup fish')
    dotfiles_path = os.path.join(os.environ['HOME'], 'dotfiles/config/fish')
    config_path = os.path.join(os.environ['HOME'], '.config/fish')
    if not os.path.exists(config_path):
        os.mkdir(config_path)
    for root, dirs, files in os.walk(dotfiles_path):
        for d in dirs:
            config_dir_path = os.path.join(config_path, d)
            if not os.path.exists(config_dir_path):
                os.mkdir(config_dir_path)
        for f in files:
            dotfiles_file_path = os.path.join(root, f)
            dir_name = root.replace(dotfiles_path, '')
            if dir_name.split('/')[0] == '':
                dir_name = '/'.join(dir_name.split('/')[1:])
            config_file_path = os.path.join(config_path, dir_name, f)
            subprocess.run(['ln', '-sf', dotfiles_file_path, config_file_path])


def zsh():
    print('setup zsh')
    subprocess.run('ln -sf ~/dotfiles/config/zsh/.zshrc ~/.zshrc', shell=True)
    subprocess.run('ln -sf ~/dotfiles/config/zsh/.zshenv ~/.zshenv', shell=True)


def tmux():
    print('setup tmux')
    subprocess.run('ln -sf ~/dotfiles/config/tmux/.tmux.conf ~/.tmux.conf', shell=True)


def python_utils():
    print('setup python-utils')
    subprocess.run('ln -sf ~/dotfiles/config/python-utils/pycodestyle ~/.config/', shell=True)


def git():
    print('setup git')
    config_path = os.path.join(os.environ['HOME'], '.git_template/hooks')
    if not os.path.exists(config_path):
        os.mkdir(config_path)
    subprocess.run('ln -sf ~/dotfiles/config/git/git_template/hooks/* ~/.git_template/hooks/', shell=True)


if __name__ == '__main__':
    config_dir_path = os.path.join(os.environ['HOME'], '.config')
    if not os.path.exists(config_dir_path):
        os.mkdir(config_dir_path)
    neovim()
    vim()
    fish()
    zsh()
    tmux()
    python_utils()
    git()
