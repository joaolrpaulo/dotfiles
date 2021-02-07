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
    brave \
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
    rofi \
    rxvt-unicode \
    screenfetch \
    spotify \
    telegram-desktop \
    vim \
    visual-studio-code-bin

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
cp fish/panda_aliases.fish ~/.config/fish/configs/panda_aliases.fish
cp fish/panda_env.fish ~/.config/fish/configs/panda_env.fish
cp fish/panda_functions.fish ~/.config/fish/configs/panda_functions.fish
cp fish/init.fish ~/.config/fish/config.fish

# Setup FNM
curl -fsSL https://fnm.vercel.app/install | bash

# Setup GIT
cp          git/gitignore       ~/.gitignore
cp          git/gitconfig       ~/.gitconfig

# Setup i3
mkdir -p    ~/.i3/
cp          i3/config           ~/.i3/config

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
