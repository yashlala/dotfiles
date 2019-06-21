#
# ~/.config/zsh/.zshrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# configure prompt
PS1='%B[%c %(?..%F{black})%#%F{fg}]%f%b '

# configure history
setopt appendhistory histignoredups histignorespace

# configure interface
setopt nobeep extendedglob interactivecomments ignore_eof


# enable and configure help module
autoload -Uz run-help
unalias run-help
alias help=run-help

# source key bindings 
source $HOME/.config/zsh/zshkeybinds

# source aliases
source $HOME/.config/zsh/zshaliases

# source and configure autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source and configure highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zshhighlighting

# *lastly*, enable and configure completion module
autoload -Uz compinit
compinit
setopt nocomplete_aliases
