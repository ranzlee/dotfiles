return {
  "mfussenegger/nvim-dap",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local neodev = require("neodev")
    local dapui = require("dapui")
    local dap_go = require("dap-go")

    dap.adapters.coreclr = {
      type = "executable",
      command = "~/.local/share/nvim/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
        end,
      },
    }

    dapui.setup()
    dap_go.setup()
    neodev.setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<F5>", function()
      dap.continue()
    end, { desc = " Debug start/run " })
    vim.keymap.set("n", "<F10>", function()
      dap.step_over()
    end, { desc = " Debug step over " })
    vim.keymap.set("n", "<F11>", function()
      dap.step_into()
    end, { desc = " Debug step into " })
    vim.keymap.set("n", "<F12>", function()
      dap.step_out()
    end, { desc = " Debug step out " })
    vim.keymap.set("n", "<Leader>db", function()
      dap.toggle_breakpoint()
    end, { desc = " Debug toggle breakpoint " })
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint()
    end, { desc = " Debug set breakpoint " })
    vim.keymap.set("n", "<Leader>dp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = " Debug set breakpoint / message " })
    vim.keymap.set("n", "<Leader>dr", function()
      dap.repl.open()
    end, { desc = " Debug REPL open " })
    vim.keymap.set("n", "<Leader>dl", function()
      dap.run_last()
    end, { desc = " Debug run last " })
    -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    --   require('dap.ui.widgets').hover()
    -- end)
    -- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    --   require('dap.ui.widgets').preview()
    -- end)
    -- vim.keymap.set('n', '<Leader>df', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.frames)
    -- end)
    -- vim.keymap.set('n', '<Leader>ds', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.scopes)
    -- end)
  end,
}
