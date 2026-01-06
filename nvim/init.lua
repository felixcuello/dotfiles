-------------------------------------------------------------------------------
-- Neovim 0.11 configuration
-------------------------------------------------------------------------------
local vim = vim

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


require('config.general')                          -- General vim configurations
require('config.remaps')                           -- Keymaps
require('config.lazy')                             -- Load Lazy plugin manager
require('config.lsp')                              -- LSP configurations

-- vim.cmd('colorscheme cyberdream')
-- vim.cmd('colorscheme cyberdream-light')
-- vim.cmd('colorscheme catppuccin-mocha')
vim.cmd('colorscheme ofirkai-darkblue')
