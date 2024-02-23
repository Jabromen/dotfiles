#!/bin/bash

set -euo pipefail

cp --interactive ~/dotfiles/bootstrap/.gitconfig ~/.gitconfig
cp --interactive ~/dotfiles/bootstrap/.gitignore ~/.gitignore
cp --interactive ~/dotfiles/bootstrap/.zshrc ~/.zshrc
cp --interactive ~/dotfiles/bootstrap/.vimrc ~/.vimrc
cp --interactive ~/dotfiles/bootstrap/.tmux.conf ~/.tmux.conf
(cd ~/dotfiles/bootstrap && cp --interactive --parents fish/config.fish ~/.config)
ln --interactive -s ~/dotfiles/nvim ~/.config
