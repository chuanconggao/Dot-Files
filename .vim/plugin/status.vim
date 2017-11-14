function! FileStatus()
    let label = ""
    if getbufvar(bufname(""), "&modified")
        if label != ""
            let label .= ", "
        endif
        let label .= "+"
    endif
    if getbufvar(bufname(""), "&readonly")
        if label != ""
            let label .= ", "
        endif
        let label .= "RO"
    endif
    if !getbufvar(bufname(""), "&modifiable")
        if label != ""
            let label .= ", "
        endif
        let label .= "-"
    endif
    if label != ""
        return " [" . label . "]"
    endif
    return label
endfunction

function! ModifiedTimeStatuslineText()
    let ftime = getftime(bufname("%"))
    if ftime < 0
        return ""
    endif
    if strftime("%Y", ftime) == strftime("%Y")
        if strftime("%m %d", ftime) == strftime("%m %d")
            return strftime("[%I:%M:%S %p]", ftime)
        else
            return strftime("[%b %d, %I:%M:%S %p]", ftime)
        endif
    else
        return strftime("[%b %d %Y, %I:%M:%S %p]", ftime)
    endif
endfunction

function! TotalLineNumText()
    return "/" . line("$")
endfunction

function! TotalCharNumText()
    return "/" . len(getline("."))
endfunction

set laststatus=2
set statusline=%t%{FileStatus()}\ [%{&fileformat},\ %{(&fenc==\"\"?&enc:&fenc)}]\ %{ModifiedTimeStatuslineText()}%=[%l%{TotalLineNumText()},\ %v]
