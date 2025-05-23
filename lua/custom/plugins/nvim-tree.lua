return {
  'nvim-tree/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  keys = {
    { '<C-n>', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle NVim tree' },
  },
  opts = {
    sort = {
      sorter = 'case_sensitive',
    },
    update_focused_file = {
      enable = true,
    },
    view = {
      width = 30,
      relativenumber = true,
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * 0.8
          local window_h = screen_h * 0.5
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

          return {
            border = 'rounded',
            relative = 'editor',
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      git_ignored = false,
      dotfiles = false,
    },
  },
}
