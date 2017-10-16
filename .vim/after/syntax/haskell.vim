syn match       haskellSpecialOperator     display "[\[\]\(\){}]"
syn match       haskellSpecialOperator  display "\."

syn match   haskellLineEnd       ","

hi def link haskellLineEnd LineEnd

hi def link haskellSpecialOperator Special

