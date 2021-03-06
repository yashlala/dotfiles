# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# convenience variables, for internal use
zshconfigdir="$HOME/.config/zsh"
zshdatadir="$HOME/.local/share/zsh"

PROMPT="%B[%c %(?..%F{black})%#%F{fg}]%f%b "
RPROMPT='%(?..%F{black}%B%?%b%F{fg})'

# configure history
HISTFILE="$zshdatadir/histfile"
SAVEHIST=3000 # history file size
HISTSIZE=3000 # history scrolling memory buffer size
setopt appendhistory
setopt histsavenodups histfindnodups
setopt histreduceblanks
setopt histignorespace

# configure user interface
setopt nobeep

# configure completions
fpath=("$zshdatadir/completions" $fpath)
setopt nocomplete_aliases completeinword
zstyle ':completion:*' menu select

# configure jobs
setopt notify longlistjobs

# configure help module
autoload -Uz run-help
unalias run-help
alias help=run-help

# source zle configuration
source "$zshconfigdir/zshzle"

# source zsh aliases, functions, and function definitions
source "$zshconfigdir/zshaliases"

# source all drop-in config files.
# all files should use the convenience variables provided
# above ($zshconfigdir, etc) when required.
for file in "$zshconfigdir/zshrc.d/"*; do
  source "$file"
done

# *lastly*, enable zsh completion module
autoload -Uz compinit
compinit

# unset convenience variables
unset zshconfigdir
unset zshdatadir
