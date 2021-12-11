# set core environment variables

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export BROWSER=firefox


# set application environment variables

export CONDA_CHANGEPS1='false'
export ESCDELAY=15 # used by ncurses
export LESS='-i -R -M -c -z-5'
export GPG_TTY="$(tty)"

# Use Neovim as a pager. Allows for section overviews. 
export MANPAGER='nvim +Man!'

# change application config and data locations

# some apps only adhere to the standard if we make these explicit
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/config;home-dir $XDG_DATA_HOME/aspell"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CGDB_DIR="$XDG_DATA_HOME/cgdb"
export EDITRC="$XDG_CONFIG_HOME/editline/config"
export ELINKS_CONFDIR="$XDG_DATA_HOME/elinks"
export _FASD_DATA="$XDG_DATA_HOME/fasd"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
# needed for bash, sh, etc.
export HISTFILE="$XDG_DATA_HOME/zsh/histfile"
# needed for GNU Readline
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export IPYTHONDIR="$XDG_DATA_HOME/ipython"
export LESSHISTFILE="$XDG_DATA_HOME/less-history"
export NETHACKOPTIONS="$XDG_CONFIG_HOME/nethack/nethackrc"
export NODE_REPL_HISTORY_FILE="$XDG_CONFIG_HOME/node/repl-history"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuchrc"
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"
export npm_config_cache="$XDG_CACHE_HOME/npm"
# needed for pass
export PASSWORD_STORE_DIR="$HOME/.local/passwords"
# needed for python interactive interpreter
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYLINTHOME="$XDG_DATA_HOME/pylint/"
export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
# needed for openssl-rand PRNG
export RANDFILE="$XDG_DATA_HOME/openssl/rnd"
# needed for ~/.zoom folder
export SSB_HOME="$XDG_DATA_HOME/zoom/"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode-oss"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"



# set PATH

# add entries to PATH if they're not there already
function prepend_path {
  if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)"; then
    export PATH="$1:$PATH"
  fi
}

prepend_path "$HOME/code/bin"
prepend_path "$HOME/.local/share/npm/bin"
prepend_path "$GOPATH/bin"
unset prepend_path 
