# set core environment variables

# add ~/code/bin to PATH if it's not there already
if ! echo "$PATH" \
  | /bin/grep -Eq "(^|:)$HOME/code/bin($|:)"
then
  export PATH="$HOME/code/bin:$PATH"
fi

export EDITOR=vim
export VISUAL=vim
export PAGER=less

# set application environment variables

export RANGER_LOAD_DEFAULT_RC="FALSE"

# change application config and data locations

export GNUPGHOME="$HOME/.local/share/gnupg"
# needed for bash, sh, etc.
export HISTFILE="$HOME/.local/share/zsh/histfile"
# needed for GNU Readline
export INPUTRC="$HOME/.config/readline/inputrc"
export NETHACKOPTIONS="$HOME/.config/nethack/nethackrc"
# needed for pass
export PASSWORD_STORE_DIR="$HOME/.local/passwords"
# needed for python interactive interpreter
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"
export WEECHAT_HOME="$HOME/.config/weechat"
