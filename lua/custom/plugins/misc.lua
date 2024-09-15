-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
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
    opts = {
      forward_key = '<C-S-Tab>',
      backward_key = '<C-Tab>',
    },
  },
}
