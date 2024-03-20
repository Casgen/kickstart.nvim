return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    local dapui = require 'dapui'
    local dap = require 'dap'

    -- For some reason I have to call this here explicitly?
    dapui.setup()

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
      vim.cmd ":lua require'dap'.close()"
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
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
          { id = 'scopes', size = 0.33 },
          { id = 'breakpoints', size = 0.17 },
          { id = 'stacks', size = 0.25 },
          { id = 'watches', size = 0.25 },
        },
        size = 0.25,
        position = 'left',
      },
      {
        elements = {
          { id = 'repl', size = 0.50 },
          { id = 'console', size = 0.50 },
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
