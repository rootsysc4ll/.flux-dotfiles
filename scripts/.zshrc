#!/bin/sh

if uwsm check may-start; then
    ~/.flux-dotfiles/scripts/start.sh
fi

cat ~/.cache/iris/sequences

alias ..="cd .."
