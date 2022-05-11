#!/bin/sh -e

echo "What's the install command?"
echo "(empty => \"don't install anything\")"

read -r installer
if [ -n "$installer" ]; do 
  sudo $installer stow zsh
done

find . -mindepth 1 -maxdepth 1 -type d -not -name '.git' \
  | xargs -n 1 basename \
  | xargs stow

rm ~/.config/zsh/zshrc.d/fasd.zsh ~/.config/zsh/zshrc.d/keychain.zsh

chsh -s /bin/zsh 
