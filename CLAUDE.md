# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup and Installation

Initial setup:
```bash
cd ~/
git clone https://github.com/abekoh/dotfiles.git
cd dotfiles
./setup.rb
```

The `setup.rb` script creates symlinks from the repository to appropriate locations in the home directory and `.config` directory.

## Architecture Overview

This is a dotfiles management repository that uses a Ruby script (`setup.rb`) to orchestrate configuration deployment through symlinks. The repository follows the XDG Base Directory specification for config files.

### Key Components

- **setup.rb**: Main orchestration script written in Ruby
  - Each function (e.g., `astronvim`, `zsh`, `git`) handles setup for a specific tool
  - Creates necessary directories and symlinks configuration files
  - Uses `DOTFILES_PATH` (~/dotfiles) and `CONFIG_PATH` ($XDG_CONFIG_HOME or ~/.config)

- **config/**: Contains configuration files for various tools, organized by application
  - `astronvim/`: Neovim configuration using AstroNvim framework (Lua-based)
  - `zsh/`: Zsh shell configuration with sheldon plugin manager
  - `zellij/`: Terminal multiplexer configuration (KDL format)
  - `ghostty/`: Terminal emulator configuration
  - `git/`, `aws/`, `starship/`, etc.: Tool-specific configurations

- **bin/**: Utility scripts symlinked to ~/.local/bin
  - `ansible-to-ssh`, `copy-docker-volume`, `md-replace-url`

- **Brewfile**: Homebrew package definitions for macOS

### Configuration Management Pattern

All tool configurations follow this pattern in setup.rb:
1. Check if command is installed (optional, via `command_installed?`)
2. Create necessary directories with `FileUtils.mkdir_p`
3. Remove existing symlinks if present
4. Create new symlinks from `DOTFILES_PATH/config/<tool>` to appropriate location

## Common Development Commands

### Setup Operations
```bash
# Run full setup (creates all symlinks)
./setup.rb

# Install Homebrew packages
brew bundle --file=Brewfile
```

### AstroNvim (Neovim) Configuration
The Neovim configuration is located in `config/astronvim/` and uses:
- Lazy.nvim as the plugin manager
- Plugin configurations in `lua/plugins/`
- Lock file: `lazy-lock.json`

### Zsh Configuration
Uses sheldon for plugin management:
```bash
# Regenerate sheldon plugins
sheldon lock

# Plugin config: config/zsh/sheldon.plugins.toml
# Main RC: config/zsh/.zshrc
# Sync config: config/zsh/sync.zsh (PATH setup, starship, etc.)
# Async config: config/zsh/async.zsh (deferred loading)
```

### Zellij Configuration
Configuration uses KDL format in `config/zellij/config.kdl`:
- Custom keybindings (Ctrl+y for Move mode, Ctrl+e for Session mode)
- Catppuccin Macchiato theme
- Auto-start setup in .zshrc when using Ghostty terminal

## File Modification Guidelines

When editing configuration files:
- **Ruby files** (setup.rb): Maintain the functional organization pattern. Each tool has its own function that handles directory creation and symlinking.
- **Lua files** (astronvim): Follow the existing AstroNvim structure with separate plugin files in `lua/plugins/`
- **Shell config** (zsh): `sync.zsh` contains synchronously loaded config (PATH, etc.), `async.zsh` for deferred loading
- **Plugin management**: Use sheldon for zsh plugins, defined in `sheldon.plugins.toml`

## Environment Specifics

- Primary OS: macOS (darwin)
- Package manager: Homebrew
- Shell: Zsh with sheldon plugin manager
- Editor: Neovim via AstroNvim
- Terminal: Ghostty with Zellij multiplexer
- Theme: Catppuccin Macchiato (consistent across tools)
