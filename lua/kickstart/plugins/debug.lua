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
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
    -- Show variable values inline like VSCODE or JetBrains
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function() -- This is the function that runs, AFTER loading
        require('nvim-dap-virtual-text').setup {
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        }
      end,
    },
    -- Show variable values inline like VSCODE or JetBrains
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function() -- This is the function that runs, AFTER loading
        require('nvim-dap-virtual-text').setup {
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        }
      end,
    },
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    -- 'mfussenegger/nvim-dap-python',
    -- 'mfussenegger/nvim-jdtls',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local home_dir = os.getenv 'HOME'

    require('mason-nvim-dap').setup {
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
        'debugpy',
        'codelldb',
        -- 'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F9>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F6>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F2>', dap.disconnect, { desc = 'Debug: Disconnect/Terminate' })
    vim.keymap.set('n', '<F3>', dapui.toggle, { desc = 'Toggle Debug view' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          -- pause = '⏸',
          -- play = '▶',
          -- step_into = '⏎',
          -- step_over = '⏭',
          -- step_out = '⏮',
          -- step_back = 'b',
          -- run_last = '▶▶',
          -- terminate = '⏹',
          -- disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Rust
    dap.adapters.lldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- Mac/Linux
        -- command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        -- Windows
        command = vim.fn.stdpath 'data' .. '/mason/mason/packages/codelldb/extension/adapter/codelldb.exe',
        args = { '--port', '${port}' },
        detached = false,
      },
    }
    dap.configurations.rust = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          -- Must be absolute path
          -- return vim.fn.input('Path to executable: ', 'D:/abc/xyz/rust/target/debug/', 'file')
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    -- require('dap-go').setup()

    -- Python setting for nvim-dap-python
    -- Windows path
    --require('dap-python').setup '~/.virtualenvs/debugpy/Scripts/python'
    -- Mac path
    -- require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'

    -- Java Remote Application
    -- dap.adapters.java = function(callback)
    --   -- FIXME:
    --   -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
    --   -- The response to the command must be the `port` used below
    --   callback {
    --     type = 'server',
    --     host = '127.0.0.1',
    --     -- host = 'localhost',
    --     port = 8888,
    --   }
    -- end
    -- dap.configurations.java = {
    --   {
    --     type = 'java',
    --     request = 'attach',
    --     name = 'Debug (Attach) - Remote',
    --     hostName = '127.0.0.1',
    --     -- hostName = 'localhost',
    --     port = 8888,
    --   },
    -- }

    -- -- C#
    -- dap.adapters.coreclr = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
    --   args = { '--interpreter=vscode' },
    -- }
    -- dap.configurations.cs = {
    --   {
    --     type = 'coreclr',
    --     name = 'launch - netcoredbg',
    --     request = 'launch',
    --     program = function() -- Ask the user what executable wants to debug
    --       return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Program.exe', 'file')
    --     end,
    --   },
    -- }

    -- -- F#
    -- dap.configurations.fsharp = dap.configurations.cs
    --
    -- -- Visual basic dotnet
    -- dap.configurations.vb = dap.configurations.cs

    -- Java
    -- Note: The java debugger jdtls is automatically spawned and configured
    -- when a java file is opened by the plugin nvim-java.

    -- Python
    dap.adapters.python = {
      type = 'executable',
      -- Mac/Linux
      -- command = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python',
      -- command = home_dir .. '/.virtualenvs/debugpy/bin/python',
      -- Windows
      command = home_dir .. '/.virtualenvs/debugpy/Scripts/python',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}', -- This configuration will launch the current file if used.
      },
    }
    --
    -- -- Lua
    -- dap.adapters.nlua = function(callback, config)
    --   callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
    -- end
    -- dap.configurations.lua = {
    --   {
    --     type = 'nlua',
    --     request = 'attach',
    --     name = 'Attach to running Neovim instance',
    --     program = function()
    --       pcall(require('osv').launch { port = 8086 })
    --     end,
    --   },
    -- }
    --
    -- -- C
    -- dap.adapters.codelldb = {
    --   type = 'server',
    --   port = '${port}',
    --   executable = {
    --     command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
    --     args = { '--port', '${port}' },
    --     detached = function()
    --       if is_windows then
    --         return false
    --       else
    --         return true
    --       end
    --     end,
    --   },
    -- }
    -- dap.configurations.c = {
    --   {
    --     name = 'Launch',
    --     type = 'codelldb',
    --     request = 'launch',
    --     program = function() -- Ask the user what executable wants to debug
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/bin/program', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = false,
    --     args = {},
    --   },
    -- }
    --
    -- -- C++
    -- dap.configurations.cpp = dap.configurations.c
    --
    -- -- Rust
    -- dap.configurations.rust = {
    --   {
    --     name = 'Launch',
    --     type = 'codelldb',
    --     request = 'launch',
    --     program = function() -- Ask the user what executable wants to debug
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/bin/program', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = false,
    --     args = {},
    --     initCommands = function() -- add rust types support (optional)
    --       -- Find out where to look for the pretty printer Python module
    --       local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
    --
    --       local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
    --       local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
    --
    --       local commands = {}
    --       local file = io.open(commands_file, 'r')
    --       if file then
    --         for line in file:lines() do
    --           table.insert(commands, line)
    --         end
    --         file:close()
    --       end
    --       table.insert(commands, 1, script_import)
    --
    --       return commands
    --     end,
    --   },
    -- }
    --
    -- -- Go
    -- -- Requires:
    -- -- * You have initialized your module with 'go mod init module_name'.
    -- -- * You :cd your project before running DAP.
    -- dap.adapters.delve = {
    --   type = 'server',
    --   port = '${port}',
    --   executable = {
    --     command = vim.fn.stdpath 'data' .. '/mason/packages/delve/dlv',
    --     args = { 'dap', '-l', '127.0.0.1:${port}' },
    --   },
    -- }
    -- dap.configurations.go = {
    --   {
    --     type = 'delve',
    --     name = 'Compile module and debug this file',
    --     request = 'launch',
    --     program = './${relativeFileDirname}',
    --   },
    --   {
    --     type = 'delve',
    --     name = 'Compile module and debug this file (test)',
    --     request = 'launch',
    --     mode = 'test',
    --     program = './${relativeFileDirname}',
    --   },
    -- }
    --
    -- -- Dart / Flutter
    -- dap.adapters.dart = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/dart-debug-adapter',
    --   args = { 'dart' },
    -- }
    -- dap.adapters.flutter = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/dart-debug-adapter',
    --   args = { 'flutter' },
    -- }
    -- dap.configurations.dart = {
    --   {
    --     type = 'dart',
    --     request = 'launch',
    --     name = 'Launch dart',
    --     dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/', -- ensure this is correct
    --     flutterSdkPath = '/opt/flutter', -- ensure this is correct
    --     program = '${workspaceFolder}/lib/main.dart', -- ensure this is correct
    --     cwd = '${workspaceFolder}',
    --   },
    --   {
    --     type = 'flutter',
    --     request = 'launch',
    --     name = 'Launch flutter',
    --     dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/', -- ensure this is correct
    --     flutterSdkPath = '/opt/flutter', -- ensure this is correct
    --     program = '${workspaceFolder}/lib/main.dart', -- ensure this is correct
    --     cwd = '${workspaceFolder}',
    --   },
    -- }
    --
    -- -- Kotlin
    -- -- Kotlin projects have very weak project structure conventions.
    -- -- You must manually specify what the project root and main class are.
    -- dap.adapters.kotlin = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/kotlin-debug-adapter',
    -- }
    -- dap.configurations.kotlin = {
    --   {
    --     type = 'kotlin',
    --     request = 'launch',
    --     name = 'Launch kotlin program',
    --     projectRoot = '${workspaceFolder}/app', -- ensure this is correct
    --     mainClass = 'AppKt', -- ensure this is correct
    --   },
    -- }
    --
    -- -- Javascript / Typescript (firefox)
    -- dap.adapters.firefox = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/firefox-debug-adapter',
    -- }
    -- dap.configurations.typescript = {
    --   {
    --     name = 'Debug with Firefox',
    --     type = 'firefox',
    --     request = 'launch',
    --     reAttach = true,
    --     url = 'http://localhost:4200', -- Write the actual URL of your project.
    --     webRoot = '${workspaceFolder}',
    --     firefoxExecutable = '/usr/bin/firefox',
    --   },
    -- }
    -- dap.configurations.javascript = dap.configurations.typescript
    -- dap.configurations.javascriptreact = dap.configurations.typescript
    -- dap.configurations.typescriptreact = dap.configurations.typescript
    --
    -- -- Javascript / Typescript (chromium)
    -- -- If you prefer to use this adapter, comment the firefox one.
    -- -- But to use this adapter, you must manually run one of these two, first:
    -- -- * chromium --remote-debugging-port=9222 --user-data-dir=remote-profile
    -- -- * google-chrome-stable --remote-debugging-port=9222 --user-data-dir=remote-profile
    -- -- After starting the debugger, you must manually reload page to get all features.
    -- -- dap.adapters.chrome = {
    -- --  type = 'executable',
    -- --  command = vim.fn.stdpath('data')..'/mason/bin/chrome-debug-adapter',
    -- -- }
    -- -- dap.configurations.typescript = {
    -- --  {
    -- --   name = 'Debug with Chromium',
    -- --   type = "chrome",
    -- --   request = "attach",
    -- --   program = "${file}",
    -- --   cwd = vim.fn.getcwd(),
    -- --   sourceMaps = true,
    -- --   protocol = "inspector",
    -- --   port = 9222,
    -- --   webRoot = "${workspaceFolder}"
    -- --  }
    -- -- }
    -- -- dap.configurations.javascript = dap.configurations.typescript
    -- -- dap.configurations.javascriptreact = dap.configurations.typescript
    -- -- dap.configurations.typescriptreact = dap.configurations.typescript
    --
    -- -- PHP
    -- dap.adapters.php = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/php-debug-adapter',
    -- }
    -- dap.configurations.php = {
    --   {
    --     type = 'php',
    --     request = 'launch',
    --     name = 'Listen for Xdebug',
    --     port = 9000,
    --   },
    -- }
    --
    -- -- Shell
    -- dap.adapters.bashdb = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
    --   name = 'bashdb',
    -- }
    -- dap.configurations.sh = {
    --   {
    --     type = 'bashdb',
    --     request = 'launch',
    --     name = 'Launch file',
    --     showDebugOutput = true,
    --     pathBashdb = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    --     pathBashdbLib = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    --     trace = true,
    --     file = '${file}',
    --     program = '${file}',
    --     cwd = '${workspaceFolder}',
    --     pathCat = 'cat',
    --     pathBash = '/bin/bash',
    --     pathMkfifo = 'mkfifo',
    --     pathPkill = 'pkill',
    --     args = {},
    --     env = {},
    --     terminalKind = 'integrated',
    --   },
    -- }
    --
    -- -- Elixir
    -- dap.adapters.mix_task = {
    --   type = 'executable',
    --   command = vim.fn.stdpath 'data' .. '/mason/bin/elixir-ls-debugger',
    --   args = {},
    -- }
    -- dap.configurations.elixir = {
    --   {
    --     type = 'mix_task',
    --     name = 'mix test',
    --     task = 'test',
    --     taskArgs = { '--trace' },
    --     request = 'launch',
    --     startApps = true, -- for Phoenix projects
    --     projectDir = '${workspaceFolder}',
    --     requireFiles = {
    --       'test/**/test_helper.exs',
    --       'test/**/*_test.exs',
    --     },
    --   },
    -- }
  end,
}
