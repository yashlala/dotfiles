#!/bin/sh

set -e # exit upon error
# set -o xtrace # print script contents

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
  $installer stow zsh make
fi

if ! [ command -v lf >/dev/null 2>&1 ]; then
  tmp=$(mktemp -d)
  cd "$tmp"
  wget -q 'https://github.com/gokcehan/lf/releases/download/r32/lf-linux-amd64.tar.gz'
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
  mkdir -p ~/.cache
fi

# Some sed implementations don't follow symlinks. So do this first. 
sed -iE 's/nvr -s/nvim/g' ./lf/.config/lf/lfrc
sed -iE 's/trash-put/trash/g' ./lf/.config/lf/lfrc
#sed -iE '/export MANPAGER/d' ./zsh/.config/zsh/zshenv
#sed -i 's/nvim/vim/g' ./zsh/.config/zsh/zshenv
# can't run `sed -i` on symlinks w/ MacOS. 
sed -iE 's/\/code\/bin/\/bin/g' $(realpath ./zsh/.config/zsh/zshenv)

mkdir -p ~/.config/
if command -v stow >/dev/null 2>&1; then
  mkdir -p ~/.ssh ~/.config/nvim ~/.config/lf
  find . -mindepth 1 -maxdepth 1 \( -type d -not -name '.git' \) -print0 \
    | xargs -0 -n 1 basename \
    | xargs stow
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

touch ~/.hushlogin

if [ -x /bin/zsh ]; then 
  echo 'Changing shell to /bin/zsh'
  chsh -s /bin/zsh 
else
  echo '/bin/zsh not available, sticking with bash :('
  printf '\nset -o vi\n' >> ~/.bashrc
fi

echo 'Reload shell to see changes.'
