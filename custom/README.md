You can simlink this custom file from the git repo to your nvim config dir :)
To avoid too many paths error, make the source path absolute. For example:

```
cd /home/schepe2/.config/nvim/lua 
ln -s /mnt/g/Users/Peyton/Documents/Code/neovim/custom/ ./ 
```
