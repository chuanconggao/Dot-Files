setlocal makeprg=fsc\ \\"%\\"

nnoremap <buffer> <F5> :up<CR>:silent make!<CR>:bo cw<CR>
