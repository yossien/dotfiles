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
mkln wezterm.lua

# install vundle for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle
vim +PluginInstall +qall

# install tpm for tmux
## git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ${PWD}/colors ~/.config/nvim/colors
ln -s ${PWD}/colors ~/.vim/colors

## echo "####### Setup Shell Finished."
## echo "# "
## echo "# to install tmux plugin https://github.com/tmux-plugins/tpm"
## echo "# type (PREFIX + I) on your tmux window"
## echo "# "
## echo "# "

