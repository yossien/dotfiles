function mkln {
  if [ -f ${PWD}/$1 ]; then
    ln -s ${PWD}/$1 ~/.$1
  fi
}

mkln gvimrc
mkln vimrc
mkln ideavimrc
mkln zshrc
mkln tmux.conf
mkln p10k.zsh

ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ${pwd}/colors ~/.config/nvim/colors
ln -s ${pwd}/colors ~/.vim/colors

