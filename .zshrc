typeset -ag precmd_functions
typeset -ag preexec_functions

eval "$(dircolors -b)"
autoload -U colors && colors
zle_highlight=(default:fg=yellow)

autoload -U zmv

fpath=(/usr/local/share/zsh-completions $HOME/.zsh/func $fpath)
typeset -U fpath

autoload -U compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' use-ip on
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:*:*' menu yes select

bindkey -e
bindkey \^U backward-kill-line

bindkey -M menuselect '^[[Z' reverse-menu-complete # SHIFT-TAB
bindkey -M menuselect '\e' send-break # ESC
bindkey -M menuselect '^[' send-break # CTRL-[
bindkey -M menuselect '^M' .accept-line # ENTER

WORDCHARS=$(echo $WORDCHARS | tr -d "/.=_-")
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;'
ZLE_SPACE_SUFFIX_CHARS=$'&|'

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

setopt AUTO_REMOVE_SLASH
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
unsetopt LIST_TYPES

setopt EXTENDED_GLOB
setopt GLOB_STAR_SHORT
setopt NUMERIC_GLOB_SORT
unsetopt CASE_GLOB
unsetopt CASE_MATCH
unsetopt MARK_DIRS

setopt AUTO_CD

setopt MULTIOS

autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

export TIMEFMT="%J %*E time %M mem"

export EDITOR="vim"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export HOMEBREW_NO_ANALYTICS=1

. ~/.zsh/rc/alias.zsh

if [[ $VIRTUAL_ENV != "" ]]; then
    . "$VIRTUAL_ENV/bin/activate"
fi

export AUTOJUMP_KEEP_SYMLINKS=1
. "$(brew --prefix)/etc/profile.d/autojump.sh"

if [[ $OSTYPE == "darwin"* ]]; then
    ssh-add -A > /dev/null 2> /dev/null
fi

eval "$(npm completion)"

eval "$(direnv hook zsh)"
. ~/.zsh/rc/hook.zsh

. ~/.zsh/plugins/zsh-bd/bd.zsh

if [[ $OSTYPE == "darwin"* ]]; then
    . /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    . /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    . /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ $OSTYPE == "linux"* ]]; then
    . ~/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    . ~/.linuxbrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    . ~/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

test -e "${HOME}/.iterm2.zsh" && source "${HOME}/.iterm2.zsh"
