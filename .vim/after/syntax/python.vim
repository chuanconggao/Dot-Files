syn match       pythonOperator     display "[:]"
syn match       pythonOperator     display "[-+\*/%=]"
syn match       pythonOperator  display "[!<>]=\="
syn match       pythonOperator  display "=="
syn match       pythonOperator   display "\(&\||\|\^\|<<\|>>\)=\="
syn match       pythonOperator   display "\~"

syn match       pythonSpecialOperator     display "[\[\]\(\){}]"
syn match       pythonSpecialOperator  display "\."

syn match   pythonLineEnd       ";\|,"

hi def link pythonLineEnd LineEnd
hi def link pythonOperator Operator
hi def link pythonSpecialOperator Special
