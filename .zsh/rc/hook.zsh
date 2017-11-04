function myprecmd() {
    local exitCode=$?
    if [[ $exitCode -ne 0 && $timer ]]; then
        print "\e[1;90m<<<\e[0m \e[4;91mExit Code\e[0m: $exitCode"
    fi

    print -Pn "\e]2; %~ \a"

    if [ $timer ]; then
        local timer_show=$(($SECONDS - $timer))
        if [ ${timer_show} -gt 10 ]; then
            print "\e[1;90m<<<\e[0m \e[4;90mRunning Time\e[0m: ${timer_show}s"
        fi
        unset timer
    fi

    local userPrompt=$'%(!.%{\e[31m%}.%{\e[32m%})%n%{\e[0m%}@%{\e[35m%}%m%{\e[0m%}'

    local pwdPrompt=" "$(~/.zsh/rc/pwd.py)

    local attrPrompt=" ("

    if [[ $OSTYPE == "darwin"* ]]; then
        local tags=$(mdls -name kMDItemUserTags -raw . | sed -e '1d; $d; s/^\s\+/'$'\e[47;30m''/; s/,/'$'\e[0m''/' | paste -d '+' -s)
        if [[ $tags != "" ]]; then
            attrPrompt+=$tags$'\e[0m, '
        fi
    fi

    local items=(*(N))
    local hiddenItems=(.*(N))
    local itemNum=${#items}
    if [[ ${#hiddenItems} -gt 0 ]]; then
        itemNum+=$'%{\e[1;36m%}*%{\e[0m%}'
    fi
    attrPrompt+=$itemNum$' \e[90mitems\e[0m'

    local readmeFile=$(print {readme,readme.*}(.N))
    if [[ $readmeFile != "" ]]; then
        attrPrompt+=": "$readmeFile
    fi

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

    PROMPT=$userPrompt$pwdPrompt$attrPrompt$dirPrompt$venvPrompt$inputPrompt
}
if [[ -z $precmd_functions[myprecmd] ]]; then
    precmd_functions+=myprecmd;
fi

function mypreexec() {
    local currentTime=$(date +'%a %I:%M:%S %p')
    local paddingSize=$(($COLUMNS - ${#${(%)currentTime}} - 2))
    print "\e[1A""\e[${paddingSize}C""[\e[90m$currentTime\e[0m]"

    timer=${timer:-$SECONDS}
}
if [[ -z $preexec_functions[mypreexec] ]]; then
    preexec_functions+=mypreexec;
fi
