#!/usr/bin/env python3

import sys

def shorten(d, flag):
    if len(d) <= 4:
        flag = False

    x = d[:3] if flag else d
    return "{}{}".format(
        "'{}'".format(x) if ' ' in x else x,
        '*' if flag else ''
    )

for s in sys.stdin:
    x = s.rstrip('\r\n').rsplit('/', 1)

    if len(x) == 1:
        print(shorten(x[0], False))
    else:
        print('{}/{}'.format(
            '/'.join(
                shorten(d, True) for d in x[0].split('/')
            ),
            shorten(x[1], False)
        ))
