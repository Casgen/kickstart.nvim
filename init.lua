-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.cmd 'set wrap!'
vim.cmd 'set autoindent'

vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- vim.g.XkbSwitchEnabled = 1
-- vim.g.XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
--
-- vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
--   pattern = { '*.md' },
--   callback = function()
--     vim.wo.conceallevel = 2
--   end,
-- })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>hl', '<cmd>set hlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move cursor in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move cursor left in insert mode' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move cursor down in insert mode' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move cursor up in insert mode' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move cursor right in insert mode' })

vim.keymap.set('n', '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy whole file' })

-- Quickfix list commands
vim.keymap.set('n', '<leader>cn', '<cmd>cnext<CR>', { desc = 'Go to next reference in Quickfix list' })
vim.keymap.set('n', '<leader>cp', '<cmd>cprev<CR>', { desc = 'Go to previous reference in Quickfix list' })

-- Window resizing
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Shrink window horizontally' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Expand window horizontally' })
vim.keymap.set('n', '<C-Up>', '<cmd>resize -2<CR>', { desc = 'Shring window vertically' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize +2<CR>', { desc = 'Expand window vertically' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<A-i>', '<cmd>ToggleTermToggleAll<CR>', { desc = 'Toggle terminal' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'k', 'gk', { desc = 'Move cursor up respecting wrap' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Move cursor down respecting wrap' })
vim.keymap.set('n', '<C-b>', 'ge', { desc = 'Move cursor by a word to the left leaving the cursor at the last word char.' })

-- Better paste (duh)
vim.keymap.set('v', 'p', '"_dP', { desc = 'Better paste' })
vim.keymap.set('n', '<leader>xb', '<cmd>bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>x', vim.api.nvim_win_close, { desc = 'Close current window' })

vim.keymap.set('v', '<', '<gv', { desc = 'Tab right and stay in indent mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Tab left and stay in indent mode' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next occurence and center windowd' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to prev occurence and center windowd' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Turn off automatic commenting on next lines',
  group = vim.api.nvim_create_augroup('disable-automatic-commenting', { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
  { 'numToStr/Comment.nvim', opts = {
    sticky = false,
  } },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            n = {
              ['dd'] = require('telescope.actions').delete_buffer,
            },
          },
          layout_strategy = 'vertical',
          layout_config = {
            height = 0.95
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>hs', builtin.git_status, { desc = 'Opens up a Git status telescope window' })
      vim.keymap.set('n', '<leader>hs', builtin.git_status, { desc = 'Opens up a Git status telescope window' })

      vim.keymap.set('n', '<leader>f/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- This removes the default autoformatting when saving a file with the Zig's ZLS language server.
      vim.g.zig_fmt_autosave = 0

      vim.keymap.set('n', '<leader>cs', '<cmd>ClangdSwitchSourceHeader<CR>', { desc = 'Switch between header and source file in C++' })
      vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, { desc = 'Signature help' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          --
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', function()
            vim.lsp.buf.rename()
            vim.cmd 'wa'
          end, '[R]e[n]ame')

          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        omnisharp = {
          cmd = { 'dotnet', '/home/oem/Development/OmniSharp-Roslyn/OmniSharp.dll' },
          -- handlers = {
          --   ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
          --   ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
          --   ['textDocument/references'] = require('omnisharp_extended').references_handler,
          --   ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
          -- },
        },
        markdownlint = {},
        gopls = {},
        cssls = {},
        texlab = {},
        zls = {},
        clangd = {},
        ols = {},
        pyright = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    config = function()
      local conform = require 'conform'

      conform.setup {
        notify_on_error = false,
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          typescriptreact = { 'prettierd' },
          cpp = { 'clang_format' },
          css = { 'prettied' },
          python = { 'black' },
          markdown = { 'markdownlint' },
        },
      }

      vim.keymap.set('n', '<leader>fm', conform.format, { desc = 'Format the current document' })

      conform.formatters.prettierd = {
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. '/.prettierrc.js',
        },
      }
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
      },
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['<C-Space>'] = cmp.mapping.complete {},
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- {
  --   'Everblush/nvim',
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'everblush'
  --     vim.cmd.hi 'Comment gui=none'
  --     vim.cmd 'hi LineNr guibg=none guifg=#4F4F4F'
  --     vim.cmd 'hi CursorLineNr guibg=none guifg=#7F7F7F'
  --
  --     require('everblush').setup {
  --       {
  --         transparent_background = false,
  --
  --         override = {
  --           LineNr = { guifg = '#FFFFFF', guibg = '#FFFFFFF' },
  --         },
  --
  --         nvim_tree = {
  --           contrast = true,
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      local gruvbox = require 'gruvbox'

      gruvbox.setup {
        overrides = {
          SignColumn = { bg = gruvbox.palette.dark0_hard },
          CursorLineNr = { bg = gruvbox.palette.dark0_hard },
          CursorLine = { bg = gruvbox.palette.dark0_hard },
        },
        contrast = 'hard',
      }

      vim.cmd.colorscheme 'gruvbox'
      vim.o.background = 'dark'
    end,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'vim', 'vimdoc' },
      highlight = {
        enable = true,
        disable = { 'latex' },
      },
      indent = { enable = true },
      ignore_install = { 'latex' },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      vim.treesitter.language.register('glsl', { 'nv.mesh', 'nv.task', 'mesh', 'task', 'frag', 'vert', 'tesc', 'tese', 'geom', 'comp' })
    end,
  },
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.nvim_dap_ui',
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
