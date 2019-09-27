#!/bin/bash

# This script uses rofi to search a user's 'pass' database.
# It decrypts the specified password, then types it via
# xdotool.
#
# When the "--clip" option is provided, this script instead
# saves the password to the xorg clipboard, clearing it
# after 45 seconds.

shopt -s nullglob globstar

clipit=0
if [[ $1 == "--clip" ]]; then
  clipit=1
  shift
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" \
  | rofi -dmenu -p 'pass' )

[[ -n $password ]] || exit

if [[ $clipit -eq 0 ]]; then
  pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } |
    xdotool type --clearmodifiers --file -
else
  pass show -c "$password" 2>/dev/null
fi
