-- nvim-treesitter `main` is required for Neovim 0.12+
-- (`master` is frozen and incompatible).
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "arduino",
      "bash",
      "bibtex",
      "c",
      "cpp",
      "css",
      "csv",
      "cuda",
      "dockerfile",
      "elixir",
      "go",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gnuplot",
      "graphql",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "nginx",
      "python",
      "ruby",
      "rust",
      "scss",
      "sql",
      "terraform",
      "typescript",
      "vimdoc",
      "yaml",
    }

    local already_installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()

    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    -- Highlighting is no longer toggled via configs.setup; start it per buffer.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
