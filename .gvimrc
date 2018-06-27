set linespace=3
set guifont=Consolas:h14

set guioptions=c

set lines=40 columns=160
set fuoptions=maxvert,maxhorz

if has("gui_macvim")
    set transparency=10
    set blur=12

    set guicursor=a:blinkwait500-blinkon500-blinkoff500
endif

if has("gui")
    nmap <C-Tab> gt
    nmap <C-S-Tab> gT
endif

set guitablabel=%t%{FileStatus()}
set guitabtooltip=%{ModifiedTimeStatuslineText()}
