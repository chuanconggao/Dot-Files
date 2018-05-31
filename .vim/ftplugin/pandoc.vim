if !filereadable("makefile")
    setlocal makeprg=pandoc\ \\"%\\"\ -o\ \\"%<\\".pdf
endif

setlocal linebreak

setlocal spell

syntax spell toplevel

nnoremap <buffer> <F5> :up<CR>:silent !open -a Markoff "%"<CR>
nnoremap <buffer> <F6> :up<CR>:make!<CR>:bo cw<CR>:silent !open "%<".pdf<CR>

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
