--
-- LSP Configuration for Ruby
return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_dir = function()
    return vim.loop.cwd()
  end,
}
