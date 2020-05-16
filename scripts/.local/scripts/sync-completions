#!/bin/sh -e

fpath_folder=$HOME/.local/share/zsh/completions

# TODO: check if files have changed before automatically writing them.

update () { 
  temp=$(mktemp)
  eval $2 >"$temp"
  if cmp -s "$temp" "$fpath_folder/$1"; then 
    cp -f "$temp" "$fpath_folder/$1"
  fi
  rm "$temp"
}

# pip completions
update _pip 'pip completion --zsh'
