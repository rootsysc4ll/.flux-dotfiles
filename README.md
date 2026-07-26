# flux-dotfiles

I don't know how to make install-scripts yet, but here is a guide to properly install the dotfiles:

## Details
This repo depends on
<ul>
    <li>Hyprland</li>
    <li>quickshell</li>
    <li>iris (AUR, use yay or paru): <code>paru -S iris</code></li>
</ul>
So make sure to install these.<br>
Also, for now, I made this inside archlinux, with kitty, bash and without any graphical login manager(like sddm), so I don't know if this works in other setups.

## Installation
Run
```
git clone https://github.com/rootsysc4ll/.flux-dotfiles.git
```
Inside the home(<code>~</code>) directory(it needs to be there, or you can modify the paths inside the source code to fit your needs)

## Post-install
First, add this symlink: `ln -s -T ~/.flux-dotfiles/iris/ ~/.config/iris`<br>
Then, don't forget to increase the privileges of <code>start.sh</code>: <code>chmod +x ~/.flux-dotfiles/start.sh</code> 
And then add this to your .bashrc:
```
if uwsm check may-start; then
    ~/.flux-dotfiles/start.sh
fi

cat ~/.cache/iris/sequences
```
Now you're done!
