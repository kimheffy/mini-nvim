return {
  {
    -- powerful git integration for vim
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gg', ':Git<CR>', { noremap = true })
    end,
  },
  {
    -- github integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
}
