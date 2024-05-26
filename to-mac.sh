#!/bin/zsh

# remove current temp file
rm -r /Users/schepe2/Documents/nvChadCustom/current

# save current as temp file
cp -r ~/.config/nvim /Users/schepe2/Documents/nvChadCustom/current

# rm  nvim
rm -r ~/.config/nvim

# replace with files from repo
cp -r /Users/schepe2/Documents/nvChadCustom/nvim ~/.config/
