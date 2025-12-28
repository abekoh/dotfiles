#!/usr/bin/ruby
# frozen_string_literal: true

require 'fileutils'

DOTFILES_PATH = "#{ENV['HOME']}/dotfiles"
CONFIG_PATH = ENV['XDG_CONFIG_HOME'] || "#{ENV['HOME']}/.config"

def command_installed?(command)
  `which #{command} > /dev/null 2>&1`
end

def bin
  puts 'copy bin/ to ~/.local/bin'
  FileUtils.mkdir_p("#{ENV['HOME']}/.local/bin")
  `ln -sf #{DOTFILES_PATH}/bin/* ~/.local/bin`
end

def astronvim
  puts 'setup astronvim'
  `unlink #{CONFIG_PATH}/nvim` if File.symlink?("#{CONFIG_PATH}/nvim")
  `ln -sf #{DOTFILES_PATH}/config/astronvim #{CONFIG_PATH}/nvim`
end

def zsh
  puts 'setup zsh (with sheldon)'
  `ln -sf #{DOTFILES_PATH}/config/zsh/.zshrc ~/.zshrc`
  `ln -sf #{DOTFILES_PATH}/config/zsh/.zshenv ~/.zshenv`
  sheldon_path = "#{CONFIG_PATH}/sheldon"
  FileUtils.mkdir_p(sheldon_path) unless Dir.exist?(sheldon_path)
  `ln -sf #{DOTFILES_PATH}/config/zsh/sheldon.plugins.toml #{sheldon_path}/plugins.toml`
end

def ideavim
  puts 'setup ideavim'
  `ln -sf #{DOTFILES_PATH}/config/ideavim/.ideavimrc ~/.ideavimrc`
end

def aws
  puts 'setup aws'
  FileUtils.mkdir_p("#{ENV['HOME']}/.aws/cli")
  `ln -sf #{DOTFILES_PATH}/config/aws/cli/alias ~/.aws/cli/alias`
end

def git
  puts 'setup git'
  FileUtils.mkdir_p("#{CONFIG_PATH}/git")
  `ln -sf #{DOTFILES_PATH}/config/git/ignore #{CONFIG_PATH}/git/ignore`
  `ln -sf #{DOTFILES_PATH}/config/git/config #{CONFIG_PATH}/git/config`
end

def starship
  puts 'setup starship'
  `ln -sf #{DOTFILES_PATH}/config/starship/starship.toml #{CONFIG_PATH}/starship.toml`
end

def asdf
  puts 'setup asdf'
  `git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0` unless command_installed?('asdf')
  `ln -sf #{DOTFILES_PATH}/config/asdf/.asdfrc ~/.asdfrc`
end

def zellij
  puts 'setup zellij'
  `cargo install --locked zellij` unless command_installed?('zellij')
  FileUtils.mkdir_p("#{CONFIG_PATH}/zellij")
  `ln -sf #{DOTFILES_PATH}/config/zellij/config.kdl #{CONFIG_PATH}/zellij/config.kdl`
  layout_path = "#{CONFIG_PATH}/zellij/layouts"
  `ln -sf #{DOTFILES_PATH}/config/zellij/layouts #{layout_path}` unless Dir.exist?(layout_path)
end

def alacritty
  puts 'setup alacritty'
  FileUtils.mkdir_p("#{CONFIG_PATH}/alacritty")
  `ln -sf #{DOTFILES_PATH}/config/alacritty/alacritty.toml #{CONFIG_PATH}/alacritty/alacritty.toml`
end

def ghostty
  puts 'setup ghostty'
  FileUtils.mkdir_p("#{CONFIG_PATH}/ghostty")
  `ln -sf #{DOTFILES_PATH}/config/ghostty/config #{CONFIG_PATH}/ghostty/config`
end

def claude
  puts 'setup claude'
  FileUtils.mkdir_p("#{ENV['HOME']}/.claude")
  `ln -sf #{DOTFILES_PATH}/config/claude/settings.json #{ENV['HOME']}/.claude/settings.json`
  `ln -sf #{DOTFILES_PATH}/config/claude/CLAUDE.md #{ENV['HOME']}/.claude/CLAUDE.md`
end

if __FILE__ == $PROGRAM_NAME
  FileUtils.mkdir(CONFIG_PATH) unless Dir.exist?(CONFIG_PATH)
  bin
  astronvim
  zsh
  ideavim
  aws
  git
  starship
  asdf
  zellij
  alacritty
  ghostty
  claude
end
