--
-- LSP Configurations
--
-- Configurations for LSP servers and their capabilities, can be found in the
-- LSPConfig configuration -> https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
--
local vim = vim

------------------------------------------------------------------------------------
-- All my LSP clients
------------------------------------------------------------------------------------
vim.lsp.enable('clangd')                            -- C/C++ language server
vim.lsp.enable('dockerls')                          -- Docker language server
vim.lsp.enable('gopls')                             -- Go language server
vim.lsp.enable('luals')                             -- LUA LSP server
vim.lsp.enable('pyright')                           -- Python language server
vim.lsp.enable('rubocop')                           -- Ruby language server
vim.lsp.enable('ruby_lsp')                          -- Ruby language server
vim.lsp.enable('rust_analyzer')                     -- Rust language server
vim.lsp.enable('sorbet')                            -- Sorbet language server
vim.lsp.enable('sqlls')                             -- SQL language server
vim.lsp.enable('texlab')                            -- LaTeX language server
vim.lsp.enable('tsls')                              -- TypeScript language server


------------------------------------------------------------------------------------
--- Blink CMP configuration
------------------------------------------------------------------------------------
vim.lsp.config("*", {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})


------------------------------------------------------------------------------------
--- Things that happens after the LSP is attached to the buffer
------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    --  if client:supports_method('textDocument/implementation') then
    --  -- Create a keymap for vim.lsp.buf.implementation ...
    --  end
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    -- if not client:supports_method('textDocument/willSaveWaitUntil')
    --     and client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
    --     buffer = args.buf,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
    --     end,
    --   })
    -- end
  end,
})
