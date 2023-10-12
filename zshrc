#!/bin/zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins-Overview
plugins=( golang git)

if [ ! -f $ZSH/oh-my-zsh.sh ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
fi

source $ZSH/oh-my-zsh.sh
export iterm2_hostname=$(hostname) # hostname -f is slow (fix it)
source $ZSH/plugins/iterm2/iterm2_shell_integration.zsh


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

#解决这个问题用 Ignore insecure directories and continue [y]
# compaudit | xargs chmod g-w
export ARTEMIS_SHUTDOWN_SLEEP_SECONDS=0
alias curl2='curl --http2-prior-knowledge'
export RUN_ENV=development
export UPGRADE_ARTEMIS_CMD=false
export INSTANCE_ID=4
alias top4='ssh admin@192.168.52.114 -p 9090'
alias apmdev='ssh root@10.2.0.171'
alias apmali='ssh root@192.168.69.155'
alias apmali2='ssh root@192.168.56.24'
alias bench1='ssh root@bench -p 9090'
alias k8sudo chown admin:admin /data/go -Rs='ssh root@10.17.7.230 -p 443'
alias gc='git clone '
alias gitclean='git clean -fdx'
alias gg='go get '
go env -w GOPRIVATE="*.luojilab.com"
# go env -w GOSUMDB=off
go env -w GOSUMDB="sum.golang.google.cn"
# go env -w GOPROXY="https://goproxy.cn,direct"
# go env -w GOPROXY=https://goproxy.io,direct
# go env -w GOPROXY=
#go env -w GOPROXY="https://mirrors.luojilab.com/goproxy,https://goproxy.cn,direct"
go env -w GOPROXY="https://goproxy.cn,direct"
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
# brew pin gcc 禁止 gcc upgrade
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.cloud.tencent.com/homebrew-bottles
function gomod(){
    go mod edit -replace=gitlab.luojilab.com/zeroteam/artemis=../../zeroteam/artemis
    go mod edit -replace=gitlab.luojilab.com/zeroteam/common=../../zeroteam/common
    go mod edit -replace=gitlab.luojilab.com/zeroteam/ddns/app/goddns=../../zeroteam/ddns/app/goddns
}
function schedgo(){
    GODEBUG=scheddetail=1,schedtrace=1000  $@
}
alias curljson='curl -H "Content-Type: application/json" '

function crc32(){
    php -r "echo crc32($1),PHP_EOL;"
}
function crc(){
    echo "`php -r \"echo crc32($1),PHP_EOL;\"`%100"|bc
}
json_escape () {
     php -r 'echo json_encode(file_get_contents("php://stdin"));'
}
alias urldecode='python -c "import sys, urllib.parse as ul ;print(\"\n\") ;print (ul.unquote(sys.argv[1]));"'
alias urlencode='python -c "import sys, urllib.parse as ul ;print(ul.quote(sys.argv[1]));"'

if [ -f ~/.zshrc_local ]; then
   .  ~/.zshrc_local
else
    touch  ~/.zshrc_local
fi

alias en="ec -nw"
alias e="ec"
alias mitp="mitmproxy -p 8888 "
# go tool dist list
alias linuxgo='GOOS=linux GOARCH=amd64 go'
alias linuxgob='GOOS=linux GOARCH=amd64 go build -ldflags "-s -w"'
alias macgo='GOOS=darwin GOARCH=amd64 go build -ldflags "-s -w"'
alias wingo='GOOS=windows GOARCH=amd64 go'
alias src='pushd $GOPATH/src/gitlab.luojilab.com/'
# alias dev='ssh root@192.168.0.69 -p 2222'
alias iostat="iostat -d -k -x 1 100"
alias vmstat="vmstat 1 100"

alias tumx='TERM=screen-256color tmux'
ta(){
    if [ -n "$TMUX" ]; then
        tmux detach
        # printf '^wd'
    else
        TERM=screen-256color tmux attach||TERM=screen-256color tmux new -A -s $USER
    fi
 }
alias tt=ta
alias tn='TERM=screen-256color tmux new -A -s'
alias tmux='TERM=screen-256color tmux'
bindkey -s '^T' 'ta\n'

alias httpserver="python -m SimpleHTTPServer 8888"
# tmux_porcess_cnt=`pgrep tmux |wc -l`

alias download="pushd ~/Downloads/"
if [ $(uname -s ) = "Linux" ] ; then
    alias eme='sudo emerge -aqv --autounmask-write'
    alias emerge='sudo emerge'
    alias emeu='sudo emerge -auvqDN --with-bdeps=y  @world'
    alias esync='sudo emerge --sync'
    alias emec='sudo emerge -ac'
    alias emes='sudo emerge -aSqv'
    alias env-update="sudo env-update"
    alias etc-update="sudo etc-update"

    alias ls='ls --hyperlink=auto --color=auto  --time-style=+"%m 月%d 日 %H:%M"'
    alias la='ls --hyperlink=auto -a --color=auto  '
    alias ll='ls -lth --hyperlink=auto --color=auto --time-style=+"%m 月%d 日 %H:%M" --hyperlink=auto'
    # sort by time 倒序
    alias llr='ls -lrth --hyperlink=auto --color=auto --time-style=+"%m 月%d 日 %H:%M" --hyperlink=auto'
    # sort by time
    alias lla='ls -alth --hyperlink=auto --color=auto --time-style=+"%m 月%d 日 %H:%M" --hyperlink=auto'
    # sort by size
    alias lls='ls -lSh --hyperlink=auto --color=auto --time-style=+"%m 月%d 日 %H:%M" --hyperlink=auto'
    # sort by name
    alias lln='ls -lh --hyperlink=auto --color=auto --time-style=+"%m 月%d 日 %H:%M" --hyperlink=auto'
else
    #-v  http:/lujun.info/2012/10/osx-%E7%9A%84-iterm2%E4%B8%AD%E6%98%BE%E7%A4%BA%E4%B8%AD%E6%96%87%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F/

    # -G color
    alias ls='ls -Gv '
    alias la='ls -aGvv'
    #  -t 按时间排 时间最近的在前面 ,加-r 则反向
    alias ll='ls -lthGv'
    alias llr='ls -ltrhGv'
    alias lla='ls -althGv'
    # sort by size
    alias lls='ls -lShGv'
    # default sort by name
    alias lln='ls -lhGv'
    # sort by cpu
    alias topc='top -o cpu'
    # sort by mreg(memory region)
    alias topm='top -o mreg'
    alias gdb='sudo gdb'
    alias ip="ifconfig en0"
    alias dnsclean='sudo killall -HUP mDNSResponder'
    alias "brewi"="brew install --build-from-source"
    alias "tbrewi"="tsocks brew install --build-from-source"
    alias lc='launchctl'
    alias ftpserver='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
    alias ftpserver_stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'
fi
alias chown='chown -R'
alias chmod='chmod -R'
alias sl='ls'
alias mkdir='mkdir -p'
alias cp='cp -r'
alias rm="rm -rf"
alias pp='ps -ef|grep -v grep|grep'
alias su="su -l"
alias v='sudo vim'
alias mount="sudo mount"
alias umount="sudo umount"
alias now="date '+%s'"

function vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
# With vterm_cmd you can execute Emacs commands directly from the shell.
# For example, vterm_cmd message "HI" will print "HI".
# To enable new commands, you have to customize Emacs's variable
# vterm-eval-cmds.
vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}
    vi() {
        if [ $# -gt 0  ]; then
            vterm_cmd find-file "${@:-.}"
        else
            vim
        fi
    }

    say() {
        vterm_cmd message "%s" "$*"
    }
    clear() {
        vterm_printf "51;Evterm-clear-scrollback"
        tput clear
    }
    o() {
        vterm_cmd  "vterm-open-other-window" "${@:-.}"
    }
fi

function k(){
    ps -ef |grep -v grep|grep "$@"|awk '{print $2}'|xargs kill
}
function kk(){
    ps -ef |grep -v grep|grep "$@"|cut -d " " -f 4|xargs kill -9
}
function kkk(){
    ps -ef |grep -v grep|grep "$@"|cut -d " " -f 4|sudo xargs kill -9
}

alias df="df -h"
alias -s html=vi   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
# alias -s rb=vi     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
# alias -s py=vi       # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
alias -s js=vi
alias -s git='git clone '
alias -s c=vi
alias -s java=vi
alias -s txt=vi
alias -s el=ec
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias svnreset='svn revert -R .;for file in `svn status|grep "^ *?"|sed -e "s/^ *? *//"`; do rm $file ; done'

#这样可以使你上面定义的那些 alias 在 sudo 时管用
#http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo #
alias sudo='sudo '
# AUTOPUSHD made cd act like pushd
DIRSTACKSIZE=10
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdsilent              # 跳转时不打印目录信息
setopt pushdminus               # PUSHDMINUS swapped the meaning of cd +1 and cd -1;
# PUSHDSILENT keeps the shell from printing the directory stack each time we do a cd, and PUSHDTOHOME we mentioned earlier:
alias -g ....=" ../../.."
alias -g .....=" ../../../.."
alias -g ...=" ../.."
alias ..="cd .."

# {{{ 关于历史纪录的配置
setopt hist_ignore_all_dups hist_ignore_space # 如果你不想保存重复的历史
#历史纪录条目数量
export HISTSIZE=1000000
#注销后保存的历史纪录条目数量
export SAVEHIST=1000000
#历史纪录文件
setopt share_history # share command history data
setopt hist_ignore_space
export HISTFILE=~/.zsh_history
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE




alias h='history -nr'
alias hist='history -nr 1'
alias hgrep='history -nr 1|grep '

# bindkey "^[r" history-incremental-search-backward
# 用当前命令行下的内容搜索 history,
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end # up
bindkey "^[r" history-incremental-search-backward  # M-r
# 用当前命令行下的内容搜索 history,prefix 匹配
# bindkey \^R history-beginning-search-backward-end  # C-r

bindkey "^[n" down-line-or-history
bindkey "^[p" up-line-or-history


# brew install fzf
# To install useful key bindings and fuzzy completion:
# $(brew --prefix)/opt/fzf/install
if [ `which fzf| grep -c "/fzf" ` -eq 1 ]; then  \
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi




# autoload -U add-zsh-hook
# add-zsh-hook precmd vcs_info_wrapper
# if [ -z "$INSIDE_EMACS" ]; then
# fi
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    # https://github.com/zsh-users/zsh-autosuggestions
    mkdir -p ~/.zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions  >/dev/null 2>&1 &
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh >/dev/null 2>&1 &
fi

# for emacs term.el
HOSTNAME=$(uname -n)
USER=$(whoami)
case $TERM in
    dumb)
        #在 Emacs 终端 中使用 Zsh 的一些设置 及 Eamcs tramp sudo 远程连接的设置
        prompt='%1/ %(!.#.$) '
        unsetopt zle
        unsetopt prompt_cr
        unsetopt prompt_sp
        unsetopt prompt_subst
        # unfunction precmd
        # unfunction preexec
        PS1='$ '
        ;;
    (*xterm*|*rxvt*|(dt|k)term*|*screen*|alacritty*|linux*))
        PROMPT_EOL_MARK="" # 默认是%g 来表示无换行符，改成用空，即隐藏%
        autoload -U add-zsh-hook

        update_cwd(){
            print -Pn "\e]2;$(pwd)\a" #s
        }
        add-zsh-hook precmd update_cwd
        # add-zsh-hook -Uz chpwd ()
        #     print -Pn "\e]2;$(pwd)\a" #s
        # }
        vterm_prompt_end() {
            vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
        }
        setopt prompt_subst
        PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
        ;;
esac

# {{{ 杂项
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS

#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
setopt AUTO_CD


#Emacs 风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char
# {{{ bindkey -L 列出现有的键绑定
# bindkey "" beginning-of-line #这个好像不起作用
bindkey \^H backward-kill-word
bindkey \^Z set-mark-command
bindkey \^U backward-kill-line
bindkey \^M accept-line


function ignore(){}
zle -N ignore
bindkey "7;2~" ignore           # f18  切换输入法 emacs 进入 insert-state 的按键，在 zsh 里忽略此按键

# Alt-r
bindkey "^[x" ignore            # M-x 忽略
# file rename magick
bindkey "^[m" copy-prev-shell-word


autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line


#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
# }}}
# {{{ 行编辑高亮模式
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
# }}}

#显示 path-directories ，避免候选项唯一时直接选中
cdpath="/home"

#进入相应的路径时只要 cd ~xxx
hash -d HIST="$HISTDIR"

if [ $(uname -s ) = "Darwin" ] ; then
    if [ -f /usr/local/Library/Contributions/brew_zsh_completion.zsh ]; then
        ln -s -f /usr/local/Library/Contributions/brew_zsh_completion.zsh ~/.zsh/site-functions/_brew
    fi
fi
# {{{ (光标在行首)补全 "cd "
user-complete(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            zle fzf-cdr-widget
            ;;
        "cd " )                   # TAB + 空格 替换为 "cd ~"
            # zle end-of-line
            zle fzf-cdr-widget
            # zle expand-or-complete
            ;;
        "cd" )                   # TAB + 空格 替换为 "cd ~"
            zle fzf-cdr-widget
            # BUFFER="cd ~"
            # zle end-of-line
            # zle expand-or-complete
            ;;
        " " )                   # 执行上一条命令
            BUFFER="!?"
            zle end-of-line ;;
        "kill " )                   #
            fkill ;;
        "kill" )                   #
            fkill ;;
        "k" )                   #
            fkill ;;
        "kk" )                   #
            fkill -9 ;;
        "lsof" )                   #
            flsof ;;
        "vi " )
            fzf-file-widget ;;
        "e " )
            fzf-file-widget ;;
        * )
            zle expand-or-complete ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete
bindkey "^[[1h" user-complete   # my ctrl-i


function gob(){
    if [ -n "$(go mod tidy 2>&1 )" ]; then go mod tidy -compat=$(go version |cut -d " " -f 3|cut -d "o" -f 2| awk '{split($0,a,"."); print a[1] "." a[2]}'); fi
    go build
}
function goi(){
    if [ -n "$(go mod tidy 2>&1 )" ]; then go mod tidy -compat=$(go version |cut -d " " -f 3|cut -d "o" -f 2| awk '{split($0,a,"."); print a[1] "." a[2]}'); fi
    go install
}


if [ $(uname -s ) = "Linux" ] ; then
    if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
         Hyprland 2>&1 >/tmp/sway.log
    fi
fi