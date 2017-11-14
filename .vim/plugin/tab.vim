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
    if getbufvar(buflist[winnr - 1], "&modified")
        let label .= ' +'
    endif
    return label
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
    let s .= '%#TabLineFill#' . '%='
    return s
endfunction

if !has("gui_running")
    set tabline=%!TabLine()
endif
