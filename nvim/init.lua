-------------------------------------------------------------------------------
-- Neovim 0.11 configuration
-------------------------------------------------------------------------------
local vim = vim

require('config.general')                          -- General vim configurations
require('config.remaps')                           -- Keymaps
require('config.lazy')                             -- Load Lazy plugin manager
require('config.lsp')                              -- LSP configurations

vim.cmd('colorscheme cyberdream')
