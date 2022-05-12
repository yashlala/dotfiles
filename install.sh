#!/bin/sh -e

echo "This script installs a portable subset of the dotfiles."
echo "You'll have to set up a full installation yourself."
echo 
echo "What's this machine's install command?"
echo "(empty => \"don't install anything\")"
echo -n "> "
read -r installer
if [ -n "$installer" ]; then
  sudo $installer stow zsh
fi

mkdir -p ~/.config/
if command -v stow >/dev/null 2>&1; then
  find . -mindepth 1 -maxdepth 1 -type d -not -name '.git' \
    | xargs -n 1 basename \
    | xargs stow
else
  cp -r ./zsh/.config/zsh ~/.config/zsh
  cp -r ./git/.config/git ~/.config/git
fi

ln -s ~/.config/zsh/zshrc ~/.zshrc
rm ~/.config/zsh/zshrc.d/fasd.zsh ~/.config/zsh/zshrc.d/keychain.zsh

if [ -x /bin/zsh ]; then 
  chsh -s /bin/zsh 
else
  echo "\nset -o vi" > ~/.bashrc
fi

echo "Reload shell to see changes."
