alias less="less -R"
alias more="more -R"

alias ls="ls --color=auto -h"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"
alias rsync="rsync -h"

alias diff="colordiff"
alias svn="colorsvn"

alias dtrx="dtrx -n"

alias py="python"
alias py3="python3"
alias ipython3="ipython"
alias ipy="ipython"
alias ipy3="ipython3"

alias ql="qlmanage -p $@ > /dev/null 2> /dev/null"

alias mkdir="mkdir -p"

alias echo="echo -e"

alias topcpu="top -o -cpu"
alias topmem="top -o -rsize"

alias q="q --disable-escaped-double-quoting"

alias jojo="/usr/local/bin/jo"
alias pythonpy="/usr/local/bin/py"

alias ack="ag"
alias gzip="pigz"
alias gunzip="unpigz"

eval "$(hub alias -s)"
