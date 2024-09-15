return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    vim.keymap.set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { desc = 'Opens the trouble quickfix list' }),
    vim.keymap.set('n', '<leader>t', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Opens the trouble quickfix list' }),
  },
}
