source ~/shopify-dotfiles/antigen.zsh

# Load Antigen configurations
antigen init ~/.antigenrc

# Starship prompt
eval "$(starship init zsh)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
#alias code="code-oss"

# Nice colors on Neovim
export COLORTERM="truecolor"

# Basic env vars
export EDITOR=nvim
export TERM=xterm-256color

