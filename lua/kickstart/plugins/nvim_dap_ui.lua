return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  commit = '5934302d63d1ede12c0b22b6f23518bb183fc972',
  config = function()
    local dapui = require 'dapui'
    local dap = require 'dap'

    -- For some reason I have to call this here explicitly?
    dapui.setup {
      controls = {
        enabled = true,
      },
      expand_lines = true,
      icons = { expanded = '', collapsed = '', circular = '', current_frame = '*' },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r', toggle = 't',
      },
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.33 },
            { id = 'stacks', size = 0.17 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 0.25,
          position = 'right',
        },
        {
          elements = {
            { id = 'repl', size = 0.25 },
            { id = 'console', size = 0.70 },
          },
          size = 0.25,
          position = 'bottom',
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    vim.keymap.set('n', '<leader>de', "<cmd>require('dapui').eval()<CR>", { desc = 'Evaluate expression' })
    vim.keymap.set('n', '<leader>dh', require('dap.ui.widgets').hover, { desc = 'Hover element' })
    vim.keymap.set('n', '<leader>dp', require('dap.ui.widgets').preview, { desc = 'Preview element' })
    vim.keymap.set('n', '<leader>df', "<cmd>require('dap.ui.widgets').float()<CR>", { desc = 'Float element' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = function()
      require('dapui').close()
      vim.cmd ":lua require'dap'.close()"
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      require('dapui').close()
      vim.cmd ":lua require'dap'.close()"
    end
  end,
  opts = {
    controls = {
      enabled = true,
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
    expand_lines = true,
    icons = { expanded = '', collapsed = '', circular = '', current_frame = '*' },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { '<CR>', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      edit = 'e',
      repl = 'r',
      toggle = 't',
    },
    layouts = {
      {
        elements = {
          { id = 'breakpoints', size = 0.33 },
          { id = 'stacks', size = 0.33 },
          { id = 'watches', size = 0.33 },
        },
        size = 0.25,
        position = 'right',
      },
      {
        elements = {
          { id = 'repl', size = 0.25 },
          { id = 'console', size = 0.70 },
        },
        size = 0.25,
        position = 'bottom',
      },
    },
    floating = {
      max_height = 0.9,
      max_width = 0.5, -- Floats will be treated as percentage of your screen.
      border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
      mappings = {
        close = { 'q', '<Esc>' },
      },
    },
  },
}
