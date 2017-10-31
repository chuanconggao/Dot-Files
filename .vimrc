scriptencoding utf-8

syntax on

filetype plugin indent on

if !has("gui_running")
    set t_Co=256
endif

"set colorcolumn=80

set cursorline
set number
set relativenumber

set visualbell

set iskeyword-=_-

set listchars=tab:⇥\ ,trail:·
set list

set ignorecase
set smartcase

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

set display+=lastline

set updatetime=400

set report=0

set clipboard=unnamed

set lazyredraw

set nostartofline

set whichwrap=<,>,[,]

set completeopt=menuone

set backspace=indent,eol,start

set history=1000

set viminfo='1000
set viminfo+=f1

set wildmenu

set suffixes=~,.bak,.tmp,.swp

set selectmode=
set keymodel=startsel,stopsel

set shortmess=a

set undofile

set spellsuggest=best,10

set hlsearch
set incsearch

set laststatus=2
function! ModifiedTimeStatuslineText()
    let ftime = getftime(bufname("%"))
    if ftime < 0
        return ""
    endif
    if strftime("%Y", ftime) == strftime("%Y")
        if strftime("%m %d", ftime) == strftime("%m %d")
            return strftime("[%I:%M:%S %p]", ftime)
        else
            return strftime("[%b %d, %I:%M:%S %p]", ftime)
        endif
    else
        return strftime("[%b %d %Y, %I:%M:%S %p]", ftime)
    endif
endfunction
function! TotalLineNumText()
    return "/" . line("$")
endfunction
function! TotalCharNumText()
    return "/" . len(getline("."))
endfunction
function! FileStatus()
    let label = ""
    if getbufvar(bufname(""), "&modified")
        if label != ""
            let label .= ", "
        endif
        let label .= "+"
    endif
    if getbufvar(bufname(""), "&readonly")
        if label != ""
            let label .= ", "
        endif
        let label .= "RO"
    endif
    if !getbufvar(bufname(""), "&modifiable")
        if label != ""
            let label .= ", "
        endif
        let label .= "-"
    endif
    if label != ""
        return " [" . label . "]"
    endif
    return label
endfunction
set statusline=%t%{FileStatus()}\ [%{&fileformat},\ %{(&fenc==\"\"?&enc:&fenc)}]\ %{ModifiedTimeStatuslineText()}%=[%l%{TotalLineNumText()},\ %v]

function! TabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])
    let label = ''
    if name == ''
        let label .= '[No Name]'
    else
        let label .= fnamemodify(name, ":t")
    endif
    if getbufvar(buflist[winnr - 1], "&modified")
        let label .= ' [+]'
    endif
    return label
endfunction
function! TabpageBufferText()
    let s = '['
    for i in range(tabpagenr('$'))
        if i + 1 > 1
            let s .= '|'
        endif
        let buflist = tabpagebuflist(i + 1)
        for j in range(len(buflist))
            if j + 1 > 1
                let s .= ' '
            endif
            if i + 1 == tabpagenr()
                if j + 1 == tabpagewinnr(i + 1)
                    let s.= '>'
                endif
            endif
            let s .= buflist[j]
            if getbufvar(buflist[j], "&modified")
                let s .= '+'
            endif
        endfor
    endfor
    let s .= ']'
    return s
endfunction
function! TabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= '%' . (i + 1) . 'T'
        let s .= ' %{TabLabel(' . (i + 1) . ')} '
    endfor
    let s .= '%#TabLineFill#' . '%='
    " let s .= TabpageBufferText()
    " let s .= '[' . tabpagenr() . '/' . tabpagenr('$') . ']'
    return s
endfunction
if !has("gui_running")
    set tabline=%!TabLine()
endif

autocmd BufWinLeave * if expand("%") != "" | mkview | endif
autocmd BufWinEnter * if expand("%") != "" | loadview | endif
autocmd BufEnter * if expand('%:p') =~ '^/' | :lch %:p:h | endif

" autocmd InsertLeave,TextChanged * if &diff == 1 | diffupdate | endif

autocmd BufNewFile,BufRead *.ipy setlocal filetype=python
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.plt setlocal filetype=gnuplot
autocmd BufNewFile,BufRead *.md setlocal filetype=pandoc
autocmd BufNewFile,BufRead *.markdown setlocal filetype=pandoc
autocmd BufNewFile,BufRead *.url setlocal filetype=url

autocmd BufNewFile,BufRead *.sh setlocal iskeyword-=_

autocmd filetype crontab setlocal nobackup nowritebackup

runtime macros/matchit.vim

runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#helptags()

set background=dark
colorscheme tango_dark_2

silent! call yankstack#setup()

let g:ctrlp_map = ''
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 1000
let g:ctrlp_max_depth = 10
let g:ctrlp_mruf_max = &history
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_root_markers = ['makefile', 'build.xml', '.svn', '.git', '.hg', '.cvs']
"let g:ctrlp_show_hidden = 1

let g:NERDChristmasTree = 1
let g:NERDTreeChDirMode = 1
"let g:NERDTreeShowHidden = 1

let g:tagbar_sort = 0
let g:tagbar_usearrows = 1
let g:tagbar_iconchars = ['▸', '▾']

let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']

let g:rootmarkers = ['makefile', 'build.xml', '.svn', '.git', '.hg', '.cvs']

let g:showmarks_marks = "abcdefghijklmnopqrstuvwxyz"

let g:vim_markdown_folding_disabled = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 5

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filetype_blacklist = {}
let g:ycm_filetype_specific_completion_to_disable = {}
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1

let g:languagetool_jar = '/usr/local/Cellar/languagetool/3.9/libexec/languagetool-commandline.jar'

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444444 ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030 ctermbg=236

nmap <silent> z<Tab> <Plug>IndentGuidesToggle

map <F9> :lp<CR>
map <F10> :lne<CR>

nmap <leader>ve :e ~/.vimrc<CR>
nmap <leader>vs :so ~/.vimrc<CR>

nmap <leader>cd :cd %:p:h<CR>
nmap <leader>cl :lcd %:p:h<CR>
nmap <leader>cr :ProjectRootCD<CR>

if has("gui_macvim") || has("mac")
    nmap <Leader>of :silent !open "%:h"<Return>
    nmap <Leader>ot :silent !open -a Terminal.app "%:h"<Return>
    nmap <Leader>ov :up<CR>:silent !mvim "%"<Return>
    nmap <Leader>oq :up<CR>:silent !qlmanage -p "%" > /dev/null 2> /dev/null<CR>
endif
nmap <Leader>ob <Plug>(openbrowser-smart-search)
vmap <Leader>ob <Plug>(openbrowser-smart-search)

nmap <leader>du :diffupdate<CR>

nmap <Leader>rb :silent !rm "%:p:h/.%:t.un~"<Return>

nmap <Leader>st :NERDTree<Return>
nmap <Leader>sf :CtrlP<Return><F5>
nmap <Leader>sr :CtrlPMRU<Return><F5>
nmap <Leader>sb :CtrlPBuffer<Return><F5>
nmap <Leader>sq :bo cw<CR>
nmap <Leader>su :GundoToggle<CR><CR>
nmap <Leader>sl :Tagbar<CR>
nmap <Leader>sy :Yanks<CR>

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

nmap Y y$

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

nnoremap <silent> gw :ArgWrap<CR>

nmap yl :call setreg('*', line('.'))<CR>
nmap gl :<C-r>*<CR>

nnoremap <C-l> :noh<CR>:redraw!<CR>

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
nnoremap z/ :call AutoHighlightToggle()<CR>

function! JumpBack(filename, line)
    let filename = substitute(a:filename, " ", "\\\\ ", "g")
    let server = WhichWindow(a:filename)
    if server != "0"
        exec "silent !mvim --servername " . server . " --remote-silent +" . a:line . " " . filename
    endif
endfunction
