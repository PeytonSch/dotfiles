#!/bin/bash

# remove current temp file
rm -r /mnt/g/Users/Peyton/Documents/Code/neovim/current

# save current as temp file
cp -r ~/.config/nvim /mnt/g/Users/Peyton/Documents/Code/neovim/current

# rm  nvim
rm -r /mnt/g/Users/Peyton/Documents/Code/neovim/nvim

# replace with files from conf
cp -r ~/.config/nvim /mnt/g/Users/Peyton/Documents/Code/neovim/nvim 

# Tmux
rm /mnt/g/Users/Peyton/Documents/Code/neovim/tmux/tmux.conf

cp ~/.config/tmux/tmux.conf /mnt/g/Users/Peyton/Documents/Code/neovim/tmux/tmux.conf

# scripts
rm /mnt/g/Users/Peyton/Documents/Code/neovim/tmux-sessionizer.sh

cp /mnt/g/Users/Peyton/Documents/Code/scripts/tmux-sessionizer.sh /mnt/g/Users/Peyton/Documents/Code/neovim/tmux-sessionizer.sh 
