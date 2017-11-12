set linespace=2
set guifont=Consolas:h14

set guioptions=ce

set lines=40 columns=160
set fuoptions=maxvert,maxhorz

if has("gui_macvim")
    set transparency=20
    set blur=25

    set guicursor=a:blinkwait500-blinkon500-blinkoff500
endif

if has("gui")
    nmap <C-Tab> gt
    nmap <C-S-Tab> gT
endif

set guitablabel=%t%{FileStatus()}
set guitabtooltip=%{ModifiedTimeStatuslineText()}
