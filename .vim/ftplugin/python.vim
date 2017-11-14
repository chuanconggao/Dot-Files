syn keyword pythonConstant Ellipsis False None True
hi! link pythonConstant Constant

let g:syntastic_python_checkers = ['python', 'pylint']

if getline(1) =~# '^#! */[^ ]*[ /]\+\(i\?python3\|pypy3\)\>'
    let b:syntastic_python_python_exec = '/usr/local/bin/python3'
    let b:syntastic_python_pylint_exec = '/usr/local/bin/pylint3'
else
    let b:syntastic_python_python_exec = '/usr/local/bin/python'
    let b:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
endif
set colorcolumn=80
