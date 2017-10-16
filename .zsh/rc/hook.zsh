function myprecmd() {
    local exitCode=$?
    if [[ $exitCode -ne 0 && $timer ]]; then
        print "\e[1;90m<<<\e[0m ""\e[4;91mExit Code\e[0m: $exitCode"
    fi

    print -Pn "\e]2; %~ \a"

    if [ $timer ]; then
        local timer_show=$(($SECONDS - $timer))
        if [ ${timer_show} -gt 10 ]; then
            print "\e[1;90m<<<\e[0m ""\e[4;90mRunning Time\e[0m: ${timer_show}s"
        fi
        unset timer
    fi

    local userPrompt=$'%(!.%{\e[31m%}.%{\e[32m%})%n%{\e[0m%}@%{\e[35m%}%m%{\e[0m%}'

    local shorten_pwd=$(perl -p -e "s|^$HOME|~|" <<< $PWD | ~/.zsh/rc/pwd.py)
    local current_path=$(perl -p -e "s|[^/]+\$||" <<< $shorten_pwd)
    local current_dir=$(perl -p -e "s|^.*?([^/]+)\$|\$1|" <<< $shorten_pwd)

    local pwdPrompt=$' %{\e[1;34m%}'$current_path$'%{\e[1;94m%}'$current_dir$'%{\e[0m%}'

    local attrPrompt=$' ('

    if [[ $OSTYPE == "darwin"* ]]; then
        local tags=$(mdls -name kMDItemUserTags -raw . | sed -e '1d' -e '$d' -e 's/^\s\+\|,/'$'\e[47;30m''/' -e 's/,/'$'\e[0m''/' | paste -d '+' -s)
        if [[ $tags != "" ]]; then
            attrPrompt+=$tags$'\e[0m, '
        fi
    fi

    local itemNum=$(ls | wc -l)
    local hiddenItemFlag=""
    if [[ $(ls -A | wc -l) -gt $itemNum ]]; then
        hiddenItemFlag=$'%{\e[1;36m%}*%{\e[0m%}'
    fi
    attrPrompt+=$itemNum$hiddenItemFlag$' \e[90mitems\e[0m'

    local readmeFile=$(print {readme,readme.*}(.N))
    if [[ $readmeFile != "" ]]; then
        attrPrompt+=": "$readmeFile
    fi

    attrPrompt+=$')'

    local dirPrompt=""

    local dirType=""
    local dirFlag=""

    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2> /dev/null; then
        dirType="git"
        dirFlag=""

        local branch=$(git symbolic-ref --short -q HEAD)
        if [[ $branch != "master" ]]; then
            if [[ $branch == "" ]]; then
                dirType+=$'%{\e[31m%}@'
            else
                dirType+=$'%{\e[0m%}@'
                if [[ $(git branch -r --list origin/$branch) != "" ]]; then
                    dirType+=$'%{\e[32m%}'
                else
                    dirType+=$'%{\e[31m%}'
                fi
                dirType+=$branch
            fi
        fi

        if [[ $(diff <(git status -s) <(git status -s -uno)) != "" ]]; then
            dirFlag+=$'%{\e[36m%}?'
        fi
        if [[ $(git status -s -uno) != "" ]]; then
            dirFlag+=$'%{\e[31m%}+'
        fi
        if [[ $branch != "" && $(git branch -r --list origin/$branch) != "" ]]; then
            if [[ $(git log origin/$branch..) != "" ]]; then
                dirFlag+=$'%{\e[32m%}^'
            fi
            if [[ $(git log HEAD..origin/$branch) != "" ]]; then
                dirFlag+=$'%{\e[36m%}!'
            fi
        fi
        if [[ ! -z $dirFlag ]]; then
            dirFlag=$'%{\e[0m%}:%{\e[1m%}'$dirFlag
        fi

        if [[ ! -z $dirPrompt ]]; then
            dirPrompt+=" | "
        fi
        dirPrompt+=$'%{\e[33m%}'$dirType$dirFlag$'%{\e[0m%}'
    fi

    if [ -d bower_components ]; then
        dirType="bower"

        if [[ ! -z $dirPrompt ]]; then
            dirPrompt+=" | "
        fi
        dirPrompt+=$'%{\e[33m%}'$dirType$'%{\e[0m%}'
    fi

    if [ -d node_modules ] || [ -f package.json ]; then
        if [ -f yarn.lock ]; then
            dirType="yarn"
        else
            dirType="npm"
        fi

        if [[ ! -z $dirPrompt ]]; then
            dirPrompt+=" | "
        fi
        dirPrompt+=$'%{\e[33m%}'$dirType$'%{\e[0m%}'
    fi

    if [[ -f makefile ]]; then
        dirType="make"

        if [[ ! -z $dirPrompt ]]; then
            dirPrompt+=" | "
        fi
        dirPrompt+=$'%{\e[33m%}'$dirType$'%{\e[0m%}'
    fi

    if [ -f ".envrc" ]; then
        dirType="direnv"

        if [[ ! -z $dirPrompt ]]; then
            dirPrompt+=" | "
        fi
        dirPrompt+=$'%{\e[33m%}'$dirType$'%{\e[0m%}'
    fi

    if [[ ! -z $dirPrompt ]]; then
        dirPrompt=$' {'$dirPrompt$'}%{\e[0m%}'
    fi

    local venvPrompt=""
    if [[ ! -z $VIRTUAL_ENV ]]; then
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
