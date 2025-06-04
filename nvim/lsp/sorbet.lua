--
-- LSP Configuration for Sorbet
--
return {
  cmd = { "srb", "tc", "--lsp" },
  root_markers = { 'Gemfile', '.git' },
  filetypes = { 'ruby' },
  init_options = {
    formatting = {
      format = 'rubocop',
      rubocop_config = '.rubocop.yml',
    },
  },
  settings = {
    init_options = {
      highlightUntyped = true,
    },
  },
}
