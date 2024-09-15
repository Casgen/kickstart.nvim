return {
  'alexghergh/nvim-tmux-navigation',
  event = 'VimEnter',
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    nvim_tmux_nav.setup {
      disable_when_zoomed = true,
    }

    vim.keymap.set('n', '<C-h>', '<cmd>NvimTmuxNavigateLeft<CR>', { desc = 'Switch left to TMux Window' })
    vim.keymap.set('n', '<C-l>', '<cmd>NvimTmuxNavigateRight<CR>', { desc = 'Switch right to TMux Window' })
    vim.keymap.set('n', '<C-j>', '<cmd>NvimTmuxNavigateDown<CR>', { desc = 'Switch down to  TMux Window' })
    vim.keymap.set('n', '<C-k>', '<cmd>NvimTmuxNavigateUp<CR>', { desc = 'Switch up to TMux Window' })
  end,
}
