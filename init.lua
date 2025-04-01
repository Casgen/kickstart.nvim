require 'custom.options'
require 'custom.keymaps'
require 'custom.autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
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
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPost',
    opts = {
      sticky = false,
    },
  },
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
    branch = '0.1.x',
    lazy = true,
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
    keys = {
      { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = '[S]earch [H]elp' },
      { '<leader>fk', '<cmd>Telescope keymaps<CR>', desc = '[S]earch [K]eymaps' },
      { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = '[S]earch [F]iles' },
      { '<leader>fs', '<cmd>Telescope builtin<CR>', desc = '[S]earch [S]elect Telescope' },
      { '<leader>fw', '<cmd>Telescope grep_string<CR>', desc = '[S]earch current [W]ord' },
      { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = '[S]earch by [G]rep' },
      { '<leader>fd', '<cmd>Telescope diagnostics<CR>', desc = '[S]earch [D]iagnostics' },
      { '<leader>fr', '<cmd>Telescope resume<CR>', desc = '[S]earch [R]esume' },
      { '<leader>f.', '<cmd>Telescope oldfiles<CR>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = '[ ] Find existing buffers' },
      { '<leader>hs', '<cmd>Telescope git_status<CR>', desc = 'Opens up a Git status telescope window' },
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
            height = 0.95,
          },
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
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      -- vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      -- vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      -- vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
      -- vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- vim.keymap.set('n', '<leader>hs', builtin.git_status, { desc = 'Opens up a Git status telescope window' })
      -- vim.keymap.set('n', '<leader>hs', builtin.git_status, { desc = 'Opens up a Git status telescope window' })

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
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',

      { 'j-hui/fidget.nvim', opts = {} },
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

          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
          })

          vim.lsp.handlers['textDocument/textDocument'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
          })

          local signs = { Error = '', Warn = '', Hint = '󰌶', Info = '' }

          for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        omnisharp = {
          cmd = { 'dotnet', '~/Dev/OmniSharp-Roslyn/OmniSharp.dll' },
          -- handlers = {
          --   ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
          --   ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
          --   ['textDocument/references'] = require('omnisharp_extended').references_handler,
          --   ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
          -- },
        },
        rust_analyzer = {},
        -- gopls = {},
        texlab = {},
        zls = {},
        clangd = {},
        ols = {},
        glsl_analyzer = {},
        -- pyright = {},
        ts_ls = {},
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
    lazy = true,
    keys = {
      {
        '<leader>fm',
        function()
          require('conform').format()
        end,
        desc = 'Format the current document',
      },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        csharp = { 'csharpier' },
        cpp = { 'clang_format' },
        css = { 'prettied' },
        python = { 'black' },
        markdown = { 'markdownlint' },
        go = { 'gofumpt' },
      },
      formatters = {
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. '/.prettierrc.js',
          },
        },
      },
    },
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

      -- Setup vim-dadbod completion
      -- cmp.setup.filetype({ 'sql' }, {
      --   sources = {
      --     { name = 'vim-dadbod-completion' },
      --     { name = 'buffer' },
      --   },
      -- })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'ts', 'tsx', 'js', 'jsx' },
    opts = {},
  },
  -- {
  --   'Everblush/nvim',
  --   name = 'everblush',
  --   config = function()
  --     require('everblush').setup {
  --       transparent_background = true,
  --       nvim_tree = {
  --         contrast = true,
  --       },
  --     }
  --     vim.cmd.colorscheme 'everblush'
  --   end,
  -- },
  {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require('everforest').setup {
        transparent_background_level = 1,
        background = 'hard',
        ui_contrast = 'high',
      }
      vim.cmd.colorscheme 'everforest'
    end,
  },
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   priority = 1000,
  --   config = function()
  --     local gruvbox = require 'gruvbox'
  --
  --     local is_transparent = true
  --
  --     gruvbox.setup {
  --       overrides = {
  --         SignColumn = is_transparent and { bg = nil } or { bg = gruvbox.palette.dark0_hard },
  --         CursorLineNr = is_transparent and { bg = nil } or { bg = gruvbox.palette.dark0_hard },
  --         CursorLine = is_transparent and { bg = nil } or { bg = gruvbox.palette.dark0_hard },
  --       },
  --       contrast = 'hard',
  --       transparent_mode = is_transparent,
  --     }
  --
  --     vim.cmd.colorscheme 'gruvbox'
  --     vim.o.background = 'dark'
  --   end,
  -- },
  -- {
  --   'eldritch-theme/eldritch.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require 'eldritch'.setup{}
  --     vim.cmd.colorscheme 'eldritch'
  --   end,
  -- },
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'echasnovski/mini.nvim',
    config = function()
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
    event = 'BufReadPre',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'vim', 'vimdoc', 'diff', 'luadoc' },
      highlight = {
        enable = true,
        disable = { 'latex' },
      },
      autotag = {
        enable = true,
        filetypes = { 'tsx' },
      },
      indent = { enable = true },
      ignore_install = { 'latex' },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
      vim.treesitter.language.register('glsl', { 'comp', 'vert', 'frag', 'geom' })
    end,
  },
  require 'kickstart.plugins.debug',
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
