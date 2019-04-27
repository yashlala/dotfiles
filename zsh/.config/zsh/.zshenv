# set core environment variables
export PATH=$HOME/code/bin:$PATH
export CDPATH=.:$HOME
export EDITOR=vim
export VISUAL=vim

# set shell environment variables
export fpath=($HOME/.local/share/zsh/completions $fpath)
export HISTFILE=$HOME/.local/share/zsh/histfile
export HISTSIZE=5000
export SAVEHIST=5000

# set application environment variables

# change application config and data locations
export PYTHONSTARTUP=$HOME/.config/python/pythonrc
export NETHACKOPTIONS=$HOME/.config/nethack/nethackrc 
export GNUPGHOME=$HOME/.local/share/gnupg
export WEECHAT_HOME=$HOME/.config/weechat
export PASSWORD_STORE_DIR=$HOME/.local/share/pass
