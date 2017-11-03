#! /usr/local/bin/python3

import re

from sh import git

reSubUntracked = re.compile(r'^S..U$')

def parseGitStatus():
    try:
        status = git("status", "-s", "-b", "--porcelain=2", '-z').rstrip('\0').split('\0')
    except:
        return None

    branch = None
    hasRemote = False
    ahead, behind = 0, 0
    modified, untracked = False, False

    for line in status:
        if line[0] == '#':
            if line.startswith("# branch.head "):
                branchName = line.rsplit(' ', 1)[1]
                if branchName != "(detached)":
                    branch = branchName
            elif line.startswith("# branch.upstream "):
                hasRemote = True
            elif line.startswith("# branch.ab "):
                ahead, behind = [abs(int(x)) for x in line.rsplit(' ', 2)[1:]]
        elif line[0] == '?':
            untracked = True
        elif line[0] != '!':
            s, c, m, u = line.split(' ')[2]
            if s == 'N':
                modified = True
            elif s == 'S':
                modified = modified or c == 'C' or m == 'M'
                untracked = untracked or u == 'U'

    return (branch, hasRemote, ahead, behind, modified, untracked)

if __name__ == "__main__":
    print(parseGitStatus())
