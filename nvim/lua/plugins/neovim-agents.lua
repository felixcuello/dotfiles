return {
  dir = '/users/felix/github/neovim-agents', -- local
  -- "felixcuello/neovim-agents", -- oficial
  name = 'neovim-agents',
  config = function()
    require('neovim-agents').setup({
      keymap = '<leader>ai',  -- change to whatever you want!
      -- Terminal split configuration
      split = {
        position = "right",  -- "right", "left", "top", "bottom"
        size = 0.8,          -- 50% of editor width/height (0.0-1.0)
      },
    })
  end,
}
