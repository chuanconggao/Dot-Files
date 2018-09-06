function! BufferStatus(name)
    let label = ""

    if getbufvar(a:name, "&readonly")
        let label .= "!"
    endif
    if getbufvar(a:name, "&modified")
        let label .= "+"
    endif
    if !getbufvar(a:name, "&modifiable")
        let label = "-"

    endif

    if label != ""
        return " " . label
    endif
    return label
endfunction

function! ModifiedTime()
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
set statusline=%#StatusLineBold#%t%{BufferStatus(bufname(\"\"))}%#StatusLine#\ (%{&fileformat},\ %{(&fenc==\"\"?&enc:&fenc)})\ %{ModifiedTime()}%=[%l%{TotalLineNumText()},\ %v]
