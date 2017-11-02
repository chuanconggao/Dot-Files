#! /usr/local/bin/python3

from pathlib import Path

from colors import color
from sh import git

def isFile(f):
    p = Path(f)
    return p.exists() and p.is_file()

def isDir(d):
    p = Path(d)
    return p.exists() and p.is_dir()

def getGitPrompt():
    def isGit():
        try:
            return isDir(".git") or git("rev-parse", "--git-dir")
        except:
            return False

    if not isGit():
        return ""

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

    if remoteBranch:
        flags = ""

        if int(git("rev-list", "--count", f"origin/{branch}..").rstrip('\r\n')) > 0:
            flags += color('^', fg="green", style="bold")
        if int(git("rev-list", "--count", f"HEAD..origin/{branch}").rstrip('\r\n')) > 0:
            flags += color('!', fg="cyan", style="bold")

        if len(flags) > 0:
            gitPrompt += '/' + flags

    flags = ""

    allStatus = git("status", "-s").rstrip('\r\n')
    diffStatus = git("status", "-s", "-uno").rstrip('\r\n')
    if diffStatus:
        flags += color('+', fg="red", style="bold")
    if len(allStatus) > len(diffStatus):
        flags += color('?', fg="cyan", style="bold")

    if len(flags) > 0:
        gitPrompt += ':' + flags

    return gitPrompt

def getDirPrompt():
    conditions = [
        ("direnv", lambda: isFile(".envrc"), None),
        ("make", lambda: isFile("makefile"), None),
        ("pip", lambda: isFile("requirements.txt"), None),
        ("pipenv", lambda: isFile("Pipfile"), None),
        (None, lambda: isDir("node_modules") or isFile("package.json"), [
            ("yarn", lambda: isFile("yarn.lock")),
            ("npm", lambda: True),
        ]),
        ("bower", lambda: isDir("bower_components"), None),
    ]

    return " | ".join(
        color(tag if tag else next(
            subtag for subtag, subcond in sub if subcond()
        ), fg="yellow")
        for tag, cond, sub in conditions if cond()
    )

print(" | ".join(
    p for p in [getGitPrompt(), getDirPrompt()] if len(p) > 0
), end='')
