if !filereadable("makefile")
    setlocal makeprg=pandoc\ \\"%\\"\ -o\ \\"%<\\".pdf
endif

setlocal spell

nnoremap <buffer> <F5> :up<CR>:make!<CR>:bo cw<CR>:silent !open "%<".pdf<CR>

call textobj#user#plugin('pandoc', {
\  'display-math': {
\     'pattern': ['\\\[', '\\\]'],
\     'select-a': 'a\',
\     'select-i': 'i\',
\   },
\  'inline-math-a': {
\     'pattern': '[$][^$]*[$]',
\     'select': 'a$',
\   },
\  'inline-math-i': {
\     'pattern': '[$]\zs[^$]*\ze[$]',
\     'select': 'i$',
\   },
\ })
