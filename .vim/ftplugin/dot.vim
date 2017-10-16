setlocal makeprg=dot\ -Tpdf\ \\"%\\"\ -o\ \\"%.pdf\\"

nnoremap <buffer> <F5> :up<CR>:silent make!<CR>:bo cw<CR>

nnoremap <buffer> <F11> :cp<CR>
nnoremap <buffer> <F12> :cn<CR>
