#!/usr/bin/env python3

from pathlib import Path

from colors import color
from sh import git

def isFile(f):
    p = Path(f)
    return p.exists() and p.is_file()

def isDir(d):
    p = Path(d)
    return p.exists() and p.is_dir()

def isGit():
    try:
        return isDir(".git") or git("rev-parse", "--git-dir")
    except:
        return False

if isGit():
    gitPrompt = color("git", fg="yellow")

    branch = git("symbolic-ref", "--short", "-q", "HEAD").rstrip('\r\n')
    remoteBranch = git("branch", "-r", "--list", f"origin/{branch}").rstrip('\r\n')

    if branch != "master":
        if branch:
            gitPrompt += '@' + color(branch, fg=(
                "green" if remoteBranch else "cyan"
            ))
        else:
            gitPrompt += color('@', fg="red")


    flags = []

    allStatus = git("status", "-s").rstrip('\r\n')
    diffStatus = git("status", "-s", "-uno").rstrip('\r\n')
    if diffStatus:
        flags.append(color('+', fg="red"))
    if allStatus != diffStatus:
        flags.append(color('?', fg="cyan"))

    if branch and remoteBranch:
        if int(git("rev-list", "--count", f"origin/{branch}..").rstrip('\r\n')) > 0:
            flags.append(color('^', fg="green"))
        if int(git("rev-list", "--count", f"HEAD..origin/{branch}").rstrip('\r\n')) > 0:
            flags.append(color('!', fg="magenta"))

    if len(flags) > 0:
        gitPrompt += ':' + color(''.join(flags), style="bold")
else:
    gitPrompt = ""

conditions = [
    ("direnv", lambda: isFile(".envrc"), None),
    ("make", lambda: isFile("makefile"), None),
    ("pipenv", lambda: isFile("Pipfile") or isFile("Pipfile.lock"), None),
    (None, lambda: isDir("node_modules") or isFile("package.json"), [
        ("yarn", lambda: isFile("yarn.lock")),
        ("npm", lambda: True),
    ]),
    ("bower", lambda: isDir("bower_components"), None),
]

dirPrompt = " | ".join(
    color(tag if tag else next(
        subtag for subtag, subcond in sub if subcond()
    ), fg="yellow")
    for tag, cond, sub in conditions if cond()
)

print(" | ".join(
    p for p in [gitPrompt, dirPrompt] if len(p) > 0
), end='')
