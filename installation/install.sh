#!/bin/sh

sudo pacman -Syu

pacman -S hyprland hyprshot hyprsunset uwsm rofi fish quickshell awww brightnessctl fastfetch ttf-jetbrains-mono-nerd ttf-material-symbols-variable

rm -rf ~/.config/iris ~/.config/kitty ~/.config/fish ~/.config/fastfetch

ln -s -T ~/.flux-dotfiles/applications/iris/ ~/.config/iris
ln -s -T ~/.flux-dotfiles/applications/kitty/ ~/.config/kitty
ln -s -T ~/.flux-dotfiles/applications/fish/ ~/.config/fish
ln -s -T ~/.flux-dotfiles/applications/fastfetch/ ~/.config/fastfetch