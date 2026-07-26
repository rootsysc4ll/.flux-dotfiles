# flux-dotfiles

I don't know how to make install-scripts yet, but here is a guide to properly install the dotfiles:

## Details
This repo depends on
 - Hyperland
 - quickshell
 - iris (AUR, use yay or paru)
    `paru -S iris`
Also, for now, I made this inside archlinux, with kitty, bash and without any graphical login manager(like sddm), so I don't know if this works in other setups

## Post-install scripts
You'll need to add this symlink:
`ln -s -T ~/.flux-dotfiles/iris/ ~/.config/iris`
And add this to your .bashrc:
```
if uwsm check may-start; then
    ~/.flux-dotfiles/start.sh
fi

cat ~/.cache/iris/sequences
```
