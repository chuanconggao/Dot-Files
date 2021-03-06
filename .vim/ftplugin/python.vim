syn keyword pythonConstant Ellipsis False None True
hi! link pythonConstant Constant

syn keyword pythonIdentifier self
hi! link pythonIdentifier Identifier

syn match pythonStrongComment '#\s*type:.*'
hi! link pythonStrongComment StrongComment

if getline(1) =~# '^#! */[^ ]*[ /]\+\(i\?python3\|pypy3\)\>'
    let b:syntastic_python_python_exec = '/usr/local/bin/python3'
else
    let b:syntastic_python_python_exec = '/usr/local/bin/python'
endif
let b:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
let g:ale_python_pylint_executable = 'pylint'

let b:venv = system("pushd " . expand("%:p:h") . " > /dev/null && pipenv --venv 2> /dev/null | head -c -1")
let b:venvlib = system("ls -d \"" . b:venv . "/lib/python\"*\"/site-packages\" | head -c -1")
let b:syntastic_python_pylint_post_args="--init-hook=\"import sys; sys.path.insert(0, '". b:venvlib . "')\""

let g:ycm_python_binary_path = b:venv . "/bin/python"
