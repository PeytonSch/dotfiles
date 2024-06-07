#!/bin/bash

# remove current temp file
rm -r /mnt/g/Users/Peyton/Documents/Code/neovim/current

# save current as temp file
cp -r ~/.config/nvim /mnt/g/Users/Peyton/Documents/Code/neovim/current

# rm  nvim
rm -r ~/.config/nvim

# replace with files from repo
cp -r /mnt/g/Users/Peyton/Documents/Code/neovim/nvim ~/.config/

# Tmux
rm ~/.config/tmux/tmux.conf

cp /mnt/g/Users/Peyton/Documents/Code/neovim/tmux/tmux.conf ~/.config/tmux/tmux.conf

# scripts
rm /mnt/g/Users/Peyton/Documents/Code/scripts/tmux-sessionizer.sh

cp /mnt/g/Users/Peyton/Documents/Code/neovim/tmux-sessionizer.sh /mnt/g/Users/Peyton/Documents/Code/scripts/tmux-sessionizer.sh
