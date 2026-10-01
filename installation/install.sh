#!/bin/sh

cd $HOME

# syncronizing databases
pacman -Syu

# setting up symlinks
ln -s -T ~/.flux-dotfiles/applications/iris/ ~/.config/iris
ln -s -T ~/.flux-dotfiles/applications/kitty/ ~/.config/kitty
ln -s -T ~/.flux-dotfiles/applications/fish/ ~/.config/fish
ln -s -T ~/.flux-dotfiles/applications/fastfetch/ ~/.config/fastfetch

## installing apps

# general applications
pacman -S --needed base-devel git
pacman -S hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprshot hyprsunset uwsm rofi kitty fish quickshell awww brightnessctl fastfetch ttf-jetbrains-mono-nerd ttf-material-symbols-variable

# paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd $HOME
rm -rf paru

# iris
paru -S iris-colors

# setting up fish
chsh -s /bin/fish