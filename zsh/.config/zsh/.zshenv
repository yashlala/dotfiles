# set core environment variables
export PATH="$HOME/code/bin:$PATH"
export EDITOR=vim
export VISUAL=vim

# set application environment variables

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
