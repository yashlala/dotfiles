#
# ~/.config/zsh/.zshrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# configure prompt
PS1='%B[%c %(?..%F{black})%#%F{fg}]%f%b '

# configure history
HISTFILE=$HOME/.local/share/zsh/histfile
HISTSIZE=6000
SAVEHIST=5000
HISTORY_IGNORE='(q(uit)?|l[sal]( +[^|]*)?|lkj|git st)'
setopt histignoredups histignorespace
setopt appendhistory share_history histexpiredupsfirst

# configure user interface
setopt nobeep ignore_eof

# configure completions
fpath=($HOME/.local/share/zsh/completions $fpath)
setopt nocomplete_aliases completeinword
zstyle ':completion:*' menu select

# configure shell syntax
setopt extendedglob

# configure jobs
setopt notify longlistjobs

# enable and configure help module
autoload -Uz run-help
unalias run-help
alias help=run-help

# source zle key bindings
source $HOME/.config/zsh/zshkeybinds

# source aliases
source $HOME/.config/zsh/zshaliases

# source 'z' movement utility
test -r '/usr/share/z/z.sh' && source /usr/share/z/z.sh

# source and configure zsh autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# *lastly*, enable and configure zsh completion module
autoload -Uz compinit
compinit

# *lastly*, source and configure zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zshhighlighting
