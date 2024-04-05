-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local mason_dap = require 'mason-nvim-dap'

    mason_dap.setup {
      automatic_installation = true,
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debbgging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F4>', dap.run_to_cursor, { desc = 'Debug: Run to cursor' })
    vim.keymap.set('n', '<F5>', dap.terminate, { desc = 'Debug: Terminate session' })
    vim.keymap.set('n', '<F6>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- CPP debugger setup for the MeshAndTaskShaders project
    --
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    --
    dap.adapters.cppdbg = {
      type = 'executable',
      command = '/home/oem/.local/share/nvim/mason/bin/OpenDebugAD7',
      id = 'cppdbg',
    }

    dap.adapters.python = {
      type = 'executable',
      command = 'python3',
      args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations.python = {
      {
        name = 'Python: Current File',
        type = 'python',
        request = 'launch',
        program = '${file}',
        console = 'integratedTerminal',
        cwd = '${workspaceFolder}',
        justMyCode = true,
      },
    }

    dap.configurations.odin = {
      {
        type = 'codelldb',
        name = 'Run 8086-sim',
        request = 'launch',
        program = '${workspaceFolder}/build/8086sim',
        args = {},
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.cpp = {
      {
        name = '(gdb) Launch',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/Debug-linux-x86_64/MeshAndTaskShaders/MeshAndTaskShaders',
        args = {},
        stopAtEntry = false,
        cwd = '${workspaceFolder}',
        environment = {},
        MIMode = 'gdb',
        preLaunchTask = './BuildAndCompile.sh',
        setupCommands = {
          {
            description = 'Enable pretty-printing for gdb',
            text = '-enable-pretty-printing',
            ignoreFailures = true,
          },
          {
            description = 'Set Disassembly Flavor to Intel',
            text = '-gdb-set disassembly-flavor intel',
            ignoreFailures = true,
          },
        },
      },
    }

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
