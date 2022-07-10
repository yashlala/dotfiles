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
ln -s ~/.config/zsh/zshenv ~/.zshenv

sed -iE '/export MANPAGER/d' ~/.config/zsh/zshenv
sed -i 's/\/code\/bin/\/bin/g' ~/.config/zsh/zshenv
rm ~/.config/zsh/zshrc.d/fasd.zsh \
  ~/.config/zsh/zshrc.d/keychain.zsh \
  ~/.config/zsh/zshrc.d/miniconda.zsh

if [ -x /bin/zsh ]; then 
  chsh -s /bin/zsh 
else
  printf '\nset -o vi\n' > ~/.bashrc
fi

touch ~/.hushlogin

echo "Reload shell to see changes."
