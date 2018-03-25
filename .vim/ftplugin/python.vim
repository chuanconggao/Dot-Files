syn keyword pythonConstant Ellipsis False None True
hi! link pythonConstant Constant

syn keyword pythonIdentifier self
hi! link pythonIdentifier Identifier

syn match pythonStrongComment '#\s*type:.*'
hi! link pythonStrongComment StrongComment

if getline(1) =~# '^#! */[^ ]*[ /]\+\(i\?python3\|pypy3\)\>'
    let b:syntastic_python_python_exec = '/usr/local/bin/python3'
    let b:syntastic_python_pylint_exec = '/usr/local/bin/pylint3'
else
    let b:syntastic_python_python_exec = '/usr/local/bin/python'
    let b:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
endif
