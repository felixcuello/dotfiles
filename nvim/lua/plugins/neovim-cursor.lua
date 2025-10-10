return {
  "felixcuello/neovim-cursor",
  name = 'neovim-cursor',
  config = function()
    require('neovim-cursor').setup({
      keymap = '<leader>ai',  -- change to whatever you want!
    })
  end,
}
