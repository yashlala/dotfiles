#!/bin/sh -e

echo "This script installs a portable subset of the dotfiles."
echo "You'll have to set up full installations yourself."
echo 
echo "Make sure that you know this user's password!"
echo 
echo "What's this machine's install command?"
echo "(empty => \"don't install anything\")"
echo -n "> "
read -r installer
if [ -n "$installer" ]; then
  sudo $installer stow zsh
fi

if ! [ command -v lf >/dev/null 2>&1 ]; then
  tmp=$(mktemp -d)
  cd "$tmp"
  wget 'https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz'
  tar xzf lf-linux-amd64.tar.gz
  mkdir -p ~/bin
  cp lf ~/bin/lf
  cd - 
  rm -rf "$tmp"
fi

mkdir -p ~/.config/
if command -v stow >/dev/null 2>&1; then
  find . -mindepth 1 -maxdepth 1 -type d -not -name '.git' \
    | xargs -n 1 basename \
    | xargs stow
else
  cp -r ./zsh/.config/zsh ~/.config/zsh
  cp -r ./git/.config/git ~/.config/git
  cp ./readline/.config/readline/inputrc ~/.inputrc
  cp ./editline/.config/editline/config ~/.editrc
  mkdir -p ~/.config/lf/lfrc && cp ./lf/.config/lf/lfrc ~/.config/lf/lfrc
fi

ln -s ~/.config/zsh/zshrc ~/.zshrc
ln -s ~/.config/zsh/zshenv ~/.zshenv

test -e ~/.config/lf/lfrc && sed -iE 's/nvr -s/vim/g'
sed -iE '/export MANPAGER/d' ~/.config/zsh/zshenv
sed -i 's/\/code\/bin/\/bin/g' ~/.config/zsh/zshenv
rm ~/.config/zsh/zshrc.d/fasd.zsh \
  ~/.config/zsh/zshrc.d/keychain.zsh \
  ~/.config/zsh/zshrc.d/miniconda.zsh

if [ -x /bin/zsh ]; then 
  echo 'Changing shell to /bin/zsh'
  chsh -s /bin/zsh 
else
  echo '/bin/zsh not available, sticking with bash :('
  printf '\nset -o vi\n' > ~/.bashrc
fi

touch ~/.hushlogin

echo 'Reload shell to see changes.'
