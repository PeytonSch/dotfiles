#!/bin/zsh

# remove current temp file
rm -r /Users/schepe2/Documents/nvChadCustom/current

# save old as temp file
cp -r /Users/schepe2/Documents/nvChadCustom/nvim /Users/schepe2/Documents/nvChadCustom/current

# rm old  nvim
rm -r /Users/schepe2/Documents/nvChadCustom/nvim

# replace with current
cp -r ~/.config/nvim /Users/schepe2/Documents/nvChadCustom/nvim

# Tmux
rm /Users/schepe2/Documents/nvChadCustom/tmux/tmux.conf

cp ~/.config/tmux/tmux.conf /Users/schepe2/Documents/nvChadCustom/tmux/tmux.conf

# scripts
rm /Users/schepe2/Documents/nvChadCustom/tmux-sessionizer.sh

cp /Users/schepe2/Documents/myscripts/tmux-sessionizer.sh /Users/schepe2/Documents/nvChadCustom/
