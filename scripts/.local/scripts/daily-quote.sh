#!/bin/sh -e

# Prints a quote to stdout once per day. 

# TODO: make these quotes more inspirational/whimsical. 

cache_file="$HOME/.cache/daily-quote/last-visited"

if [ -e "$cache_file" ]; then 
  last_date=$(cat "$cache_file")
else
  last_date="never"
  mkdir -p "$(dirname "$cache_file")"
fi

if [ $(date -I) != "$last_date" ]; then
  # don't consolidate the slowtypes; it changes the end-of-phrase delay. 
  echo "Good Morning!" | slowtype
  echo -e "Here's a quote just for you:\n" | slowtype
  sleep 0.3
  { fortune -s -n 250; echo; } | slowtype
  sleep 0.3
  echo "Have a nice day!" | slowtype
  sleep 0.3

  date -I >"$cache_file"
fi
