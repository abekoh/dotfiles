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
  nvim_path = "#{CONFIG_PATH}/nvim"
  unless Dir.exist?(nvim_path)
    FileUtils.mkdir_p(nvim_path)
    `git clone --depth 1 https://github.com/AstroNvim/AstroNvim #{nvim_path}`
  end
  astro_nvim_path = "#{CONFIG_PATH}/astronvim/lua"
  FileUtils.mkdir_p(astro_nvim_path) unless Dir.exist?(astro_nvim_path)
  astro_nvim_user_path = "#{astro_nvim_path}/user"
  `ln -s #{DOTFILES_PATH}/config/astronvim #{astro_nvim_user_path}` unless Dir.exist?(astro_nvim_user_path)
end

def zsh
  puts 'setup zsh'
  `ln -sf #{DOTFILES_PATH}/config/zsh/.zshrc ~/.zshrc`
  `ln -sf #{DOTFILES_PATH}/config/zsh/.zshenv ~/.zshenv`
end

def ideavim
  puts 'setup ideavim'
  `ln -sf #{DOTFILES_PATH}/config/ideavim/.ideavimrc ~/.ideavimrc`
end

def aws
  puts 'setup aws'
  FileUtils.mkdir_p('~/.aws/cli')
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
  `ln -sf #{DOTFILES_PATH}/config/alacritty/alacritty.yml #{CONFIG_PATH}/alacritty/alacritty.yml`
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
end
