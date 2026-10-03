#!/bin/sh

## installing apps

# general applications
sudo pacman -Syu
sudo pacman -S --needed base-devel git
sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprshot hyprsunset uwsm rofi kitty fish quickshell awww brightnessctl fastfetch ttf-jetbrains-mono-nerd ttf-material-symbols-variable

# paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

# iris
paru -S iris-colors

## setting up fish
chsh -s /bin/fish && systemctl reboot

## setting up symlinks
rm -rf ~/.config/iris && ln -s -T ~/.flux-dotfiles/applications/iris/ ~/.config/iris
rm -rf ~/.config/kitty && ln -s -T ~/.flux-dotfiles/applications/kitty/ ~/.config/kitty
rm -rf ~/.config/fish && ln -s -T ~/.flux-dotfiles/applications/fish/ ~/.config/fish
rm -rf ~/.config/fastfetch && ln -s -T ~/.flux-dotfiles/applications/fastfetch/ ~/.config/fastfetch