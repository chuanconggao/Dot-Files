#! /usr/local/bin/python3

import subprocess

def parseGitStatus():
    output = subprocess.Popen(
        ["git", "status", "-s", "-b", "--porcelain=2"],
        stdout=subprocess.PIPE, stderr=subprocess.DEVNULL
    ).communicate()[0].decode("utf-8")
    if output == "":
        return None

    branch = None
    hasRemote = False
    ahead, behind = 0, 0
    modified, untracked = False, False

    for line in output.rstrip('\n').split('\n'):
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
            s, _, _, u = line.split(' ')[2]
            flag = s == 'S' and u == 'U'

            modified, untracked = modified or not flag, untracked or flag

    return (branch, hasRemote, ahead, behind, modified, untracked)


if __name__ == "__main__":
    print(parseGitStatus())
