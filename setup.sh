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

