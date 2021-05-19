#!/bin/zsh
#解决这个问题用Ignore insecure directories and continue [y]
# compaudit | xargs chmod g-w
export INSTANCE_ID=4
alias bench1='ssh root@bench -p 9090'
alias k8s='ssh root@10.17.7.230 -p 443'
alias gc='git clone '
alias gitclean='git clean -fdx'
alias gg='go get '
# go env -w GOPROXY=http://goproxy.test.svc.luojilab.dc,https://goproxy.io,direct
export GOPRIVATE="*.luojilab.com"
go env -w GOSUMDB=off
go env -w GOPROXY=https://goproxy.io,direct
# go env -w GOPROXY=
# go env -w GOPROXY=http://goproxy.test.svc.luojilab.dc,https://goproxy.io,direct
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
# brew pin gcc 禁止gcc upgrade
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.cloud.tencent.com/homebrew-bottles
function gomod(){
go mod edit -replace=gitlab.luojilab.com/zeroteam/artemis=../../zeroteam/artemis
go mod edit -replace=gitlab.luojilab.com/zeroteam/common=../../zeroteam/common
go mod edit -replace=gitlab.luojilab.com/zeroteam/ddns/app/goddns=../../zeroteam/ddns/app/goddns

}

# cd "$(brew --repo)" && git remote set-url origin https://github.com/Homebrew/brew.git

#
# cd "$(brew --repo)"; git remote set-url origin https://mirrors.cloud.tencent.com/homebrew/brew.git/
# cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" ;git remote set-url origin https://mirrors.cloud.tencent.com/homebrew/homebrew-core.git/

# cd "$(brew --repo)"; git remote set-url origin https://github.com/Homebrew/brew.git
# cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" ;git remote set-url origin https://github.com/Homebrew/homebrew-core.git

function schedgo(){
    GODEBUG=scheddetail=1,schedtrace=1000  $@
}
alias ggu='go get -u '
alias curljson='curl -H "Content-Type: application/json" '

function crc32(){
    php -r "echo crc32($1),PHP_EOL;"
}
json_escape () {
     php -r 'echo json_encode(file_get_contents("php://stdin"));'
}
alias urldecode='python -c "import sys, urllib as ul ;print \"\n\" ;print ul.unquote(sys.argv[1]);"'
alias urlencode='python -c "import sys, urllib as ul ;print ul.quote(sys.argv[1]);"'
# python -c "import sys, urllib as ul;  ;print ul.quote(sys.stdin.read());"
# brew install pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1;
    # https://github.com/davidparsson/zsh-pyenv-lazy/blob/master/pyenv-lazy.plugin.zsh
    # lazy load pyenv and python ,以加快启动速度
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv-init -)"
        pyenv $@
    }
    function python() {
        unset -f python
        pyenv activate env-3.6.8  2>/dev/null;
        python $@
    }
fi


if [ -f ~/.zshrc_local ]; then
   .  ~/.zshrc_local
else
    touch  ~/.zshrc_local
fi

alias enw="en -nw"              # emacs -nw
alias e="en"
# 把当前内容重定向到emacs的一个buffer
# demo: curl baidu.com|e
# demo: e filename
# open files  with emacs or redirect stdio to an emacs buffer
# function e(){
#     if [ -t 0 ]; then
#         #  running interactivelly
#         ec --no-wait $@        >/dev/null  # open file with emacsclient
#     else
#         tmpfile="/tmp/scratch-`/bin/date +%Y-%m-%d_%H-%M-%S`-`uuidgen`"
#         cat  >$tmpfile&& ec --no-wait --eval "(with-current-buffer (switch-to-buffer (generate-new-buffer \"*scratch-*\")) (insert-file-contents \"$tmpfile\")(set-auto-mode) (goto-char (point-min)))">/dev/null
#     fi
# }

# alias s="cat >/tmp/scratch; e --no-wait --eval '(with-current-buffer (switch-to-buffer (generate-new-buffer \"*scratch*\")) (insert-file-contents \"/tmp/scratch\")(set-auto-mode) (goto-char (point-min)))'"
# 把当前内容重定向到emacs的一个buffer并json格式化
# alias js="cat >/tmp/scratch&& e --no-wait --eval '(with-current-buffer (switch-to-buffer (generate-new-buffer \"*scratch-*\")) (insert-file-contents \"/tmp/scratch\") (json-mode )(json-mode-beautify) (goto-char (point-min)))'>/dev/null "
# perl 版
# brew install jsonpp

# alias jsonpretty='json_pp'
# alias jsonpretty='python -m json.tool'
alias mitp="mitmproxy -p 8888 "

# go tool dist list
alias linuxgo='GOOS=linux GOARCH=amd64 go'
alias wingo='GOOS=windows GOARCH=amd64 go'
alias src='pushd $GOPATH/src/gitlab.luojilab.com/'
# alias dev='ssh root@192.168.0.69 -p 2222'
alias iostat="iostat -d -k -x 1 100"
alias vmstat="vmstat 1 100"

alias tget="tsocks wget"
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
alias "brewi"="brew install --build-from-source"
alias "tbrewi"="tsocks brew install --build-from-source"
alias d='sudo docker'
alias da='sudo docker attach --sig-proxy=false'
alias lc='launchctl'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
# tmux_porcess_cnt=`pgrep tmux |wc -l`

alias g=git
alias gst='git status'
alias gbr='git branch'

alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"


# alias tcpinfo='netstat -n | awk "/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}"'
# alias dev12="cd $GOPATH/src/zerogame.info/thserver/thserver&& ./dev.sh 1 2"
alias download="pushd ~/Downloads/"
# ssh通过代理
#alias erl='rlwrap -a  erl'
# alias arp='sudo arp'
# alias mysqld='sudo /etc/init.d/mysql restart'
# alias rr='sudo revdep-rebuild -- keep-going;sudo perl-cleaner --all;lafilefixer --justfixit;sudo python-updater;prelink -amR'
# alias eupdatep='sudo emerge -uvDNp --keep-going world>>/tmp/emerge.log 2>&1 '
# alias eupdatec='sudo emerge -uvDN --keep-going world>>/tmp/emerge.log 2>&1 &!'
# alias eupdate='sudo emerge -uvDN --keep-going world>>/tmp/emerge.log 2>&1'
# alias esync="sudo emerge --sync>>/tmp/emerge.log 2>&1&& sudo layman -S ;sudo eix-update>>/tmp/emerge.log 2>&1"
# alias logout="echo 'awesome.quit()'|awesome-client"
# alias emacsd="sudo /etc/init.d/emacs.$USER restart"
# alias emacsq="emacs -q -debug-init"
# alias sftp="sudo /etc/init.d/proftpd restart"
if [ $(uname -s ) = "Linux" ] ; then
    alias ls='ls --color=auto  --time-style=+"%m月%d日 %H:%M"'
    alias la='ls -a --color=auto  '
    alias ll='ls -lth --color=auto --time-style=+"%m月%d日 %H:%M"'
    # sort by time 倒序
    alias llr='ls -lrth --color=auto --time-style=+"%m月%d日 %H:%M"'
    # sort by time
    alias lla='ls -alth --color=auto --time-style=+"%m月%d日 %H:%M"'
    # sort by size
    alias lls='ls -lSh --color=auto --time-style=+"%m月%d日 %H:%M"'
    # sort by name
    alias lln='ls -lh --color=auto --time-style=+"%m月%d日 %H:%M"'
    alias ip="ifconfig eth0;ifconfig eth1"
else
    #-v  http:/lujun.info/2012/10/osx-%E7%9A%84-iterm2%E4%B8%AD%E6%98%BE%E7%A4%BA%E4%B8%AD%E6%96%87%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F/
    alias ip='ifconfig en0'
    alias ipconfig='ifconfig en0'

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

fi
alias chown='chown -R'
alias chmod='chmod -R'
alias sl='ls'
alias mkdir='mkdir -p'
alias cp='cp -r'
alias rm="rm -rf"
alias srm="sudo rm -rf"
alias lp='ls|less'
alias pp='ps -ef|grep -v grep|grep'
alias su="su -l"
alias "df-h"="df -h"
alias "dfh"="df -h"


# alias s=" rc-service"
# alias rs=" rc-service"
# alias rc-status="sudo rc-status"
# alias rc-update="sudo rc-update"
alias dush="du -sh"

alias v='sudo vim'
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

# alias vi='em'
# pidof vi
function k(){
    ps -ef |grep -v grep|grep "$@"|awk '{print $2}'|xargs kill
}
function kk(){
    ps -ef |grep -v grep|grep "$@"|cut -d " " -f 4|xargs kill -9
}
function kkk(){
    ps -ef |grep -v grep|grep "$@"|cut -d " " -f 4|sudo xargs kill -9
}
# alias k="pkill   -f "
# alias kk="pkill  -9 -f "
# alias kkk="sudo pkill  -9 -f "
#alias drd="sudo drcomd"
# alias net="sudo /etc/init.d/net.eth0 restart"
# alias ifconfig="sudo ifconfig"
# alias route="sudo route"
# alias halt="sync;sudo shutdown -h now"
# alias reboot="sync;sudo reboot"
alias mount="sudo mount"
alias umount="sudo umount"
alias ettercap="sudo ettercap "
# alias env-update="sudo env-update"
# alias etc-update="sudo etc-update"
alias now="date '+%s'"
# alias dat="date +%Y-%m-%d_%H:%M-%A.%z"

#export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] "
#export PS1="\[\e[01;32m\]\u\[\e[01;34m\] \W \$\[\e[00m\] "

# alias net="sudo rm /var/lib/dhcpcd/dhcpcd-eth0.lease;sudo /etc/init.d/net.eth0 restart"
alias df="df -h"
# alias light="echo -n 40|sudo tee /proc/acpi/video/VGA/LCD/brightness"
# alias du="du -sh"
# }}}
alias -s html=vi   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
# alias -s rb=vi     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
# alias -s py=vi       # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
alias -s js=vi
alias -s c=vi
alias -s java=vi
alias -s txt=vi
alias -s el=ec
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias svnreset='svn revert -R .;for file in `svn status|grep "^ *?"|sed -e "s/^ *? *//"`; do rm $file ; done'
alias ftpserver='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias ftpserver_stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

#这样可以使你上面定义的那些alias 在sudo 时管用
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
alias cd..="cd .."
alias d='dirs -v | head -10'
alias 0='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias cd1='cd -'
alias cd2='cd -2'
alias cd3='cd -3'
alias cd4='cd -4'
alias cd5='cd -5'
alias cd6='cd -6'
alias cd7='cd -7'
alias cd8='cd -8'
alias cd9='cd -9'
alias cdd="pushd"

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
# 用当前命令行下的内容搜索history,
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end # up
bindkey "^[r" history-incremental-search-backward  # M-r
# 用当前命令行下的内容搜索history,prefix匹配
# bindkey \^R history-beginning-search-backward-end  # C-r

bindkey "^[n" down-line-or-history
bindkey "^[p" up-line-or-history

function copy-line-as-kill () {
 zle kill-line
 print -rn $CUTBUFFER | clipcopy 2>/dev/null
}
zle -N copy-line-as-kill
bindkey '^k' copy-line-as-kill

# https://github.com/zsh-users/zsh-history-substring-search
# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' history-substring-search-down
# bindkey -M emacs '^R' history-substring-search-up  # C-r
# HISTORY_SUBSTRING_SEARCH_FUZZY='true'

if [ -f ~/.zaw/zaw.zsh  ] ; then
    . ~/.zaw/zaw.zsh
    bindkey -M emacs '^R' zaw-history  # C-r
    bindkey -M emacs '^O' zaw-open-file  # C-O

    # autoload -U filter-select; filter-select -i
    # to initialize `filterselect` keymap and then do like::
   bindkey -M filterselect '^E' accept-search       # # anythins.el 的ctrl-z
   bindkey -M filterselect "^[[1m" accept-line # itermbind后的c-m
   bindkey -M filterselect "^[h" backward-kill-word # itermbind后的M-h
   bindkey -M filterselect "^[[1a" backward-kill-word # itermbind后的C-del
   bindkey -M filterselect "^[^?" backward-kill-word # itermbind后的M-del
   bindkey -M filterselect "^[[109;5u" accept-line # itermbind

   zstyle ':filter-select:highlight' matched fg=yellow,standout
   # zstyle ':filter-select' case-insensitive yes # enable case-insensitive search

   # extended-search:
   #     If this style set to be true value, the searching bahavior will be
   #     extended as follows:
   #
   #     ^ Match the beginning of the line if the word begins with ^
   #     $ Match the end of the line if the word ends with $
   #     ! Match anything except the word following it if the word begins with !
   #     so-called smartcase searching
   zstyle ':filter-select' extended-search yes # enable extended search regardless of the case-insensitive style

fi
# fzf
# brew install fzf
# To install useful key bindings and fuzzy completion:
# $(brew --prefix)/opt/fzf/install
if [ `which fzf| grep -c "/fzf" ` -eq 1 ]; then  \
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# ulimit -n 10000 2>/dev/null
# ulimit -n 20000 2>/dev/null


# {{{ color
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval $color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done



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


PROMPT='%(!.%B$RED%n.%B$GREEN%n)@%m$CYAN %2~$(vcs_info_wrapper)%(?..$RED%?)$GREEN%(!.#.$)%(1j.(%j jobs%).) %b'



# for bash
# PS1='\[\033]0;\u@\H:\w\007\]\$ '

# for emacs term.el
HOSTNAME=$(uname -n)
USER=$(whoami)
case $TERM in
    dumb)
        #在 Emacs终端 中使用 Zsh 的一些设置 及Eamcs tramp sudo 远程连接的设置
        prompt='%1/ %(!.#.$) '
        unsetopt zle
        unsetopt prompt_cr
        unsetopt prompt_sp
        unsetopt prompt_subst
        # unfunction precmd
        # unfunction preexec
        PS1='$ '
        ;;
    (*xterm*|*rxvt*|(dt|k)term*|*screen*))
        PROMPT_EOL_MARK="" # 默认是%g来表示无换行符，改成用空，即隐藏%
        autoload -U add-zsh-hook
        add-zsh-hook -Uz chpwd (){
            print -Pn "\e]2;%2~\a" #s
        }
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

#扩展路径
setopt complete_in_word

#禁用 core dumps
limit coredumpsize 0

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char
# {{{ bindkey -L 列出现有的键绑定
# bindkey "" beginning-of-line #这个好像不起作用
bindkey \^H backward-kill-word
bindkey \^Z set-mark-command
bindkey \^U backward-kill-line
bindkey \^M accept-line
bindkey "^[[1h" user-complete   # itermbind后的ctrl-i
bindkey "^[[1m" accept-line     #  itermbind后的c-m


function ignore(){}
zle -N ignore
bindkey "7;2~" ignore           # f18  切换输入法emacs进入insert-state的按键，在zsh里忽略此按键

# Alt-r
bindkey "^[x" ignore            # M-x 忽略
# file rename magick
bindkey "^[m" copy-prev-shell-word

zle -N copybuffer               # 让普通的copybuffer函数变成可绑定
bindkey "^[w" copybuffer # copy当前命令行下的内容

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
# }}}

# {{{ startx
# if [ $(uname -s ) = "Linux" ] ; then
#  if [ ! -f /tmp/.X0-lock  ] ; then
#    startx
#   logout
#  fi
# fi

if [ -f ~/.gentoo/java-env-classpath  ] ; then
   . ~/.gentoo/java-env-classpath
fi


# }}}
# {{{ 路径别名
#进入相应的路径时只要 cd ~xxx
hash -d E="/etc/env.d"
hash -d C="/etc/conf.d"
hash -d I="/etc/rc.d"
hash -d X="/etc/X11"
hash -d HIST="$HISTDIR"
# #export GDK_NATIVE_WINDOWS=true
# export AWT_TOOLKIT=MToolkit
# export _JAVA_AWT_WM_NONREPARENTING=1
# # wmname LG3D

#mkdir /var/tmp/ccache
#mount -o bind /resource/pkg/gentoo/ccache/ /var/tmp/ccache
#export PATH=$PATH:/java/java/android-sdk-linux_86/platform-tools/:/java/java/android-sdk-linux_86/tools/

function dmalloc { eval `command dmalloc -b $*`; }


if [ $(uname -s ) = "Darwin" ] ; then
    if [ -f /usr/local/Library/Contributions/brew_zsh_completion.zsh ]; then
        ln -s -f /usr/local/Library/Contributions/brew_zsh_completion.zsh ~/.zsh/site-functions/_brew
    fi
fi

# {{{ 自动补全功能
#setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE
#横向排列
setopt  LIST_ROWS_FIRST

autoload -U compinit
compinit


#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*' verbose yes
#指定使用菜单,select表示会高亮选中当前在哪个选项上,no=5表示当候选项大于5时就不自动补全
#而仅仅是列出可用的候选项,这样可以手动输入内容后过滤掉一部分
#也就是说只有少于5个选项的时候而循环选中每一个
#yes=long表示当无法完整显示所有内容时,可以循环之
# zstyle ':completion:*' menu select no=8 yes=long
zstyle ':completion:*' menu select no=5
#force-list表示尽管只有一个候选项,也更出菜单,没必要
#zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'



zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

#彩色补全菜单
#eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
if [[ "$OSTYPE" = solaris* ]]; then
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm"
else
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
fi

# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric


#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

#补全 ssh scp sftp 等
my_accounts=(
# deployer,ubuntu
# deployer@{src.najaplus.com,zjh.pro.cn.najaplus.com}, #
# kardinal@linuxtoy.org
# 123@211.148.131.7
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
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

# zsh 显示git 分支信息 begin
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{3}(%F{5}%b%F{3})%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}
# git_sha() {
#     GIT_SHA=$(command git rev-parse --short HEAD 2> /dev/null)
#     echo "%{$fg[green]%}${GIT_SHA}%{$reset_color%}$del"
# }


#PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# set FPATH
# 一些补全的函数 从这里加载
if [ -d /usr/local/share/zsh/site-functions/ ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
    # rm -f ~/.zcompdump; nohup compinit>/dev/null
fi
if [ -d ~/.zsh/site-functions  ]; then
    fpath=(~/.zsh/site-functions $fpath)
    # rm -f ~/.zcompdump; compinit
fi


function _omz_osx_get_frontmost_app() {
  local the_app=$(
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        name of first item of (every process whose frontmost is true)
      end tell
EOF
  )
  echo "$the_app"
}

if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    # https://github.com/zsh-users/zsh-autosuggestions
    mkdir -p ~/.zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions  >/dev/null 2>&1 &
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh >/dev/null 2>&1 &
fi

# clipcopy - Copy data to clipboard
#
# Usage:
#
#  <command> | clipcopy    - copies stdin to clipboard
#
#  clipcopy <file>         - copies a file's contents to clipboard
#
function clipcopy() {
  emulate -L zsh
  local file=$1
  if [[ $OSTYPE == darwin* ]]; then
    if [[ -z $file ]]; then
      pbcopy
    else
      cat $file | pbcopy
    fi
  elif [[ $OSTYPE == cygwin* ]]; then
    if [[ -z $file ]]; then
      cat > /dev/clipboard
    else
      cat $file > /dev/clipboard
    fi
  else
    if (( $+commands[xclip] )); then
      if [[ -z $file ]]; then
        xclip -in -selection clipboard
      else
        xclip -in -selection clipboard $file
      fi
    elif (( $+commands[xsel] )); then
      if [[ -z $file ]]; then
        xsel --clipboard --input
      else
        cat "$file" | xsel --clipboard --input
      fi
    else
      print "clipcopy: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
      return 1
    fi
  fi
}




# clippaste - "Paste" data from clipboard to stdout
#
# Usage:
#
#   clippaste   - writes clipboard's contents to stdout
#
#   clippaste | <command>    - pastes contents and pipes it to another process
#
#   clippaste > <file>      - paste contents to a file
#
# Examples:
#
#   # Pipe to another process
#   clippaste | grep foo
#
#   # Paste to a file
#   clippaste > file.txt
function clippaste() {
  emulate -L zsh
  if [[ $OSTYPE == darwin* ]]; then
    pbpaste
  elif [[ $OSTYPE == cygwin* ]]; then
    cat /dev/clipboard
  else
    if (( $+commands[xclip] )); then
      xclip -out -selection clipboard
    elif (( $+commands[xsel] )); then
      xsel --clipboard --output
    else
      print "clipcopy: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
      return 1
    fi
  fi
}

copybuffer () {
  if which clipcopy &>/dev/null; then
    echo $BUFFER | clipcopy
  else
    echo "clipcopy function not found. Please make sure you have Oh My Zsh installed correctly."
  fi
}


# for golang
##########################################################################################################
# begin of golang
##########################################################################################################
# install in /etc/zsh/zshrc or your personal .zshrc

# gc
prefixes=(5 6 8)
for p in $prefixes; do
	compctl -g "*.${p}" ${p}l
	compctl -g "*.go" ${p}g
done

# standard go tools
compctl -g "*.go" gofmt

# gccgo
compctl -g "*.go" gccgo

# go tool
__go_tool_complete() {
  typeset -a commands build_flags
  commands+=(
    'build[compile packages and dependencies]'
    'clean[remove object files]'
    'doc[run godoc on package sources]'
    'env[print Go environment information]'
    'fix[run go tool fix on packages]'
    'fmt[run gofmt on package sources]'
    'generate[generate Go files by processing source]'
    'get[download and install packages and dependencies]'
    'help[display help]'
    'install[compile and install packages and dependencies]'
    'list[list packages]'
    'mod[modules maintenance]'
    'run[compile and run Go program]'
    'test[test packages]'
    'tool[run specified go tool]'
    'version[print Go version]'
    'vet[run go tool vet on packages]'
  )
  if (( CURRENT == 2 )); then
    # explain go commands
    _values 'go tool commands' ${commands[@]}
    return
  fi
  build_flags=(
    '-a[force reinstallation of packages that are already up-to-date]'
    '-n[print the commands but do not run them]'
    '-p[number of parallel builds]:number'
    '-race[enable data race detection]'
    '-x[print the commands]'
    '-work[print temporary directory name and keep it]'
    '-ccflags[flags for 5c/6c/8c]:flags'
    '-gcflags[flags for 5g/6g/8g]:flags'
    '-ldflags[flags for 5l/6l/8l]:flags'
    '-gccgoflags[flags for gccgo]:flags'
    '-compiler[name of compiler to use]:name'
    '-installsuffix[suffix to add to package directory]:suffix'
    '-tags[list of build tags to consider satisfied]:tags'
  )
  __go_packages() {
      local gopaths
      declare -a gopaths
      gopaths=("${(s/:/)$(go env GOPATH)}")
      gopaths+=("$(go env GOROOT)")
      for p in $gopaths; do
        _path_files -W "$p/src" -/
      done
  }
  __go_identifiers() {
      compadd $(godoc -templates $ZSH/plugins/golang/templates ${words[-2]} 2> /dev/null)
  }
  case ${words[2]} in
  doc)
    _arguments -s -w \
      "-c[symbol matching honors case (paths not affected)]" \
      "-cmd[show symbols with package docs even if package is a command]" \
      "-u[show unexported symbols as well as exported]" \
      "2:importpaths:__go_packages" \
      ":next identifiers:__go_identifiers"
      ;;
  clean)
    _arguments -s -w \
      "-i[remove the corresponding installed archive or binary (what 'go install' would create)]" \
      "-n[print the remove commands it would execute, but not run them]" \
      "-r[apply recursively to all the dependencies of the packages named by the import paths]" \
      "-x[print remove commands as it executes them]" \
      "*:importpaths:__go_packages"
      ;;
  fix|fmt|vet)
      _alternative ':importpaths:__go_packages' ':files:_path_files -g "*.go"'
      ;;
  install)
      _arguments -s -w : ${build_flags[@]} \
        "-v[show package names]" \
        '*:importpaths:__go_packages'
      ;;
  get)
      _arguments -s -w : \
        ${build_flags[@]}
      ;;
  build)
      _arguments -s -w : \
        ${build_flags[@]} \
        "-v[show package names]" \
        "-o[output file]:file:_files" \
        "*:args:{ _alternative ':importpaths:__go_packages' ':files:_path_files -g \"*.go\"' }"
      ;;
  test)
      _arguments -s -w : \
        ${build_flags[@]} \
        "-c[do not run, compile the test binary]" \
        "-i[do not run, install dependencies]" \
        "-v[print test output]" \
        "-x[print the commands]" \
        "-short[use short mode]" \
        "-parallel[number of parallel tests]:number" \
        "-cpu[values of GOMAXPROCS to use]:number list" \
        "-run[run tests and examples matching regexp]:regexp" \
        "-bench[run benchmarks matching regexp]:regexp" \
        "-benchmem[print memory allocation stats]" \
        "-benchtime[run each benchmark until taking this long]:duration" \
        "-blockprofile[write goroutine blocking profile to file]:file" \
        "-blockprofilerate[set sampling rate of goroutine blocking profile]:number" \
        "-timeout[kill test after that duration]:duration" \
        "-cpuprofile[write CPU profile to file]:file:_files" \
        "-memprofile[write heap profile to file]:file:_files" \
        "-memprofilerate[set heap profiling rate]:number" \
        "*:args:{ _alternative ':importpaths:__go_packages' ':files:_path_files -g \"*.go\"' }"
      ;;
  list)
      _arguments -s -w : \
        "-f[alternative format for the list]:format" \
        "-json[print data in json format]" \
        "-compiled[set CompiledGoFiles to the Go source files presented to the compiler]" \
        "-deps[iterate over not just the named packages but also all their dependencies]" \
        "-e[change the handling of erroneous packages]" \
        "-export[set the Export field to the name of a file containing up-to-date export information for the given package]" \
        "-find[identify the named packages but not resolve their dependencies]" \
        "-test[report not only the named packages but also their test binaries]" \
        "-m[list modules instead of packages]" \
        "-u[adds information about available upgrades]" \
        "-versions[set the Module's Versions field to a list of all known versions of that module]:number" \
        "*:importpaths:__go_packages"
      ;;
  mod)
      typeset -a mod_commands
      mod_commands+=(
        'download[download modules to local cache]'
        'edit[edit go.mod from tools or scripts]'
        'graph[print module requirement graph]'
        'init[initialize new module in current directory]'
        'tidy[add missing and remove unused modules]'
        'vendor[make vendored copy of dependencies]'
        'verify[verify dependencies have expected content]'
        'why[explain why packages or modules are needed]'
      )
      if (( CURRENT == 3 )); then
          _values 'go mod commands' ${mod_commands[@]} "help[display help]"
          return
      fi
      case ${words[3]} in
      help)
        _values 'go mod commands' ${mod_commands[@]}
        ;;
      download)
        _arguments -s -w : \
          "-json[print a sequence of JSON objects standard output]" \
          "*:flags"
        ;;
      edit)
        _arguments -s -w : \
          "-fmt[reformat the go.mod file]" \
          "-module[change the module's path]" \
          "-replace[=old{@v}=new{@v} add a replacement of the given module path and version pair]:name" \
          "-dropreplace[=old{@v}=new{@v} drop a replacement of the given module path and version pair]:name" \
          "-go[={version} set the expected Go language version]:number" \
          "-print[print the final go.mod in its text format]" \
          "-json[print the final go.mod file in JSON format]" \
          "*:flags"
        ;;
      graph)
        ;;
      init)
        ;;
      tidy)
        _arguments -s -w : \
          "-v[print information about removed modules]" \
          "*:flags"
        ;;
      vendor)
        _arguments -s -w : \
          "-v[print the names of vendored]" \
          "*:flags"
        ;;
      verify)
        ;;
      why)
        _arguments -s -w : \
          "-m[treats the arguments as a list of modules and finds a path to any package in each of the modules]" \
          "-vendor[exclude tests of dependencies]" \
          "*:importpaths:__go_packages"
        ;;
      esac
      ;;
  help)
      _values "${commands[@]}" \
        'environment[show Go environment variables available]' \
        'gopath[GOPATH environment variable]' \
        'packages[description of package lists]' \
        'remote[remote import path syntax]' \
        'testflag[description of testing flags]' \
        'testfunc[description of testing functions]'
      ;;
  run)
      _arguments -s -w : \
          ${build_flags[@]} \
          '*:file:_files -g "*.go"'
      ;;
  tool)
      if (( CURRENT == 3 )); then
          _values "go tool" $(go tool)
          return
      fi
      case ${words[3]} in
      [568]g)
          _arguments -s -w : \
              '-I[search for packages in DIR]:includes:_path_files -/' \
              '-L[show full path in file:line prints]' \
              '-S[print the assembly language]' \
              '-V[print the compiler version]' \
              '-e[no limit on number of errors printed]' \
              '-h[panic on an error]' \
              '-l[disable inlining]' \
              '-m[print optimization decisions]' \
              '-o[file specify output file]:file' \
              '-p[assumed import path for this code]:importpath' \
              '-u[disable package unsafe]' \
              "*:file:_files -g '*.go'"
          ;;
      [568]l)
          local O=${words[3]%l}
          _arguments -s -w : \
              '-o[file specify output file]:file' \
              '-L[search for packages in DIR]:includes:_path_files -/' \
              "*:file:_files -g '*.[ao$O]'"
          ;;
      dist)
          _values "dist tool" banner bootstrap clean env install version
          ;;
      *)
          # use files by default
          _files
          ;;
      esac
      ;;
  esac
}

compdef __go_tool_complete go

# aliases: go<~>
alias gob='go build'
alias goc='go clean'
alias god='go doc'
alias gof='go fmt'
alias gofa='go fmt ./...'
alias gog='go get'
alias goi='go install'
alias gol='go list'
alias gom='go mod'
alias gop='cd $GOPATH'
alias gopb='cd $GOPATH/bin'
alias gops='cd $GOPATH/src'
alias gor='go run'
alias got='go test'
alias gov='go vet'
##########################################################################################################
# end of golang
##########################################################################################################



export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
