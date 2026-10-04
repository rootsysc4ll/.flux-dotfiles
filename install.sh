#!/bin/sh

cd $HOME

## installing apps
# general applications
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed base-devel git
sudo pacman -S --noconfirm hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprshot hyprsunset uwsm rofi kitty fish quickshell awww brightnessctl fastfetch ttf-jetbrains-mono-nerd ttf-material-symbols-variable

# paru
git clone https://aur.archlinux.org/paru.git
cd paru
export skipped=true
makepkg -si --noconfirm
cd ..
rm -rf paru

# iris
paru -S --noconfirm iris-colors

## setting up fish
chsh -s /bin/fish

## setting up symlinks
ln -sT ~/.flux-dotfiles/applications/iris/ ~/.config/iris
ln -sT ~/.flux-dotfiles/applications/kitty/ ~/.config/kitty
ln -sT ~/.flux-dotfiles/applications/fastfetch/ ~/.config/fastfetch
rm -r ~/.config/fish || ln -s -T ~/.flux-dotfiles/applications/fish/ ~/.config/fish

## first run for theme
cd ~/.flux-dotfiles/theme
iris -i default.png && lua flux-theme.lua default

## reboot
sleep 5
sudo systemctl reboot