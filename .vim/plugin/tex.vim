function! JumpBack(filename, line)
    let filename = substitute(a:filename, " ", "\\\\ ", "g")
    let server = WhichWindow(a:filename)
    if server != "0"
        exec "silent !mvim --servername " . server . " --remote-silent +" . a:line . " " . filename
    endif
endfunction
