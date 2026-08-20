return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true,
  lazy = false,
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal", mode = { 'i', 'n', 't', 'v' } },
  },
  opts = {
    float_opts = {
      border = "single",
      width = function()
        return math.floor(vim.o.columns * 0.99)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.99)
      end,
    },
  },
}
