#!/usr/bin/env bash

# Log commands to console
set -v

# Start config setup
cd configs

# Setup Brew
cp brew/Brewfile ~/Brewfile
brew bundle

# Update System
brew update && brew upgrade

# Configure noTunes
defaults write digital.twisted.noTunes replacement /Applications/Cider.app

# Install Fisher Plugin Manager
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

# Install Fisher dependencies
fish -c "fisher install jethrokuan/z jorgebucaran/gitio.fish joseluisq/gitnow@2.8.0 brgmnn/fish-docker-compose jorgebucaran/hydro rstacruz/fish-asdf"

# Setup coding folders
mkdir -p ~/coding

# Setup Fish
mkdir -p ~/.config/fish/configs
cp fish/aliases.fish ~/.config/fish/configs/aliases.fish
cp fish/env.fish ~/.config/fish/configs/env.fish
cp fish/functions.fish ~/.config/fish/configs/functions.fish
cp fish/init.fish ~/.config/fish/config.fish
fish -c "set -U fish_user_paths /opt/homebrew/bin $fish_user_paths"
chsh -s $(which fish)

# Setup GIT
cp          git/gitignore        ~/.gitignore
cp          git/gitconfig_global ~/.gitconfig_global

# Setup [NVIM](https://github.com/LunarVim/Launch.nvim)
git clone https://github.com/LunarVim/Launch.nvim.git ~/.config/nvim

# Done with the configs
cd ..

echo "Happy Coding"
