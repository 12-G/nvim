return {

	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<BS>", desc = "Decrement Selection", mode = "x" },
				{ "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User BaseDefered",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "User BaseDefered", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0,
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSInstall", "TSUpdate", "TSInstall" },
		build = ":TSUpdate",
		opts = function()
			return require("plugins.config.ui").treesitter
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},

	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		opts = function()
			return require("plugins.config.others").gitsigns
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
}
