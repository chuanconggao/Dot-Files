#! /usr/local/bin/python3

import os
from pathlib import Path

from colors import color
from extratools import gittools

def isFile(*files):
    return any(
        Path(f).is_file()
        for f in files
    )


def isDir(*dirs):
    return any(
        Path(d).is_dir()
        for d in dirs
    )


def getGitPrompt():
    status = gittools.status()
    if status is None:
        return ""

    branch = status["branch"]["head"]
    hasRemote = status["branch"]["upstream"] is not None
    ahead = status["commits"]["ahead"]
    behind = status["commits"]["behind"]
    modified = bool(status["files"]["modified"])
    untracked = bool(status["files"]["untracked"])

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

        if flags:
            gitPrompt += '/' + flags

    flags = ""

    if modified:
        flags += color('+', fg="red", style="bold")
    if untracked:
        flags += color('?', fg="cyan", style="bold")

    if flags:
        gitPrompt += ':' + flags

    return gitPrompt


def getDirPrompt():
    conditions = [
        ("direnv", os.environ.get("DIRENV_DIR"), None),
        ("make", isFile("makefile"), None),
        (None, isFile("requirements.txt", "Pipfile"), [
            ("pipenv", lambda: isFile("Pipfile")),
            ("pip", lambda: True),
        ]),
        (None, isDir("node_modules") or isFile("package.json"), [
            ("yarn", lambda: isFile("yarn.lock")),
            ("npm", lambda: True),
        ]),
        ("bower", isDir("bower_components"), None),
        ("mvn", isFile("pom.xml"), None),
        ("mkdocs", isFile("mkdocs.yml"), None),
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
