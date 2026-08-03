return {
  -- dir = '/users/felix/github/neovim-agents', -- local
  "felixcuello/neovim-agents", -- oficial
  name = 'neovim-agents',
  config = function()
    require('neovim-agents').setup({
      -- Neovim 0.12 delivers Ctrl+/ as <C-/> (kitty keyboard protocol),
      -- whereas <=0.10 delivered it as <C-_>. Bind <C-/> as the primary toggle.
      keybinding = '<C-/>',
      -- Terminal split configuration
      split = {
        position = "right",  -- "right", "left", "top", "bottom"
        size = 1.0,          -- 50% of editor width/height (0.0-1.0)
      },
    })

    -- Fallback for terminals that still send Ctrl+/ as <C-_> (legacy 0x1f).
    vim.keymap.set({ 'n', 'v' }, '<C-_>', require('neovim-agents').normal_mode_handler, {
      desc = 'Toggle AI Agent terminal (legacy Ctrl+/)',
      silent = true,
    })
  end,
}
