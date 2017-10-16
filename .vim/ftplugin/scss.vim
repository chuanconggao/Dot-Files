setlocal makeprg=scss\ \\"%<.scss\\"\ >\ \\"%<.css\\"

nnoremap <buffer> <F5> :up<CR>:silent make!<CR>:bo cw<CR>
