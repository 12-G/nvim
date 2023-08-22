local conf = require('modules.editor.config')

return {
    {
        'nvim-telescope/telescope.nvim',
        config = conf.telescope,
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-file-browser.nvim',
        },
        keys = {
            { "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>" },
            { "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>" },
            { "<leader>b", "<cmd>Telescope buffers<CR>" },
            { "<leader>o", "<cmd>Telescope oldfiles<CR>" },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        build = ':TSUpdate',
        config = conf.treesitter,
    },
}
