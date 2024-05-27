eval "$(/opt/homebrew/bin/brew shellenv)"

source $(brew --prefix nvm)/nvm.sh

export XDG_CONFIG_HOME="$HOME/.config"

# This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Set the gobrew (go version manager) home
export PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$PATH"
export GOROOT="$HOME/.gobrew/current/go"

# yazi 
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export EDITOR=nvim

# Alias ls for directory colors
alias ls="ls -aG"

export STARSHIP_CONFIG=~/.config/starship/starship.toml

# ~/.zshrc

eval "$(starship init zsh)"
