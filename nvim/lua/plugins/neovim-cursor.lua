return {
  -- dir = '/users/felix/github/neovim-cursor', -- local
  "felixcuello/neovim-cursor", -- oficial
  name = 'neovim-cursor',
  config = function()
    require('neovim-cursor').setup({
      keymap = '<leader>ai',  -- change to whatever you want!
      -- Terminal split configuration
      split = {
        position = "right",  -- "right", "left", "top", "bottom"
        size = 0.8,          -- 50% of editor width/height (0.0-1.0)
      },
    })
  end,
}
