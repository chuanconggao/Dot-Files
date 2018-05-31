let g:tex_flavor = "latex"

syn region texComment start="\\begin{comment}" end="\\end{comment}"

let g:syntastic_tex_checkers = ['chktex']

setlocal linebreak

setlocal spell

syntax spell toplevel

vnoremap <buffer> <D-U> di\underline{}<ESC><S-p>
vnoremap <buffer> <D-I> di\textit{}<ESC><S-p>
vnoremap <buffer> <D-B> di\textbf{}<ESC><S-p>

nnoremap <buffer> <S-D-Enter> :silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> "%<.pdf" "%"<CR>

nnoremap <buffer> <F5> :up<CR>:ProjectRootExe silent make!<CR>:bo cw<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> "%<.pdf" "%"<CR>
nnoremap <buffer> <F6> :up<CR>:ProjectRootExe silent make!<CR>:bo cw<CR>:silent !open "%<.pdf"<CR>

nnoremap <buffer> <F7> :LanguageToolCheck<CR>
vnoremap <buffer> <F7> :LanguageToolCheck<CR>
nnoremap <buffer> <F8> :LanguageToolClear<CR>

call textobj#user#plugin('tex', {
\   'environment': {
\     'pattern': ['\\begin{[^}]\+}.*\n\s*', '\n^\s*\\end{[^}]\+}.*$'],
\     'select-a': 'ae',
\     'select-i': 'ie',
\   },
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
