setlocal makeprg=gnuplot\ \\"%\\"

nnoremap <buffer> <F5> :up<CR>:silent make!<CR>:bo cw<CR>
nnoremap <buffer> <F6> :up<CR>:silent make!<CR>:bo cw<CR>:silent !open "%<.pdf"<CR>
nnoremap <buffer> <F7> :up<CR>:silent make!<CR>:bo cw<CR>:silent !pdfcrop "%<.pdf" "%<.pdf"<CR>

nnoremap <buffer> <F11> :cp<CR>
nnoremap <buffer> <F12> :cn<CR>
