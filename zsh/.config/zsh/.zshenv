# set core environment variables

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export BROWSER=firefox

# add entries to PATH if they're not there already
function prepend_path { 
  if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)"; then
    export PATH="$1:$PATH"
  fi
}

prepend_path "$HOME/code/bin"
unset prepend_path

# set application environment variables

export RANGER_LOAD_DEFAULT_RC="FALSE"
export ESCDELAY=15 # used by ncurses
export CONDA_CHANGEPS1='false'

# change application config and data locations

# some apps only adhere to the standard if we make these explicit
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export ASPELL_CONF="per-conf $HOME/.config/aspell/config;home-dir $HOME/.local/share/aspell"
export CGDB_DIR="$HOME/.local/share/cgdb"
export ELINKS_CONFDIR="$HOME/.local/share/elinks"
export GNUPGHOME="$HOME/.local/share/gnupg"
# needed for bash, sh, etc.
export HISTFILE="$HOME/.local/share/zsh/histfile"
# needed for GNU Readline
export INPUTRC="$HOME/.config/readline/inputrc"
export IPYTHONDIR="$HOME/.local/share/ipython"
export NETHACKOPTIONS="$HOME/.config/nethack/nethackrc"
export NOTMUCH_CONFIG="$HOME/.config/notmuch/notmuchrc"
# needed for pass
export PASSWORD_STORE_DIR="$HOME/.local/passwords"
# needed for python interactive interpreter
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"
# needed for openssl-rand PRNG
export RANDFILE="$HOME/.local/share/openssl/rnd"
# needed for ~/.zoom folder
export SSB_HOME="$HOME/.local/share/zoom/"
export WEECHAT_HOME="$HOME/.config/weechat"
