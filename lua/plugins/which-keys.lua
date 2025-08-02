return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = 'helix',
    delay = 300,
    icons = {
      rules = false,
      breadcrumb = ' ', -- symbol used in the command line area that shows your active key combo
      separator = '󱦰  ', -- symbol used between a key and it's label
      group = '󰹍 ', -- symbol prepended to a group
    },
    plugins = {
      spelling = {
        enabled = false,
      },
    },
    win = {
      height = {
        max = math.huge,
      },
    },
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>f', group = 'find' },
        { '<leader>d', group = 'debug' },
        { '<leader>g', group = 'git' },
        { '<leader>gf', group = 'diffview file' },
        { '<leader>gr', group = 'diffview repo' },
        { '<leader>gv', group = 'diffview range' },
        { '<leader>gl', group = 'diffview line' },
        { '<leader>h', group = 'gitsigns' },
        { '<leader>c', group = 'code' },
        { '<leader>x', group = 'location|quickfix lists' },
        { '<leader>u', group = 'ui' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { ',', group = 'term' },
        { ',f', group = 'term float' },
        { ',s', group = 'term save' },
        { ',S', group = 'term NOT save' },
      },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
