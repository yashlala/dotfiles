#!/bin/zsh

lf () {
  tmp=$(mktemp)
  command lf -last-dir-path "$tmp"
  cd "$(<"$tmp")"
  rm -f "$tmp"
}
