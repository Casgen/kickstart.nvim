-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
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
  },
  {
    'nvim-tree/nvim-tree.lua',
    event = 'VimEnter',
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true
      -- OR setup with some options
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          git_ignored = false,
          dotfiles = false,
        },
      }

      vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NVim tree' })
    end,
    keys = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup()

      vim.keymap.set('n', '<A-i>', '<cmd>ToggleTerm size=40 dir=$(pwd) direction=float name=project<CR>', { desc = 'Opens a floating terminal' })
    end,
    opts = {
      direction = 'float',
    },
  },
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      lang = 'go',
    },
  },
}
