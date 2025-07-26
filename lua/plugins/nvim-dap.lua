return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'
    local present_dap_utils = pcall(require, 'dap.utils')

    require('dapui').setup()
    require('nvim-dap-virtual-text').setup()

    require('mason').setup()

    for _, adapterType in ipairs { 'node', 'chrome', 'msedge' } do
      local pwaType = 'pwa-' .. adapterType

      dap.adapters[pwaType] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      -- this allow us to handle launch.json configurations
      -- which specify type as "node" or "chrome" or "msedge"
      -- dap.adapters[adapterType] = function(cb, config)
      -- 	local nativeAdapter = dap.adapters[pwaType]
      --
      -- 	config.type = pwaType
      --
      -- 	if type(nativeAdapter) == "function" then
      -- 		nativeAdapter(cb, config)
      -- 	else
      -- 		cb(nativeAdapter)
      -- 	end
      -- end
    end

    local enter_launch_url = function()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:' }, function(url)
          if url == nil or url == '' then
            return
          else
            coroutine.resume(co, url)
          end
        end)
      end)
    end

    for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file using Node.js (nvim-dap)',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process using Node.js (nvim-dap)',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        -- requires ts-node to be installed globally or locally
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file using Node.js with ts-node/register (nvim-dap)',
          program = '${file}',
          cwd = '${workspaceFolder}',
          runtimeArgs = { '-r', 'ts-node/register' },
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch Chrome (nvim-dap)',
          url = enter_launch_url,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-msedge',
          request = 'launch',
          name = 'Launch Edge (nvim-dap)',
          url = enter_launch_url,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }
    end

    dap.adapters.codelldb = {
      type = 'executable',
      command = 'codelldb',
    }

    dap.configurations.rust = {
      {
        name = 'Launch Rust file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          vim.fn.system 'cargo build'
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dgb', dap.run_to_cursor, { desc = 'Run to cursor' })
    vim.keymap.set('n', '<leader>d?', function()
      require('dapui').eval(nil, { enter = true })
    end, { desc = 'Inspect the current value' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
    vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'Step into' })
    vim.keymap.set('n', '<leader>dso', dap.step_over, { desc = 'Step over' })
    vim.keymap.set('n', '<leader>dsO', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>dsb', dap.step_back, { desc = 'Step back' })
    vim.keymap.set('n', '<leader>dr', dap.restart, { desc = 'Restart' })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
