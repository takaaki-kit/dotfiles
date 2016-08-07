# Created by newuser for 5.2
# 環境変数
export LANG=ja_JP.UTF-8


# Zsh ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
# Zsh 補完

#for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# 補完機能を有効にする
    autoload -Uz compinit
    compinit -u

########################################
# Zsh オプション

    PROMPT='[%n@%~]#'

# ディレクトリ名だけでcdする
    setopt auto_cd

# cd したら自動的にpushdする
    setopt auto_pushd

# 日本語ファイル名を表示可能にする
    setopt print_eight_bit


# 色を使用出来るようにする
    autoload -Uz colors
    colors

#コマンドミスを修正する
    setopt correct

### Aliases ###
# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
    export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
    export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
    export CLICOLOR=true
# 補完候補に色を付ける
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
    autoload -U colors; colors
# 一般ユーザ時
    tmp_prompt="%{${fg[cyan]}%}[%n@%~] %{${reset_color}%}"
    tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
    tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
    tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
    if [ ${UID} -eq 0 ]; then
    tmp_prompt="%B%U${tmp_prompt}%u%b"
    tmp_prompt2="%B%U${tmp_prompt2}%u%b"
    tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%B%U${tmp_sprompt}%u%b"
    fi

    PROMPT=$tmp_prompt    # 通常のプロンプト
    PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#    RPROMPT=$tmp_rprompt  # 右側のプロンプト
    SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
## SSHログイン時のプロンプト
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
#    ;
#
#### Title (user@hostname) ###
#    case "${TERM}" in
#    kterm*|xterm*|)
#    precmd() {
#        echo -ne "\033]0;${USER}@${HOST%%.*}\007"
#    }
#;;
#esac
#
#
#
#

#anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"




# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"


function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history



function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}


alias ssh=~/dev/bin/ssh-host-color
compdef _ssh ~/dev/bin/ssh-host-color=ssh
