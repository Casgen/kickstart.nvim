return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      theme = 'everforest',
    },
    sections = {
      lualine_b = { 'branch', 'diagnostics' },
      -- lualine_c = { 'grapple', 'filename' },
    },
  }
}
