# dotfiles

abekoh's dotfiles

## Setup

```
cd ~/
git clone https://github.com/abekoh/dotfiles.git
cd dotfiles
./setup.rb
```

## Claude code

in global

```sh
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp
claude mcp add --scope user serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context=claude-code --project-from-cwd
```

## ~/.gitconfig

```
[ghq]
	root = ~/src
[user]
	name = abekoh
  # replace this
	email = abekoh@example.com
[wt]
	basedir = .worktrees
	copy = .env*
	hook = direnv allow .
```
