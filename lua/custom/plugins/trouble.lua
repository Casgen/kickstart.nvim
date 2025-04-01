return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>t', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Opens the trouble quickfix list' },
  },
}
