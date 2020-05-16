#!/bin/sh -e

cache_file="$HOME/.cache/file-browser/last-visited"

if [ $# -ne 0 ]; then 
  exec ranger "$@"
fi

if [ -e "$cache_file" ]; then 
  last_visited=$(cat "$cache_file")

  if ! [ -e "$last_visited" ]; then 
    last_visited="$HOME"
  fi

else
  mkdir -p "$(dirname "$cache_file")"
  last_visited="$HOME"
fi

exec ranger --choosedir "$cache_file" "$last_visited" "$@"
