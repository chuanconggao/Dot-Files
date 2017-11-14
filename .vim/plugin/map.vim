cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-b> <Left>
cmap <C-f> <Right>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-d> <C-o>x
imap <C-k> <C-o><S-d>

noremap j gj
noremap k gk
noremap <Up> g<Up>
noremap <Down> g<Down>
noremap 0 g0
noremap ^ g^
noremap $ g$
noremap gj j
noremap gk k
noremap g<Up> <Up>
noremap g<Down> <Down>
noremap g0 0
noremap g^ ^
noremap g$ $

nmap Y y$

vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
      let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
      let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
      let result = toupper(a:str)
    endif
    return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

map <F9> :lp<CR>
map <F10> :lne<CR>
map <F11> :cp<CR>
map <F12> :cn<CR>

nmap <Leader>cd :cd %:p:h<CR>
nmap <Leader>cl :lcd %:p:h<CR>
nmap <Leader>cr :ProjectRootCD<CR>

if has("mac")
    nmap <Leader>of :silent !open "%:h"<Return>
    nmap <Leader>ot :silent !open -a Terminal.app "%:h"<Return>
    if !has("gui_macvim")
        nmap <Leader>ov :up<CR>:silent !mvim "%"<Return>
    endif
    nmap <Leader>oq :up<CR>:silent !qlmanage -p "%" > /dev/null 2> /dev/null<CR>
endif
nmap <Leader>ob <Plug>(openbrowser-smart-search)
vmap <Leader>ob <Plug>(openbrowser-smart-search)

nmap <Leader>du :diffupdate<CR>

nmap <Leader>rb :!rm "%:p:h/.%:t.un~"<Return>

nmap <Leader>st :NERDTree<Return>
nmap <Leader>sf :CtrlP<Return><F5>
nmap <Leader>sr :CtrlPMRU<Return><F5>
nmap <Leader>sb :CtrlPBuffer<Return><F5>
nmap <Leader>sq :bo cw<CR>
nmap <Leader>su :GundoToggle<CR><CR>
nmap <Leader>sl :Tagbar<CR>
nmap <Leader>sy :Yanks<CR>

nmap <Leader>p <Plug>yankstack_substitute_older_paste
nmap <Leader>P <Plug>yankstack_substitute_newer_paste

nmap <Leader>fw :ArgWrap<CR>

nmap <Leader>ly :call setreg('*', line('.'))<CR>
nmap <Leader>lg :<C-r>*<CR>

nmap <C-l> :noh<CR>:redraw!<CR>

nmap z<Tab> <Plug>IndentGuidesToggle

function! AutoHighlightToggle()
    if exists('#auto_highlight')
        exe printf('match Normal /\<%s\>/', expand('<cword>'))
        au! auto_highlight
        augroup! auto_highlight
        echo 'Automatically Highlight Current Word: OFF'
    else
        augroup auto_highlight
        au!
        au CursorHold * silent! exe printf('match CurrentWord /\<%s\>/', expand('<cword>'))
        augroup end
        echo 'Automatically Highlight Current Word: ON'
    endif
endfunction
nmap z/ :call AutoHighlightToggle()<CR>
