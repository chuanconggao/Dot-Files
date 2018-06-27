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

function! TabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])

    let label = ''
    if name == ''
        let label .= '[No Name]'
    else
        let label .= fnamemodify(name, ":t")
    endif

    return label . BufferStatus(name)
endfunction

function! TabLine()
    let s = ''

    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= '%' . (i + 1) . 'T'
        let s .= ' %{TabLabel(' . (i + 1) . ')} '
    endfor

    return s . '%#TabLineFill#' . '%='
endfunction

set tabline=%!TabLine()
