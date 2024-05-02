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

    config = function()
      require('lualine').setup {
        sections = {
          lualine_b = { 'grapple' },
        },
      }
    end,
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
  {
    'ThePrimeagen/vim-be-good',
    event = 'VimEnter',
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      vim.keymap.set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { desc = 'Opens the trouble quickfix list' }),
      vim.keymap.set('n', '<leader>t', '<cmd>TroubleToggle<CR>', { desc = 'Opens the trouble quickfix list' }),
    },
  },
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = {
      'BufReadPre /media/oem/MoreStuff/ObsidianVault/MyVault/**.md',
      'BufNewFile /media/oem/MoreStuff/ObsidianVault/MyVault/**.md',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian').setup {
        dir = '/media/oem/MoreStuff/ObsidianVault/MyVault',
        notes_subdir = 'Zettelkasten',
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        new_notes_location = 'notes_subdir',
        disable_frontmatter = true,
        templates = {
          subdir = 'Templates',
          date_format = '%Y-%m-%d',
          time_format = '%H:%M:%S',
        },
        mappings = {},
        ui = {
          enable = true,
        },
      }

      vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNew<CR>', { desc = 'Obsidian: Create a new note' })
      vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTemplate<CR>', { desc = 'Obsidian: Insert a template into the nose using telescope.nvim' })
      vim.keymap.set('n', '<leader>of', '<cmd>ObsidianFollowLink<CR>', { desc = 'Obsidian: Follow a note reference under the cursor' })

      -- ["<leader>on"] = {"<cmd>ObsidianNew<CR>", "Create a new note"},
      -- ["<leader>ot"] = {"<cmd>ObsidianTemplate<CR>", "Insert a template into the note using telescope.nvim"},
      -- ["<leader>of"] = {"<cmd>ObsidianFollowLink<CR>", "Follow a note reference below the cursor"},
    end,
  },
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
      scope = 'git',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
      { '<leader>n', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
      { '<leader>p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
    },
  },
}
