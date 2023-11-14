-- Randoragon's init.lua for NeoVim

package.path = "./?/init.lua;" .. package.path

vim.g.mapleader = ","

-- Shortcuts
map = vim.keymap.set
autocmd = vim.api.nvim_create_autocmd
augroup = function(name) vim.api.nvim_create_augroup(name, {clear=true}) end
o = vim.o
bo = vim.bo
wo = vim.wo

require("plugins")
require("options")
require("lsp")
require("misc")
require("mappings")
