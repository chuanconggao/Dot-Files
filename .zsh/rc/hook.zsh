PREPROMPT=$'%(!.%{\e[31m%}.%{\e[32m%})%n%{\e[0m%}'
if [[ $TMUX == "" && ( $SSH_CLIENT != "" || $SSH_TTY != "" ) ]]; then
    PREPROMPT+=$'@%{\e[35m%}%m%{\e[0m%}'
fi

function myprecmd() {
    local exitCode=$?

    local updatePrompt=""
    if [[ $ENDTIME && $(stat . -c %Z) -ge $ENDTIME ]]; then
        updatePrompt+=$' \e[90m•\e[0m'
    fi

    ENDTIME=$(date +%s.%N)

    local exitStatus=""
    if [[ $STARTTIME ]]; then
        if [[ $exitCode -ne 0 ]]; then
            local exitMessage=""
            case $exitCode in
                1) exitMessage="General";;
                2) exitMessage="Shell";;
                126) exitMessage="Unexecutable";;
                127) exitMessage="Unfound";;
                129) exitMessage="SIGHUP";;
                130) exitMessage="SIGINT";;
                131) exitMessage="SIGQUIT";;
                132) exitMessage="SIGILL";;
                133) exitMessage="SIGTRAP";;
                134) exitMessage="SIGABRT";;
                137) exitMessage="SIGKILL";;
                139) exitMessage="SIGSEGV";;
                141) exitMessage="SIGPIPE";;
                143) exitMessage="SIGTERM";;
                *) exitMessage="Unknown";;
            esac

            exitStatus+=$'\e[4;91mCode\e[0m: '$exitCode" ("$'\e[1;90m'$exitMessage$'\e[0m); '
        fi

        local duration=$(($ENDTIME - $STARTTIME))
        if [[ ${duration} -gt 10 ]]; then
            exitStatus+=$'\e[4;90mDuration\e[0m: '${duration%.*}"s; "
        fi

        unset STARTTIME
    fi
    if [[ $exitStatus ]]; then
        print "\e[1;90m<<<\e[0m "$exitStatus
    fi

    print -Pn "\e]2; %~ \a"

    local pwdPrompt=" "$(~/.zsh/rc/pwd.py)

    local attrPrompt=" ("

    local items=(*(N))
    local hiddenItems=(.*(N))
    local itemNum=${#items}
    if [[ ${#hiddenItems} -gt 0 ]]; then
        itemNum+=$'%{\e[1;36m%}*%{\e[0m%}'
    fi
    attrPrompt+=$itemNum$' \e[90mitems\e[0m'

    if [[ $OSTYPE == "darwin"* ]]; then
        local tags=$(tag -N . | sed -e 's/,/'$'\e[0m+\e[103;30m''/g')
        if [[ $tags != "" ]]; then
            attrPrompt+=", "$'\e[103;30m'$tags$'\e[0m'
        fi
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

    PROMPT=$PREPROMPT$pwdPrompt$attrPrompt$dirPrompt$venvPrompt$updatePrompt$inputPrompt
}
if [[ -z $precmd_functions[myprecmd] ]]; then
    precmd_functions+=myprecmd;
fi

function mypreexec() {
    local currentTime=$(date +'%a %I:%M:%S %p')
    local paddingSize=$(($COLUMNS - ${#currentTime} - 2))
    print "\e[1A\e[${paddingSize}C[\e[90m$currentTime\e[0m]"

    STARTTIME=$(date +%s.%N)
}
if [[ -z $preexec_functions[mypreexec] ]]; then
    preexec_functions+=mypreexec;
fi
