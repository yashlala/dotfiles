#!/bin/zsh

lf () {
  local dir=$(command lf -print-last-dir)
  cd $dir
}
