#!/bin/sh

paru || yay 

paru -S iris quickshell || yay -S iris quickshell

ln -s -T ~/.flux-dotfiles/iris/ ~/.config/iris

cat >>~/.bashrc<< EOL
if uwsm check may-start; then
    ~/.flux-dotfiles/start.sh
fi

cat ~/.cache/iris/sequences
EOL