setlocal errorformat=%f(%l\\,%c):\ %m

nnoremap <buffer> <F5> :up<CR>:ProjectRootExe silent make!<CR>:bo cw<CR>

nnoremap <buffer> <F11> :cp<CR>
nnoremap <buffer> <F12> :cn<CR>
