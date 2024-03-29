#!/usr/bin/env bash

# Log commands to console
set -v

# Update System
sudo pacman -Syuu

# Install base packages
sudo pacman -S yay base-devel

# Install packages
yay -S android-tools \
    bitwarden \
    clang \
    dfu-programmer \
    docker \
    fish \
    gcc \
    git \
    gnome-screenshot \
    htop \
    jdk-openjdk \
    jq \
    lm_sensors \
    nerd-fonts-iosevka \
    nordvpn-bin \
    noto-fonts-emoji \
    ntp \
    openrgb \
    polybar \
    python-powerline-git \
    rofi-wayland \
    rxvt-unicode \
    screenfetch \
    spotify \
    sublime-text-4 \
    telegram-desktop \
    vim \
    waybar

# Remove base packages
yay -R hexchat \
    palemoon-bin \
    ttf-inconsolata

fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

# Install Fisher dependencies
fish -c "fisher install laughedelic/pisces oh-my-fish/rvm jethrokuan/z joseluisq/gitnow@2.6.0"

# Setup coding folders
mkdir -p ~/coding && cd configs

# Setup Fish
mkdir -p ~/.config/fish/configs
cp fish/aliases.fish ~/.config/fish/configs/aliases.fish
cp fish/env.fish ~/.config/fish/configs/env.fish
cp fish/functions.fish ~/.config/fish/configs/functions.fish
cp fish/init.fish ~/.config/fish/config.fish

# Setup FNM
curl -fsSL https://fnm.vercel.app/install | bash

# Setup GIT
cp          git/gitignore        ~/.gitignore
cp          git/gitconfig_global ~/.gitconfig_global

# Setup Xresources
cp          ~/.Xresources       ~/.Xresources.back
cp          urxvt/Xresources    ~/.Xresources

# Setup Rofi
cp -r       rofi                ~/.config/rofi

# Setup Polybar
cp -r       polybar/minimal     ~/.config/polybar

# Setup Tmux
cp          tmux/tmux.conf      ~/.tmux.conf

# Done with the configs
cd ..

# Set fish as default shell
chsh -s $(which fish)

# Propriatary setup
if [[ -d /run/media/joaopaulo/propsetup ]]; then
    sh -C "/run/media/joaopaulo/propsetup/setup.sh"
fi

echo "Happy Coding"
