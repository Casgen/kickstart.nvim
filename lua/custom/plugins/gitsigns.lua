return {
  'lewis6991/gitsigns.nvim',

  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    }

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        require('gitsigns.actions').nav_hunk 'next'
      end)
      return '<Ignore>'
    end, { expr = true })
    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        require('gitsigns.actions').nav_hunk 'prev'
      end)
      return '<Ignore>'
    end, { expr = true })
  end,
}
