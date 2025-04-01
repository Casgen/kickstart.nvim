return {
  'cbochs/grapple.nvim',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    scope = 'git',
    win_opts = {
      width = 120,
      height = 16,
    },
  },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<leader>n', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
    { '<leader>p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
  },
}
