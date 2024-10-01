-- ~/.config/nvim/after/plugin/dap.lua

local dap = require('dap')
local dapui = require('dapui')

-- Configure DAP Adapter for GDB
dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',  -- Ensure gdb is in your PATH or provide the full path
    name = 'gdb',
}

-- Configure DAP for STM32 with GDB
dap.configurations.c = {
    {
        name = "PlatformIO Debug with GDB",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/.pio/build/<target>/firmware.elf', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        setupCommands = {
            {
                description = "Enable pretty-printing for gdb",
                text = "-enable-pretty-printing",
                ignoreFailures = false
            }
        },
    },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

-- Key mappings for DAP
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })

-- Open DAP UI automatically
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

