---------------------------------------------------------------------------------------------------------------------
--- Keymaps
---------------------------------------------------------------------------------------------------------------------
local vim = vim

vim.keymap.set('n', '<leader>q', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match('neo%-tree') then
    vim.cmd('Neotree close')
    vim.cmd('bdelete')
    vim.cmd('Neotree show')
  else
    vim.cmd('bdelete')
  end
end)

vim.keymap.set('n', '<leader>Q', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match('neo%-tree') then
    vim.cmd('Neotree close')
    vim.cmd('bdelete!')
  else
    vim.cmd('bdelete!')
  end
end)

vim.keymap.set("v", "<D-c>", "\"+y")                                             -- Copy to MacOS clipboard
vim.keymap.set("i", "<D-v>", "<Esc>k\"+p<Esc>i")                                  -- Paste from MacOS clipboard
vim.keymap.set("n", "<D-v>", "k\"+p")                                             -- Paste from MacOS clipboard

vim.keymap.set("n", "<leader>tt", ":Telescope<Cr>")                              -- Toggle telescope
vim.keymap.set("v", "<leader>tt", ":Telescope<Cr>")                              -- Toggle telescope

vim.keymap.set("v", "<leader>y", "\"+y")                                         -- Copy to MacOS clipboard

vim.keymap.set("v", "<S-DOWN>", ":m '>+1<CR>gv=gv")                              -- Move block down
vim.keymap.set("v", "<S-UP>", ":m '<-2<CR>gv=gv")                                -- Move block up

vim.keymap.set("n", "<C-x>1", "<C-w>o")                                          -- Close all other windows

vim.keymap.set("n", "<leader>gt", ":GitBlameToggle<Cr>")                         -- ToggleBlame
vim.keymap.set("n", "<leader>gy", ":GitBlameCopyFileURL<Cr>")                    -- Copy file URL to clipboard
vim.keymap.set("v", "<leader>gy", ":GitBlameCopyFileURL<Cr>")                    -- Copy file URL to clipboard
vim.keymap.set("v", "<leader>gY", ":GitBlameOpenFileURL<Cr>")                    -- Copy file URL to clipboard
