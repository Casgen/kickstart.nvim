return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('lualine').setup {
      options = {
        theme = 'gruvbox',
      },
      sections = {
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { 'grapple', 'filename' },
      },
    }
  end,
}