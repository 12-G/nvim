local conf = require('modules.ui.config')

return {
    {
        'nvimdev/zephyr-nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require 'zephyr'
        end,
    },
    {
        'nvimdev/galaxyline.nvim',
        event = 'BufEnter',
        config = conf.galaxyline,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        -- 'akinsho/bufferline.nvim',
        -- event = "BufEnter",
        -- keys = { 
        --     { "<C-w>", "<cmd>bd<CR>" },
        --     { "<C-h>", ":BufferLineCyclePrev<CR>" },
        --     { "<C-l>", ":BufferLineCycleNext<CR>" },
        -- },
        -- config = true
    },
    {
        'nvimdev/indentmini.nvim',
        event = 'BufEnter',
        config = conf.indentmini
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = conf.dashboard,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
}
