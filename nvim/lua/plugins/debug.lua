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
    -- 'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        cppdbg = function(config)
          config.configurations = {
            {
              name = 'Launch File',
              type = 'cppdbg',
              request = 'launch',
              program = function()
                return vim.fn.input({ prompt = 'Path to executable: ', default = vim.fn.getcwd() .. '/', completion = 'file' })
              end,
              args = function()
                local args_string = vim.fn.input('Input arguments: ')
                return vim.split(args_string, ' ')
              end,
              cwd = '${workspaceFolder}',
            },
            -- {
            --   name = 'Attach to gdbserver :1234',
            --   type = 'cppdbg',
            --   request = 'launch',
            --   MIMode = 'gdb',
            --   miDebuggerServerAddress = 'localhost:1234',
            --   miDebuggerPath = '/usr/bin/gdb',
            --   program = function()
            --     return vim.fn.input({ prompt = 'Path to executable: ', default = vim.fn.getcwd() .. '/', completion = 'file' })
            --   end,
            --   args = function()
            --     local args_string = vim.fn.input('Input arguments: ')
            --     return vim.split(args_string, ' ')
            --   end,
            --   cwd = '${workspaceFolder}',
            -- },
          }
          require('mason-nvim-dap').default_setup(config)
        end
      },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Debug: [D]AP [H]over' })
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'Debug: [D]AP [P]review' })
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, { desc = 'Debug: [D]AP [F]rames' })
    vim.keymap.set('n', '<Leader>dl', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Debug: [D]AP [L]ocals' })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'dap-float',
      callback = function(opts)
        vim.keymap.set('n', 'q', ':q!<cr>', { silent = true, buffer = true })
        vim.keymap.set('n', '<esc>', ':q!<cr>', { silent = true, buffer = true })
      end
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = 'h',
          play = '▶',
          step_into = '↳',
          step_over = '→',
          step_out = '↱',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '■',
          disconnect = 'x',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()
  end,
}

