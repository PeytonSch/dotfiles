require "peyton"
print "hello"

vim.g.mapleader = " "

-- Setup Lazy plugin manager

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- the setup argument, plugins, is the module name for
-- the module that contains my plugin spec
require("lazy").setup "plugins"
