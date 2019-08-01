# set core environment variables
export PATH=$HOME/code/bin:$PATH
export EDITOR=vim
export VISUAL=vim

# set shell environment variables
export fpath=($HOME/.local/share/zsh/completions $fpath)
export HISTFILE=$HOME/.local/share/zsh/histfile
export HISTSIZE=5000
export SAVEHIST=5000

# set application environment variables
export _Z_CMD='f'
export _Z_EXCLUDE_DIRS=('/tmp')
export _Z_NO_RESOLVE_SYMLINKS=true

# change application config and data locations
export PYTHONSTARTUP=$HOME/.config/python/pythonrc
export NETHACKOPTIONS=$HOME/.config/nethack/nethackrc
export GNUPGHOME=$HOME/.local/share/gnupg
export WEECHAT_HOME=$HOME/.config/weechat
export PASSWORD_STORE_DIR=$HOME/.local/passwords
export INPUTRC=$HOME/.config/readline/inputrc
export _Z_DATA=$HOME/.cache/z-cache
