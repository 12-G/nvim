return {
	{
		"neovim/nvim-lspconfig",
		event = "User BaseDefered",
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				config = function()
					require("lspsaga").setup({
						symbol_in_winbar = {
							hide_keyword = true,
						},
						outline = {
							layout = "float",
						},
					})
				end,
			},
		},
		config = function()
			require("plugins.lsp.lsp")
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			return require("plugins.lsp.mason")
		end,
		config = function(_, opts)
			require("mason").setup(opts)

			-- custom nvchad cmd to install all mason binaries listed
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},

	{
		"linux-cultist/venv-selector.nvim",
		branch = "regexp",
		opts = {
			dap_enabled = true,
			settings = {
				options = {
					notify_user_on_venv_activation = true,
				},
			},
		},
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ "<leader>vs", "<cmd>VenvSelect<cr>" },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
		},
	},

	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		ft = "python",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("dap-python").setup("python", {})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("plugins.config.others").luasnip(opts)
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
		opts = function()
			return require("plugins.lsp.cmp")
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Manage libuv types with lazy. Plugin will never be loaded
	"Bilal2453/luvit-meta",
	-- Add lazydev source to cmp
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			table.insert(opts.sources, { name = "lazydev", group_index = 0 })
		end,
	},
}
