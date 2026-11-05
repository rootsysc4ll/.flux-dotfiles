# flux-dotfiles

## Installation
Run the installation file(not as root) in the home directory and you should be good

## How to create themes
To create themes, there is a fish fucntion that acts like a cli named `flux`, it haves nearly all the functionalities you will need.<br>
To see all the arguments and options for it, type `flux --help` on the terminal.<br>

## Some explanations
A theme is a set of parameters that define the arguments for some applications related to the ricing, like awww and wal.<br>
All the themes are packed within an array, that holds all that "combinations" of parameters and make the process of managing the system appearence more efficient and smooth.<br>
The `load` option of the `flux` cli uses index because this functionality was created to be compatible with hyprland, thus facilitating the proccess of theme switching via keybinds.<br>

## Recomendations
 - Read `keybindings.lua` to understand all the keybindings, specially the theme switching ones
## Thanks to the teams from
 - (hyprland)[https://github.com/hyprwm/hyprland]
 - (awww)[https://codeberg.org/LGFae/awww]
 - (quickshell)[https://quickshell.org/]
 - (pywal16)[https://github.com/eylles/pywal16]