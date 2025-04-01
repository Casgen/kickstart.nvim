return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {"<A-i>", "<cmd>ToggleTerm<CR>", desc = 'Toggles the terminal window'}
  },
  opts = {
    direction = 'float',
    size = 40,
    dir = '$(pwd)',
    name = 'Terminal',
  },
}
