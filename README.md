# flux-dotfiles

I don't know how to make install-scripts yet, but here is a guide to properly install the dotfiles:

## Details
This repo depends on the following packages:
<ul>
    <li>Hyprland</li>
    <li>hyprshot</li>
    <li>hyprsunset</li>
    <li>uwsm</li>
    <li>rofi</li>
    <li>zsh</li>
    <li>quickshell</li>
    <li>awww</li>
    <li>brightnessctl</li>
    <li>iris (AUR, use yay or paru): <code>paru -S iris</code></li>
    <li>JetBrains Mono Nerd and Material Symbols</li>
</ul>
So make sure to install them.<br>
Also, for now, I made this inside archlinux, with kitty, bash and without any graphical login manager(like sddm), so I don't know if this works in other setups.

## Installation
Run
```
git clone https://github.com/rootsysc4ll/.flux-dotfiles.git
```
Inside the home(<code>~</code>) directory(it needs to be there, or you can modify the paths inside the source code to fit your needs).

## Post-install
First, add these symlinks: `ln -s -T ~/.flux-dotfiles/iris/ ~/.config/iris` and `ln -s -T ~/.flux-dotfiles/kitty ~/.config/kitty`<br>
Then copy the .zshrc file in the repo to your home directory<br>
Now you're done!

## How to create themes
Inside <code>~/.flux-dotfiles</code> create a file called <code>Theme.json</code> with this structure:
```
[
    {
        "wpPath": "path/to/Wallpaper1.png",
        "mode": "light"
    },
    {
        "wpPath": "path/to/Wallpaper2.png",
        "mode": "dark"
    }
]
```

## Recomendations
 - Read `keybindings.lua` to understand all the keybindings, specially the theme switching one
 - Go visit [Iris repo](https://github.com/Harman1307/iris) and [awww guide](https://linuxcommandlibrary.com/man/awww) to understand the color scheme implementation
 - Also visit [Hyprland wiki](https://wiki.hypr.land/) and [Quickshell wiki](https://quickshell.org/) to understand the dotfile as a whole
