return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local mason_dap = require 'mason-nvim-dap'

    mason_dap.setup {
      automatic_installation = true,
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
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

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

    dap.adapters.cppdbg = {
      type = 'executable',
      command = '/home/oem/.local/share/nvim/mason/bin/OpenDebugAD7',
      id = 'cppdbg',
    }

    dap.adapters.codelldb = {
      type = 'server',
      port = '13000',
      executable = {
        command = '/home/oem/.local/share/nvim/mason/bin/codelldb',
        args = { '--port', '13000' },
      },
    }

    dap.adapters.coreclr = {
      type = 'executable',
      command = '/home/oem/.local/share/nvim/mason/bin/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    -- CPP debugger setup for the MeshAndTaskShaders project
    dap.configurations.cpp = {
      {
        name = '(gdb) Launch Uglifier',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/uglifier',
        args = {},
        stopAtEntry = false,
        cwd = '${workspaceFolder}',
        environment = {},
        MIMode = 'gdb',
        setupCommands = {
          {
            description = 'Enable pretty-printing for gdb',
            text = '-enable-pretty-printing',
            ignoreFailures = true,
          },
        },
      },
      {
        name = '(gdb) Launch ClassicMeshLOD',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/Debug-linux-x86_64/ClassicMeshLOD/ClassicMeshLOD',
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
        },
      },
      {
        name = '(gdb) Launch Tesselation',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/Debug-linux-x86_64/Tesselation/Tesselation',
        args = {},
        stopAtEntry = false,
        cwd = '${workspaceFolder}',
        environment = {},
        MIMode = 'gdb',
        preLaunchTask = './${workspaceFolder}/BuildAndCompile.sh',
        setupCommands = {
          {
            description = 'Enable pretty-printing for gdb',
            text = '-enable-pretty-printing',
            ignoreFailures = true,
          },
        },
      },
      {
        name = '(gdb) Launch MeshLOD',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/Debug-linux-x86_64/MeshLOD/MeshLOD',
        args = {},
        stopAtEntry = false,
        cwd = '${workspaceFolder}',
        environment = {},
        MIMode = 'gdb',
        preLaunchTask = '${workspaceFolder}/BuildAndCompile.sh',
        setupCommands = {
          {
            description = 'Enable pretty-printing for gdb',
            text = '-enable-pretty-printing',
            ignoreFailures = true,
          },
        },
      },
      {
        name = '(gdb) Launch MeshInstancing',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/Debug-linux-x86_64/MeshInstancing/MeshInstancing',
        args = {},
        stopAtEntry = false,
        cwd = '${workspaceFolder}',
        environment = {},
        MIMode = 'gdb',
        preLaunchTask = '${workspaceFolder}/BuildAndCompile.sh',
        setupCommands = {
          {
            description = 'Enable pretty-printing for gdb',
            text = '-enable-pretty-printing',
            ignoreFailures = true,
          },
        },
      },
      {
        name = '(gdb) Launch MeshletCulling',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/bin/Debug-linux-x86_64/MeshletCulling/MeshletCulling',
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
        },
      },
    }

  end,
}
