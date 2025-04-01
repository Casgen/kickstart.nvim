return {
  'mfussenegger/nvim-dap',
  lazy = true,
  dependencies = {
    'williamboman/mason.nvim',
    'rcarriga/nvim-dap-ui',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<F4>',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Run to cursor',
    },
    {
      '<F5>',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate session',
    },
    {
      '<F6>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint With Condition',
    },
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

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

    dap.adapters.cppdbg = {
      type = 'executable',
      command = '/home/joseff/.local/share/nvim/mason/bin/OpenDebugAD7',
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
        command = '/home/joseff/.local/share/nvim/mason/bin/codelldb',
        args = { '--port', '13000' },
      },
    }

    dap.adapters.coreclr = {
      type = 'executable',
      command = '/home/joseff/.local/share/nvim/mason/bin/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
      {
        name = '.NET Core Launch (web)',
        type = 'coreclr',
        request = 'launch',
        program = '${workspaceFolder}/src/SIE.Backend.HttpApi.Host/bin/Debug/net8.0/SIE.Backend.HttpApi.Host.dll',
        cwd = '${workspaceFolder}/src/SIE.Backend.HttpApi.Host/',
        args = { '--launch-profile "Development"' },
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
        type = 'cppdbg',
        name = 'Run Haversine (Generate Mode)',
        request = 'launch',
        program = '${workspaceFolder}/build/haversine',
        args = {
          "--generate",
          "10000",
          "2078890407461",
        },
        cwd = '${workspaceFolder}',
      },
      {
        type = 'cppdbg',
        name = 'Run Haversine (Parse Mode)',
        request = 'launch',
        program = '${workspaceFolder}/build/haversine',
        args = {
          "--parse",
          "pairs.json",
        },
        cwd = '${workspaceFolder}',
      },
      {
        type = 'cppdbg',
        name = 'Run Grappler',
        request = 'launch',
        program = '${workspaceFolder}/build/grappler',
        MIMode = 'gdb',
        args = {},
        cwd = '${workspaceFolder}',
      },
      -- {
      --   type = 'codelldb',
      --   name = 'Run 8086-sim',
      --   request = 'launch',
      --   program = '${workspaceFolder}/build/8086sim',
      --   preLaunchTask = 'odin build ./src/main.odin -file -debug -out:build/8086sim',
      --   args = {},
      --   cwd = '${workspaceFolder}',
      -- },
    }

    local aoc_bin_path = function()
      local dirs = vim.split(vim.fn.getcwd(), '/')
      return '${workspaceFolder}/zig-out/bin/' .. dirs[#dirs]
    end

    dap.configurations.zig = {
      -- {
      --   type = 'codelldb',
      --   name = 'Run AOC',
      --   request = 'launch',
      --   program = aoc_bin_path(),
      --   args = {},
      --   cwd = '${workspaceFolder}',
      -- },
      {
        type = 'codelldb',
        name = 'Run Haversine (Pairs Mode)',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/haversine',
        args = {
          "--parse",
          "pairs.json"
        },
        cwd = '${workspaceFolder}',
      },
      {
        type = 'codelldb',
        name = 'Run Haversine (Generate Mode)',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/haversine',
        args = {
          "pairs.json",
          "1238905929301",
        },
        cwd = '${workspaceFolder}',
      },
      {
        type = 'codelldb',
        name = 'Run MOV test',
        request = 'launch',
        program = '${workspaceFolder}/zig-out/bin/test-zig',
        args = {},
        cwd = '${workspaceFolder}',
      },
      -- {
      --   type = 'codelldb',
      --   name = 'Run Repeat Test',
      --   request = 'launch',
      --   program = '${workspaceFolder}/zig-out/bin/repeat_test',
      --   args = {},
      --   cwd = '${workspaceFolder}',
      -- },
      -- {
      --   type = 'codelldb',
      --   name = 'Run Haversine',
      --   request = 'launch',
      --   program = '${workspaceFolder}/zig-out/bin/haversine',
      --   args = { '--parse', './pairs.json' },
      --   cwd = '${workspaceFolder}',
      -- },
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
        name = '(gdb) Launch Cid2Code Parser',
        type = 'cppdbg',
        request = 'launch',
        program = '${workspaceFolder}/main',
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
    -- require('dap-go').setup {
    --   delve = {
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end,
}
