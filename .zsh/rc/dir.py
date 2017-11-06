#! /usr/local/bin/python3

from pathlib import Path

from colors import color
from git import parseGitStatus

def isFile(*files):
    for f in files:
        p = Path(f)
        return p.exists() and p.is_file()

def isDir(*dirs):
    for d in dirs:
        p = Path(d)
        return p.exists() and p.is_dir()

def getGitPrompt():
    status = parseGitStatus()
    if status is None:
        return ""

    (branch, hasRemote, ahead, behind, modified, untracked) = status

    gitPrompt = color("git", fg="yellow")

    if branch is None:
        gitPrompt += color('@', fg="red")
    else:
        if branch == "master":
            branch = ""

        if branch != "" or not hasRemote:
            gitPrompt += '@' + color(branch, fg=(
                "green" if hasRemote else "cyan"
            ))

    if hasRemote:
        flags = ""

        if ahead > 0:
            flags += color('^', fg="green", style="bold")
        if behind > 0:
            flags += color('!', fg="cyan", style="bold")

        if len(flags) > 0:
            gitPrompt += '/' + flags

    flags = ""

    if modified:
        flags += color('+', fg="red", style="bold")
    if untracked:
        flags += color('?', fg="cyan", style="bold")

    if len(flags) > 0:
        gitPrompt += ':' + flags

    return gitPrompt

def getDirPrompt():
    conditions = [
        ("direnv", isFile(".envrc"), None),
        ("make", isFile("makefile"), None),
        (None, isFile("requirements.txt", "Pipfile"), [
            ("pipenv", lambda: isFile("Pipfile")),
            ("pip", lambda: isFile("requirements.txt")),
        ]),
        (None, isDir("node_modules") or isFile("package.json"), [
            ("yarn", lambda: isFile("yarn.lock")),
            ("npm", lambda: True),
        ]),
        ("bower", isDir("bower_components"), None),
    ]

    return " | ".join(
        color(tag if tag else next(
            subtag for subtag, subcond in sub if subcond()
        ), fg="yellow")
        for tag, cond, sub in conditions if cond
    )

print(" | ".join(
    p for p in [getGitPrompt(), getDirPrompt()] if len(p) > 0
), end='')
