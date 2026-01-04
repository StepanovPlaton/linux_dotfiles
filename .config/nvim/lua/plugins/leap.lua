return {
	-- Прыжок в любое место по символу
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"ggandor/flit.nvim",
		dependencies = {
			"ggandor/leap.nvim",
		},
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "<Leader>j", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "<Leader>k", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "<Leader>J", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			-- leap.add_default_mappings(true)
			-- Удаляем конфликтующие маппинги, если они есть
			-- vim.keymap.del({ "x", "o" }, "x")
			-- vim.keymap.del({ "x", "o" }, "X")

			-- Прыжок вперёд
			vim.keymap.set({ "n", "x", "o" }, "<Leader>j", "<Plug>(leap-forward)")
			-- Прыжок назад
			vim.keymap.set({ "n", "x", "o" }, "<Leader>k", "<Plug>(leap-backward)")
			-- Прыжок между окнами
			vim.keymap.set({ "n", "x", "o" }, "<Leader>J", "<Plug>(leap-from-window)")
		end,
	},
}
