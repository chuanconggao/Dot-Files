scriptencoding utf-8

if !has('nvim')
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim

    set ttymouse=xterm2
endif

if !has("gui_running")
    set t_Co=256
endif

set mouse=a

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

set directory=~/.vim/swap//

set history=1000

set viminfo='1000
set viminfo+=f1

set suffixes=~,.bak,.tmp,.swp

set shortmess=a

set undofile

set spellsuggest=best,10

set hlsearch
set incsearch

set virtualedit=block

runtime macros/matchit.vim

runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#helptags()

colorscheme tango_dark_2
