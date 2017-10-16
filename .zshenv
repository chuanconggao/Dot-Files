export GOPATH="$HOME/.go"
export TEXBINPATH="/Library/TeX/texbin"
export PATH="/usr/local/opt/python/libexec/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$TEXBINPATH:$GOPATH/bin"

export TEXMANPATH="/Library/TeX/Distributions/.DefaultTeX/Contents/man"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/share/man:/usr/share/man:$TEXMANPATH"

export HOMEBREW_GITHUB_API_TOKEN=""

export PYTHONIOENCODING="UTF-8"

. `which env_parallel.zsh`
