# set core environment variables

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export BROWSER=chromium

# set application environment variables

export SUDO_ASKPASS='/usr/local/bin/ssh-askpass'
export CONDA_CHANGEPS1='false'
export ESCDELAY=15 # used by ncurses
export LESS='-i -R -M -c -z-5'
export GPG_TTY="$(tty)"
export WATCH_INTERVAL=1 # used by `watch`
export FONTCONFIG_PATH=/etc/fonts # see https://askubuntu.com/a/708541

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
export JUPYTERLAB_DIR="$XDG_DATA_HOME/jupyter/lab"
export JUPYTERLAB_WORKSPACES_DIR="$XDG_DATA_HOME/jupyter/lab/workspaces"
export JUPYTERLAB_SETTINGS_DIR="$XDG_CONFIG_HOME/jupyter/lab/user-settings"
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
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
# needed for ~/.zoom folder
export SSB_HOME="$XDG_DATA_HOME/zoom/"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite"
export TIMEWARRIORDB="$XDG_DATA_HOME/timewarrior"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode-oss"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export WINEPREFIX="$XDG_DATA_HOME/wine"

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
