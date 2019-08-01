#!/bin/sh

fpath_folder=$HOME/.local/share/zsh/completions

# TODO: check if files have changed before automatically writing them.

# pip completions
pip completion --zsh > "$fpath_folder/_pip"
