local lspconfig = require("lspconfig")

local servers = {
	"bashls",
}

local on_attach = function(client)
	-- Disable the formatting function and leave it to a special plug-in plug-in for processing
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
			},
			maxPreload = 100000,
			preloadFileSize = 10000,
		},
	},
})

lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
	},
})

lspconfig.basedpyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
