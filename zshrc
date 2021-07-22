# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM=screen-256color

export PATH="/usr/local/opt/luajit-openresty/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

alias chpf='(){echo -e "\033]1337;SetProfile=$1\a"}'
## ssave history 
HISTFILE=$ZDOTDIR/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

## share history with other zsh
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups

## path string use for cd
setopt AUTO_CD

## completion envitonment variables
setopt AUTO_PARAM_KEYS

## spell check
setopt correct

### Added by Zinit's installer{{{
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk}}}

zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# completions{{{
zinit ice wait'0'; zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit

# to ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# to select tab or arrow keys.
zstyle ':completion:*:default' menu select=1

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
# end of completions}}}

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00ff00,bg=#333,bold,underline"

# fzf utils
cd-fzf-find() {
    local DIR=$(find ./ -path '*/\.*' -name .git -prune -o -type d -print 2> /dev/null | fzf +m)
    if [ -n "$DIR" ]; then
        cd $DIR
    fi
}
alias fd=cd-fzf-find

vim-fzf-find() {
    local FILE=$(find ./ -path '*/\.*' -name .git -prune -o -type f -print 2> /dev/null | fzf +m)
    if [ -n "$FILE" ]; then
        ${EDITOR:-vim} $FILE
    fi
}
alias fv=vim-fzf-find
