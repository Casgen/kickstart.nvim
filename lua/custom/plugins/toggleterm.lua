return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup()

    vim.keymap.set('n', '<A-i>', '<cmd>ToggleTerm size=40 dir=$(pwd) direction=float name=project<CR>', { desc = 'Opens a floating terminal' })
  end,
  opts = {
    direction = 'float',
  },
}
