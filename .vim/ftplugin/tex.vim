syn region texComment start="\\begin{comment}" end="\\end{comment}"

setlocal spell

let g:tex_flavor = "latex"

vnoremap <buffer> <D-U> di\underline{}<ESC><S-p>
vnoremap <buffer> <D-I> di\textit{}<ESC><S-p>
vnoremap <buffer> <D-B> di\textbf{}<ESC><S-p>

" LaTex Math BLock Operations
nnoremap <buffer> di$ T$d,
nnoremap <buffer> da$ F$d,
nnoremap <buffer> ci$ T$c,
nnoremap <buffer> ca$ F$c,
nnoremap <buffer> yi$ T$y,
nnoremap <buffer> ya$ F$y,
nnoremap <buffer> vi$ T$v,
nnoremap <buffer> va$ F$v,

nnoremap <buffer> <S-D-Enter> :silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> "%<.pdf" "%"<CR>

nnoremap <buffer> <F5> :up<CR>:ProjectRootExe silent make!<CR>:bo cw<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> "%<.pdf" "%"<CR>
nnoremap <buffer> <F6> :up<CR>:ProjectRootExe silent make!<CR>:bo cw<CR>:silent !open "%<.pdf"<CR>

nnoremap <buffer> <F9> :LanguageToolCheck<CR>
vnoremap <buffer> <F9> :LanguageToolCheck<CR>

nnoremap <buffer> <F11> :cp<CR>
nnoremap <buffer> <F12> :cn<CR>
