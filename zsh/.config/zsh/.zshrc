#
# ~/.config/zsh/.zshrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# configure prompt
export PS1='%B[%c %(?..%F{black})%#%F{fg}]%f%b '

# configure history
setopt appendhistory histignoredups histignorespace

# configure interface
setopt nobeep extendedglob interactivecomments ignore_eof

eval $(keychain --noask --quiet --quick --absolute \
  --dir "${HOME}/.cache/keychain" --eval id_rsa)

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
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source and configure zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zshhighlighting

# *lastly*, enable and configure zsh completion module
autoload -Uz compinit
compinit
setopt nocomplete_aliases
