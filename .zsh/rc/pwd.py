#! /usr/local/bin/python3

import os

def prepare(d, shorten=True):
    shorten = shorten and len(d) > 4

    x = d[:3] if shorten else d
    return (
        ("'{}'".format(x) if ' ' in x else x) +
        ('*' if shorten else '')
    )


def colorPath(p):
    return f"\x1b[1;34m{p}\x1b[0m"


def colorDir(p):
    return f"\x1b[1;94m{p}\x1b[0m"


home = os.getenv("HOME")
cwd = os.getenv('PWD')
if cwd != '/' and (cwd + '/').startswith(home + '/'):
    cwd = '~' + cwd[len(home):]

if cwd == '/' or cwd == '~':
    current_path, current_dir = "", cwd
else:
    current_path, current_dir = cwd.rsplit('/', 1)
    current_path += '/'

print(
    colorPath(
        '/'.join(
            prepare(d) for d in current_path.split('/')
        ),
    ) + colorDir(
        prepare(current_dir, shorten=False)
    ),
    end=""
)
