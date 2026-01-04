return {
	{
		-- Подсветка синтаксиса
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"m4xshen/autoclose.nvim",
		},
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				auto_install = true,
				sync_install = false,
				highlight = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true },
				-- autotag = { enable = true }
				disable = { "tex", "latex" },
			})
			require("nvim-ts-autotag").setup({
				-- Опциональные настройки
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			})
			require("autoclose").setup()

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.tpp",
				callback = function()
					vim.bo.filetype = "cpp"
				end,
			})
		end,
	},
}
