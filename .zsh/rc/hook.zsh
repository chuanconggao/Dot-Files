PREPROMPT=$'%(!.%{\e[31m%}.%{\e[32m%})%n%{\e[0m%}'
if [[ $TMUX == "" && ( $SSH_CLIENT != "" || $SSH_TTY != "" ) ]]; then
    PREPROMPT+=$'@%{\e[35m%}%m%{\e[0m%}'
fi

function myprecmd() {
    local exitCode=$?

    local exitStatus=""

    if [[ $exitCode -ne 0 ]]; then
        exitStatus+=$'\e[4;91mExit Code\e[0m: '$exitCode"; "
    fi

    if [[ $timer ]]; then
        local duration=$(($SECONDS - $timer))
        if [ ${duration} -gt 10 ]; then
            exitStatus+=$'\e[4;90mRunning Time\e[0m: '${duration}"s; "
        fi
        unset timer
    fi

    if [[ $exitStatus ]]; then
        print "\e[1;90m<<<\e[0m "$exitStatus
    fi

    print -Pn "\e]2; %~ \a"

    local pwdPrompt=" "$(~/.zsh/rc/pwd.py)

    local attrPrompt=" ("

    if [[ $OSTYPE == "darwin"* ]]; then
        local tags=$(tag -N . | tr ',' '|')
        if [[ $tags != "" ]]; then
            attrPrompt+=$'\e[47;30m'$tags$'\e[0m, '
        fi
    fi

    local items=(*(N))
    local hiddenItems=(.*(N))
    local itemNum=${#items}
    if [[ ${#hiddenItems} -gt 0 ]]; then
        itemNum+=$'%{\e[1;36m%}*%{\e[0m%}'
    fi
    attrPrompt+=$itemNum$' \e[90mitems\e[0m'

    attrPrompt+=")"

    local dirPrompt=$(~/.zsh/rc/dir.py)
    if [[ $dirPrompt != "" ]]; then
        dirPrompt=" {"$dirPrompt"}"
    fi

    local venvPrompt=""
    if [[ $VIRTUAL_ENV != "" ]]; then
        venvPrompt=$' <'$'%{\e[31m%}'$(basename $VIRTUAL_ENV)$'%{\e[0m%}>'
    fi

    local inputPrompt=$'\n%{\e[1;90m%}>>>%{\e[0m%} '

    PROMPT=$PREPROMPT$pwdPrompt$attrPrompt$dirPrompt$venvPrompt$inputPrompt
}
if [[ -z $precmd_functions[myprecmd] ]]; then
    precmd_functions+=myprecmd;
fi

function mypreexec() {
    local currentTime=$(date +'%a %I:%M:%S %p')
    local paddingSize=$(($COLUMNS - ${#currentTime} - 2))
    print "\e[1A""\e[${paddingSize}C""[\e[90m$currentTime\e[0m]"

    timer=$SECONDS
}
if [[ -z $preexec_functions[mypreexec] ]]; then
    preexec_functions+=mypreexec;
fi
