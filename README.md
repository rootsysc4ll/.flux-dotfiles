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
    <li>fish</li>
    <li>quickshell</li>
    <li>awww</li>
    <li>brightnessctl</li>
    <li>fastfetch</li>
    <li>iris (AUR, use yay or paru): <code>paru -S iris</code></li>
    <li>ttf-jetbrains-mono-nerd and ttf-material-symbols-variable</li>
</ul>
So make sure to install them.<br>

## Installation
Read the installation.txt file for installation instructions

## How to create themes
To create themes, there is a fish function named `flux-theme` that have nearly all the functionalities you will need:<br>
 - `flux-theme file`: outputs the theme file to the terminal
 - `flux-theme default`: creates the default theme file, run this in your first use
 - `flux-theme create [themeName themePath themeMode]`: creates a theme with given args. Notice that themeMode can be dark/light, and,for the path, you can use either absolute or relative paths(make use of the $WP_PATH envvar if you want)
 - `flux-theme remove themeName`: removes a theme with given name

## Recomendations
 - Read `keybindings.lua` to understand all the keybindings, specially the theme switching ones
 - Go visit [Iris repo](https://github.com/Harman1307/iris) and [awww guide](https://linuxcommandlibrary.com/man/awww) to understand the color scheme implementation
 - Also visit [Hyprland wiki](https://wiki.hypr.land/) and [Quickshell wiki](https://quickshell.org/) to understand the dotfile as a whole
