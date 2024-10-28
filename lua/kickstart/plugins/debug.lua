return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
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

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

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

    dap.configurations.cs = {
      {
        name = '.NET Core Launch (web)',
        type = 'coreclr',
        request = 'launch',
        program = '${workspaceFolder}/src/SIE.Backend.HttpApi.Host/bin/Debug/net8.0/SIE.Backend.HttpApi.Host.dll',
        cwd = '${workspaceFolder}/src/SIE.Backend.HttpApi.Host/',
		args = {'--launch-profile "Development"'},
        stopAtEntry = false,
        serverReadyAction = {
          action = 'openExternally',
          pattern = '\\bNow listening on:\\s+(https?://\\S+)',
        },
        env = {
          ASPNETCORE_ENVIRONMENT = 'Development',
        },
      },
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
        name = 'Run Pacman',
        request = 'launch',
        program = '${workspaceFolder}/build/pacman',
        args = {},
        cwd = '${workspaceFolder}',
      },
      {
        type = 'codelldb',
        name = 'Run 8086-sim',
        request = 'launch',
        program = '${workspaceFolder}/build/8086sim',
        preLaunchTask = 'odin build ./src/main.odin -file -debug -out:build/8086sim',
        args = {},
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.zig = {
      {
        type = 'codelldb',
        name = 'Run Repeat Test',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/repeat_test',
        args = {},
        cwd = '${workspaceFolder}',
      },
      {
        type = 'codelldb',
        name = 'Run Haversine',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/haversine',
        args = { '--parse', './pairs.json' },
        cwd = '${workspaceFolder}',
      },
      {
        type = 'codelldb',
        name = 'Run Timer',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/timer',
        args = {},
        cwd = '${workspaceFolder}',
      },
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

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
