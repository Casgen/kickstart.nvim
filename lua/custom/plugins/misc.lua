return {
  {
    'tpope/vim-fugitive',
  },
  {
    'ThePrimeagen/vim-be-good',
    event = 'VimEnter',
  },
  {
    'kwkarlwang/bufjump.nvim',
    config = function()
      vim.keymap.set('n', '<C-O>', "<cmd>lua require('bufjump').backward()<CR>")
      vim.keymap.set('n', '<C-I>', "<cmd>lua require('bufjump').forward()<CR>")
    end,
  },
}
