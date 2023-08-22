local conf = require('modules.lsp.config')

return {
        "neovim/nvim-lspconfig",
        cmd = { "Mason" },
        event = {
            "BufRead",
            "BufNewFile",
            "BufWinEnter"
        },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig",
            "nvimdev/lspsaga.nvim",
        },
        config = conf.lsp,
}
