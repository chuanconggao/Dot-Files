autocmd BufWinLeave * if expand("%") != "" | mkview | endif
autocmd BufWinEnter * if expand("%") != "" | silent! loadview | endif
autocmd BufEnter * if expand('%:p') =~ '^/' | lcd %:p:h | endif

autocmd InsertLeave,TextChanged * if &diff == 1 | diffupdate | endif

autocmd BufNewFile,BufRead *.ipy setlocal filetype=python
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.plt setlocal filetype=gnuplot
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
autocmd BufNewFile,BufRead *.markdown setlocal filetype=markdown
autocmd BufNewFile,BufRead *.url setlocal filetype=url
autocmd BufNewFile,BufRead *.sh setlocal iskeyword-=_

hi! link Shebang StrongComment
autocmd BufNewFile,BufRead * syn match Shebang '\%1l^#\!\s*.*'
