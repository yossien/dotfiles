# xcode tools install

~~~
$ xcode-select --install
~~~

# home brew install

https://brew.sh/index_ja

# fonts

## NesloLGS

https://github.com/romkatv/powerlevel10k/blob/master/font.md

https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf

 * MesloLGS NF Regular.ttf
 * MesloLGS NF Bold.ttf
 * MesloLGS NF Italic.ttf
 * MesloLGS NF Bold Italic.ttf

~~~
$ brew install --cask homebrew/cask-fonts/font-meslo-for-powerline
~~~

## Ricty

### Ricty only

~~~
$ brew install --cask homebrew/cask-fonts/font-ricty-diminished
~~~

### Ricty with PowerLine

~~~
$ brew tap sanemat/font
$ brew install ricty --with-powerline
$ cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
$ fc-cache -vf
~~~


### Nerd-font for non ascii characters

~~~
$ brew tap homebrew/cask-fonts
$ brew install --cask font-hack-nerd-font
~~~


# some tools install by brew

* anyenv
* bottom
* dnsmask
* dust
* exa
* fd
* fzf
* jq
* neovim
* tmux
* bat
* lsd
* glances
* procs
* ripgrep
* zoxide
* wezterm

~~~
$ brew install fzf jq neovim tmux bat lsd glances
~~~

# iterm2 install by brew cask

~~~
$ brew install --cask iterm2
~~~

https://iterm2colorschemes.com


# vundle install for vim

https://github.com/VundleVim/Vundle.vim

~~~
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
~~~

# tpm install for tmux

https://github.com/tmux-plugins/tpm

~~~
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~~~

