#
# ~/.config/zsh/.zshrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# configure history
setopt appendhistory histignoredups histignorespace

# configure interface
setopt nobeep extendedglob

# enable and configure completion module
autoload -Uz compinit
compinit
setopt nocomplete_aliases

# enable and configure help module
autoload -Uz run-help
unalias run-help
alias help=run-help

# source key bindings 
source $HOME/.config/zsh/zshinterface

# source aliases
source $HOME/.config/zsh/zshaliases

# source and configure autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
