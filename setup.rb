#!/usr/bin/ruby
# frozen_string_literal: true

require 'fileutils'
require 'open-uri'
require 'tempfile'
require 'json'

DOTFILES_PATH = "#{ENV['HOME']}/dotfiles"
CONFIG_PATH = ENV['XDG_CONFIG_HOME'] || "#{ENV['HOME']}/.config"

# Each entry is either:
#   - a String: raw URL to a single SKILL.md file
#   - a Hash { repo:, path:, ref: } : a directory in a GitHub repo, copied recursively
CLAUDE_MANAGED_SKILLS = {
  'herdr' => 'https://raw.githubusercontent.com/herdrdev/herdr/master/skills/herdr/SKILL.md',
  'japanese-tech-writing' => 'https://gist.githubusercontent.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d/raw/SKILL.md',
  'cognitive-rhythm-writing' => 'https://gist.githubusercontent.com/k16shikano/eb2929f13ed19c97188393d297be8432/raw/SKILL.md',
  'hunk-review' => 'https://raw.githubusercontent.com/modem-dev/hunk/main/packages/hunk/skills/hunk-review/SKILL.md',
  'grill-me' => { repo: 'mattpocock/skills', ref: 'main', path: 'skills/productivity/grill-me' },
  'grilling' => { repo: 'mattpocock/skills', ref: 'main', path: 'skills/productivity/grilling' }
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

def hunk
  puts 'setup hunk'
  FileUtils.mkdir_p("#{CONFIG_PATH}/hunk")
  `ln -sf #{DOTFILES_PATH}/config/hunk/config.toml #{CONFIG_PATH}/hunk/config.toml`
end

def ghostty
  puts 'setup ghostty'
  FileUtils.mkdir_p("#{CONFIG_PATH}/ghostty")
  `ln -sf #{DOTFILES_PATH}/config/ghostty/config #{CONFIG_PATH}/ghostty/config`
end

def fetch_url(url)
  URI.open(
    url,
    'User-Agent' => 'dotfiles-setup',
    open_timeout: 10,
    read_timeout: 15
  ).read
end

# Recursively lists files under a GitHub repo directory via the contents API.
# Returns an array of { relative_path:, download_url: }.
def github_dir_files(repo, path, ref)
  api_url = "https://api.github.com/repos/#{repo}/contents/#{path}?ref=#{ref}"
  entries = JSON.parse(fetch_url(api_url))

  entries.flat_map do |entry|
    if entry['type'] == 'dir'
      github_dir_files(repo, entry['path'], ref).map do |file|
        file.merge(relative_path: "#{entry['name']}/#{file[:relative_path]}")
      end
    else
      [{ relative_path: entry['name'], download_url: entry['download_url'] }]
    end
  end
end

def write_skill_file(skill_dir, relative_path, content)
  dest_path = File.join(skill_dir, relative_path)
  return true if File.exist?(dest_path) && File.binread(dest_path) == content.b

  FileUtils.mkdir_p(File.dirname(dest_path))
  Tempfile.create(['skill', File.extname(relative_path)], File.dirname(dest_path)) do |tempfile|
    tempfile.binmode
    tempfile.write(content)
    tempfile.close
    FileUtils.mv(tempfile.path, dest_path)
  end
  false
end

def update_claude_skill_from_url(name, url, skill_dir)
  content = fetch_url(url)

  unless content.match?(/^name:\s*["']?#{Regexp.escape(name)}["']?\s*$/)
    warn "skip #{name}: downloaded content has an unexpected skill name"
    return
  end

  up_to_date = write_skill_file(skill_dir, 'SKILL.md', content)
  puts "  #{name}: #{up_to_date ? 'up to date' : 'updated'}"
end

def update_claude_skill_from_dir(name, source, skill_dir)
  files = github_dir_files(source[:repo], source[:path], source[:ref])
  skill_md = files.find { |f| f[:relative_path] == 'SKILL.md' }

  unless skill_md
    warn "skip #{name}: no SKILL.md found under #{source[:path]}"
    return
  end

  skill_md_content = fetch_url(skill_md[:download_url])
  unless skill_md_content.match?(/^name:\s*["']?#{Regexp.escape(name)}["']?\s*$/)
    warn "skip #{name}: downloaded content has an unexpected skill name"
    return
  end

  all_up_to_date = files.reduce(true) do |acc, file|
    content = file[:relative_path] == 'SKILL.md' ? skill_md_content : fetch_url(file[:download_url])
    write_skill_file(skill_dir, file[:relative_path], content) && acc
  end
  puts "  #{name}: #{all_up_to_date ? 'up to date' : 'updated'}"
end

def update_claude_skills
  puts 'check managed claude skills'

  CLAUDE_MANAGED_SKILLS.each do |name, source|
    skill_dir = "#{DOTFILES_PATH}/config/claude/skills/#{name}"

    if source.is_a?(Hash)
      update_claude_skill_from_dir(name, source, skill_dir)
    else
      update_claude_skill_from_url(name, source, skill_dir)
    end
  rescue OpenURI::HTTPError, SocketError, SystemCallError, Timeout::Error, JSON::ParserError => e
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
  hunk
  ghostty
  claude
  codex
  peco
end
