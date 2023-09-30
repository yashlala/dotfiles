# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# convenience variables, for internal use
zshconfigdir="$HOME/.config/zsh"
zshdatadir="$HOME/.local/share/zsh"
mkdir -p "$zshconfigdir" "$zshdatadir" 

# If we're being accessed from a remote machine, change the shell prompt. 
if [[ -n "$SSH_CLIENT" ]]; then
  hostname='%F{blue}%m%F{fg} '
else
  hostname=
fi
PROMPT="%B[${hostname}%c %(?..%F{black})%#%F{fg}]%f%b "
# Prepend the prompt with a horizontal line
PROMPT="%F{gray}\${(r:\$COLUMNS::-:)}%F{fg}$PS1"
# Print the last program's return code, if nonzero
RPROMPT='%(?..%F{black}%B%?%b%F{fg})'
# Enable prompt substitution, needed for $COLUMN 
setopt promptsubst
unset -v hostname

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
setopt nonotify longlistjobs
if tty -s; then 
  stty tostop # suspend bg job on tty output
fi

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
unset -v zshconfigdir
unset -v zshdatadir
