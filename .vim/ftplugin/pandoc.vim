setlocal makeprg=pandoc\ \\"%\\"\ -o\ \\"%\\".pdf

setlocal spell

nnoremap <buffer> <F5> :up<CR>:silent make!<CR>:bo cw<CR>:silent !open "%".pdf<CR>
