#!/usr/bin/env python3

import asyncio
import iterm2
import os
import subprocess


def shortened_hostname(h):
    i = h.find(".")
    if i < 0:
        return h
    else:
        return h[:i]


def make_pwd(user_home, localhome, pwd):
    if pwd:
        home = user_home if user_home else localhome
        if pwd == home:
            return "🏡"
        elif pwd.startswith(home):
            pwd = "~" + pwd[len(home):]
        folder_name = pwd.split("/")[-1]
        last_folder_name = pwd.split("/")[-2]
        last_folder_name = f"({last_folder_name})" if last_folder_name else ""
        return f"{folder_name} {last_folder_name}"
    return ""


async def main(connection):
    localhome = os.environ.get("HOME")

    @iterm2.TitleProviderRPC
    async def georges_title(
            pwd=iterm2.Reference("path?"),
            tmux_title=iterm2.Reference("tmuxWindowTitle?"),
            user_home=iterm2.Reference("user.home?")):
        if tmux_title:
            return tmux_title

        return make_pwd(user_home, localhome, pwd)
    await georges_title.async_register(
            connection,
            display_name="Folder Title",
            unique_identifier="com.iterm2.example.folder-title-algorithm")


iterm2.run_forever(main)
