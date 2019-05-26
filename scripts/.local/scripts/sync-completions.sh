#!/bin/sh

fpath_folder=$HOME/.local/share/zsh/completions

# TODO: check if files have changed before automatically writing them. 

# cargo completions
if [[ -a $local_cargo ]]; then 
	cp $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/zsh/site-functions/_cargo "$fpath_folder/_cargo"
else
	curl -s https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/_cargo -o "$fpath_folder/_cargo" 
fi

# rustc completions
curl -s https://raw.githubusercontent.com/rust-lang/zsh-config/master/_rust -o "$fpath_folder/_rustc"

# rustup completions
rustup completions zsh > "$fpath_folder/_rustup"

# pip completions
pip completion --zsh > "$fpath_folder/_pip"
