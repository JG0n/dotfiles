return {
    -- { "folke/neodev.nvim", opts = {} },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        }
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go"
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup({})

            require("dap-go").setup({})

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

            vim.keymap.set('n', '<F5>', dap.continue, {desc = 'Debug continue'})
            vim.keymap.set('n', '<F10>', dap.step_over, {desc = 'Debug step over'})
            vim.keymap.set('n', '<F11>', dap.step_into, {desc = 'Debug step into'})
            vim.keymap.set('n', '<F12>', dap.step_out, {desc = 'Debug step out'})
            vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, {desc = 'Debug toggle breakpoint'})
            vim.keymap.set('n', '<Leader>dB', dap.set_breakpoint, {desc = 'Debug breakpoint'})
            vim.keymap.set('n', '<Leader>dlp', function () require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {desc = 'Debug log point message'})
            vim.keymap.set('n', '<Leader>dr', dap.repl.open, {desc = 'Debug repl open'})
            vim.keymap.set('n', '<Leader>dl', dap.run_last, {desc = 'Debug reun last'})
            -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
            --     require('dap.ui.widgets').hover()
            -- end)
            -- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
            --     require('dap.ui.widgets').preview()
            -- end)
            -- vim.keymap.set('n', '<Leader>df', function()
            --     local widgets = require('dap.ui.widgets')
            --     widgets.centered_float(widgets.frames)
            -- end)
            -- vim.keymap.set('n', '<Leader>ds', function()
            --     local widgets = require('dap.ui.widgets')
            --     widgets.centered_float(widgets.scopes)
            -- end)
        end
    }
}
