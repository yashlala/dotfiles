#!/bin/sh

set -e # exit upon error
set -o xtrace # print script contents

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
  wget -q 'https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz'
  tar xzf lf-linux-amd64.tar.gz
  mkdir -p ~/bin
  cp lf ~/bin/lf
  cd - 
  rm -rf "$tmp"
fi

if ! [ command -v fasd >/dev/null 2>&1 ]; then 
  tmp=$(mktemp -d)
  cd "$tmp"
  wget -q 'https://github.com/clvv/fasd/tarball/1.0.1'
  tar xzf 1.0.1
  env PREFIX="$HOME" make -C clvv-fasd-4822024 install
  cd - 
  rm -rf "$tmp"
fi

# Some sed implementations don't follow symlinks. So do this first. 
sed --follow-symlinks -i 's/nvr -s/vim/g' ./lf/.config/lf/lfrc
sed --follow-symlinks -i 's/trash-put/rm -r/g' ./lf/.config/lf/lfrc
sed --follow-symlinks -i '/export MANPAGER/d' ./zsh/.config/zsh/zshenv
sed --follow-symlinks -i 's/nvim/vim/g' ./zsh/.config/zsh/zshenv
sed --follow-symlinks -iE 's/\/code\/bin/\/bin/g' ./zsh/.config/zsh/zshenv

mkdir -p ~/.config/
if command -v stow >/dev/null 2>&1; then
  mkdir -p ~/.ssh
  find . -mindepth 1 -maxdepth 1 \( -type d -not -name '.git' \) -print0 \
    | xargs -0 -n 1 basename -z \
    | xargs -0 stow
else
  mkdir -p ~/.config
  cp -r ./zsh/.config/zsh ~/.config/zsh
  cp -r ./git/.config/git ~/.config/git
  cp ./readline/.config/readline/inputrc ~/.inputrc
  cp ./editline/.config/editline/config ~/.editrc
  cp ./vim/.vimrc ~/.vimrc
  cp -r ./tmux/.config/tmux/ ~/.config/tmux/
  mkdir -p ~/.config/lf && cp ./lf/.config/lf/lfrc ~/.config/lf/lfrc
fi

ln -s ~/.config/zsh/zshrc ~/.zshrc
ln -s ~/.config/zsh/zshenv ~/.zshenv

rm ~/.config/zsh/zshrc.d/keychain.zsh \
  ~/.config/zsh/zshrc.d/miniconda.zsh

touch ~/.hushlogin

if [ -x /bin/zsh ]; then 
  echo 'Changing shell to /bin/zsh'
  chsh -s /bin/zsh 
else
  echo '/bin/zsh not available, sticking with bash :('
  printf '\nset -o vi\n' > ~/.bashrc
fi

echo 'Reload shell to see changes.'
