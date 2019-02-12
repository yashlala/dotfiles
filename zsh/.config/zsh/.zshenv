# set core environment variables
export PATH=$HOME/code/bin:$PATH
export CDPATH=.:$HOME
export EDITOR=nvim
export VISUAL=nvim

# set shell environment variables
HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=5000
SAVEHIST=5000

# speed up zsh vi mode
KEYTIMEOUT=2 

# change application config and data locations
export NETHACKOPTIONS=$HOME/.config/nethack/nethackrc 
export GNUPGHOME=$HOME/.local/share/gnupg
export WEECHAT_HOME=$HOME/.config/weechat
export PASSWORD_STORE_DIR=$HOME/.local/share/pass
