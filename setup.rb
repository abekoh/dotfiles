#!/usr/bin/ruby
# frozen_string_literal: true

require 'fileutils'
require 'open-uri'
require 'tempfile'

DOTFILES_PATH = "#{ENV['HOME']}/dotfiles"
CONFIG_PATH = ENV['XDG_CONFIG_HOME'] || "#{ENV['HOME']}/.config"

CLAUDE_MANAGED_SKILLS = {
  'herdr' => 'https://raw.githubusercontent.com/herdrdev/herdr/master/skills/herdr/SKILL.md',
  'japanese-tech-writing' => 'https://gist.githubusercontent.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d/raw/SKILL.md',
  'cognitive-rhythm-writing' => 'https://gist.githubusercontent.com/k16shikano/eb2929f13ed19c97188393d297be8432/raw/SKILL.md',
  'hunk-review' => 'https://raw.githubusercontent.com/modem-dev/hunk/main/skills/hunk-review/SKILL.md'
}.freeze

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

def zellij
  puts 'setup zellij'
  `cargo install --locked zellij` unless command_installed?('zellij')
  FileUtils.mkdir_p("#{CONFIG_PATH}/zellij")
  `ln -sf #{DOTFILES_PATH}/config/zellij/config.kdl #{CONFIG_PATH}/zellij/config.kdl`
  layout_path = "#{CONFIG_PATH}/zellij/layouts"
  `ln -sf #{DOTFILES_PATH}/config/zellij/layouts #{layout_path}` unless Dir.exist?(layout_path)
end

def herdr
  puts 'setup herdr'
  `brew install herdr` unless command_installed?('herdr')
  FileUtils.mkdir_p("#{CONFIG_PATH}/herdr")
  `ln -sf #{DOTFILES_PATH}/config/herdr/config.toml #{CONFIG_PATH}/herdr/config.toml`
end

def ghostty
  puts 'setup ghostty'
  FileUtils.mkdir_p("#{CONFIG_PATH}/ghostty")
  `ln -sf #{DOTFILES_PATH}/config/ghostty/config #{CONFIG_PATH}/ghostty/config`
end

def update_claude_skills
  puts 'check managed claude skills'

  CLAUDE_MANAGED_SKILLS.each do |name, url|
    skill_dir = "#{DOTFILES_PATH}/config/claude/skills/#{name}"
    skill_path = "#{skill_dir}/SKILL.md"
    content = URI.open(
      url,
      'User-Agent' => 'dotfiles-setup',
      open_timeout: 10,
      read_timeout: 15
    ).read

    unless content.match?(/^name:\s*["']?#{Regexp.escape(name)}["']?\s*$/)
      warn "skip #{name}: downloaded content has an unexpected skill name"
      next
    end

    if File.exist?(skill_path) && File.binread(skill_path) == content.b
      puts "  #{name}: up to date"
      next
    end

    FileUtils.mkdir_p(skill_dir)
    Tempfile.create(['SKILL', '.md'], skill_dir) do |tempfile|
      tempfile.binmode
      tempfile.write(content)
      tempfile.close
      FileUtils.mv(tempfile.path, skill_path)
    end
    puts "  #{name}: updated"
  rescue OpenURI::HTTPError, SocketError, SystemCallError, Timeout::Error => e
    warn "skip #{name}: #{e.message}"
  end
end

def claude
  puts 'setup claude'
  update_claude_skills
  FileUtils.mkdir_p("#{ENV['HOME']}/.claude")
  `ln -sf #{DOTFILES_PATH}/config/claude/settings.json #{ENV['HOME']}/.claude/settings.json`
  `ln -sf #{DOTFILES_PATH}/config/claude/CLAUDE.md #{ENV['HOME']}/.claude/CLAUDE.md`
  FileUtils.mkdir_p("#{ENV['HOME']}/.claude/skills")
  `ln -sf #{DOTFILES_PATH}/config/claude/skills/* #{ENV['HOME']}/.claude/skills/`
  FileUtils.mkdir_p("#{CONFIG_PATH}/claude/scripts")
  `ln -sf #{DOTFILES_PATH}/config/claude/scripts/notify.sh #{CONFIG_PATH}/claude/scripts/notify.sh`
end

def codex
  puts 'setup codex'
  FileUtils.mkdir_p("#{ENV['HOME']}/.agents/skills")
  `ln -sf #{ENV['HOME']}/.claude/skills/* #{ENV['HOME']}/.agents/skills/`
  FileUtils.mkdir_p("#{ENV['HOME']}/.codex")
  `ln -sf #{DOTFILES_PATH}/config/codex/config.toml #{ENV['HOME']}/.codex/config.toml`
  `ln -sf #{ENV['HOME']}/.claude/CLAUDE.md #{ENV['HOME']}/.codex/AGENTS.md`
end

def peco
  puts 'setup peco'
  FileUtils.mkdir_p("#{CONFIG_PATH}/peco")
  `ln -sf #{DOTFILES_PATH}/config/peco/config.json #{CONFIG_PATH}/peco/config.json`
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
  zellij
  herdr
  ghostty
  claude
  codex
  peco
end
