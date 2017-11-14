" Name: Tango Dark 2
" Maintainer: Chuancong Gao

set background=dark

hi clear

if exists("syntax-on")
    syntax reset
endif

let g:colors_name = "tango_dark_2"

hi Normal gui=none guibg=#1C1C1C guifg=#E5E5E5 cterm=none ctermbg=234 ctermfg=254
hi! link Conceal Normal

hi LineNr gui=none guifg=#808080 cterm=none ctermfg=244

hi Cursor gui=none guibg=#E5E5E5 guifg=#1C1C1C cterm=none ctermbg=254 ctermfg=234
hi CursorLine gui=none guibg=#3a3a3a cterm=none ctermbg=237

hi Visual gui=none guibg=#808080 cterm=none ctermbg=244
hi! link SignColumn Normal

hi Comment gui=italic guifg=#878787 cterm=none ctermfg=102

hi CurrentWord gui=none guibg=#87AFAF guifg=#1C1C1C cterm=none ctermbg=111 ctermfg=234
hi LineEnd gui=none guibg=#1C1C1C guifg=#87AFAF cterm=none ctermfg=111 ctermbg=234

hi Search gui=none guibg=#FFAFFF guifg=#1C1C1C cterm=none ctermbg=219 ctermfg=234
hi! link IncSearch Search

hi Constant gui=italic guifg=#FF5F5F cterm=none ctermfg=203
hi String gui=italic guifg=#D7FF87 cterm=none ctermfg=192
hi! link Character String

hi Special gui=none guifg=#AF87FF cterm=none ctermfg=141
hi! link Operator Function

hi PreProc gui=none guifg=#FFAF87 cterm=none ctermfg=216
hi Statement gui=none guifg=#87AFFF cterm=none ctermfg=111
hi Identifier gui=none guifg=#AF87AF cterm=none ctermfg=139
hi Function gui=none guifg=#FF87AF cterm=none ctermfg=211
hi Type gui=none guifg=#FFD75F cterm=none ctermfg=221

hi MatchParen gui=none guibg=#AF87FF guifg=#1C1C1C cterm=none ctermbg=141 ctermfg=234

hi StatusLine gui=bold guibg=#D0D0D0 guifg=#1C1C1C cterm=bold ctermbg=252 ctermfg=234
hi StatusLineNC gui=bold guibg=#808080 guifg=#1C1C1C cterm=bold ctermbg=244 ctermfg=234

hi PmenuSel gui=bold guibg=#D0D0D0 guifg=#1C1C1C cterm=bold ctermbg=252 ctermfg=234
hi Pmenu gui=bold guibg=#808080 guifg=#1C1C1C cterm=bold ctermbg=244 ctermfg=234
hi! link PmenuThumb PmenuSel
hi! link PmenuSbar Pmenu

hi! TabLine gui=none guibg=#808080 cterm=none ctermbg=8 ctermfg=15
hi! TabLineSel gui=bold cterm=bold

hi IndentGuidesOdd  guibg=#444444 ctermbg=238
hi IndentGuidesEven guibg=#303030 ctermbg=236
