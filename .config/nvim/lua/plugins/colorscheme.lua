return {
	-- {
	--   -- Загрука темы из pywal
	--   "dylanaraps/wal.vim",
	--   config = function()
	--     vim.cmd([[colorscheme wal]])
	--   end,
	-- }

	{
		-- Отличная тема, но слишком яркий фон
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			-- vim.cmd([[colorscheme gruvbox]])
			require("gruvbox").setup({
				-- Основные настройки контраста
				contrast = "hard", -- "hard", "medium", "soft"

				-- Тёмная версия
				terminal_colors = true,

				-- Настройки яркости
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					comments = false,
					operators = false,
					folds = false,
				},

				-- Цветовые настройки
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,

				-- Более тёмные цвета
				palette_overrides = {
					dark0_hard = "#0d0e0f", -- самый тёмный фон
					dark0 = "#1d2021", -- стандартный фон
					dark1 = "#282828",
					dark2 = "#32302f",
					dark3 = "#3c3836",
					dark4 = "#504945",

					-- Более насыщенные цвета
					bright_red = "#fb4934",
					bright_green = "#b8bb26",
					bright_yellow = "#fabd2f",
					bright_blue = "#83a598",
					bright_purple = "#d3869b",
					bright_aqua = "#8ec07c",
					bright_orange = "#fe8019",
				},

				-- Контрастные настройки
				overrides = {
					-- Пример: сделать выделение контрастнее
					Visual = { bg = "#3c3836", fg = "#ebdbb2" },
					Search = { bg = "#fe8019", fg = "#282828" },
					IncSearch = { bg = "#fb4934", fg = "#282828" },

					-- Контрастные границы
					FloatBorder = { fg = "#ebdbb2" },

					-- Более тёмный LineNr
					LineNr = { fg = "#7c6f64" },
					CursorLineNr = { fg = "#d5c4a1", bold = true },
				},
			})

			-- Дополнительные Vim команды для увеличения контраста
			vim.cmd([[
      colorscheme gruvbox
      
      " Дополнительные настройки контраста
      highlight Normal guibg=#0d0e0f
      highlight NormalNC guibg=#0d0e0f
      highlight SignColumn guibg=#0d0e0f
      highlight EndOfBuffer guifg=#0d0e0f
      
      " Более контрастные комментарии
      highlight Comment guifg=#928374
      
      " Контрастные номера строк
      highlight LineNr guifg=#7c6f64 guibg=#0d0e0f
      highlight CursorLineNr guifg=#ebdbb2 guibg=#0d0e0f
      
      " Контрастный скроллбар
      highlight Pmenu guibg=#1d2021
      highlight PmenuSel guibg=#504945
      
      " Более тёмные границы
      highlight WinSeparator guifg=#504945
    ]])
		end,
	},

	-- {
	-- 	"morhetz/gruvbox",
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.g.gruvbox_contrast_dark = "hard"
	-- 		vim.g.gruvbox_background = "hard"
	-- 		vim.cmd("colorscheme gruvbox")
	-- 	end,
	-- },

	-- {
	-- 	"RRethy/nvim-base16",
	-- 	config = function()
	-- 		vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
	-- 	end,
	-- },

	-- {
	-- 	"nanotech/jellybeans.vim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme jellybeans]])
	-- 	end,
	-- },

	-- {
	--   "junegunn/seoul256.vim",
	--   config = function()
	--     vim.g.seoul256_background = 233
	--     vim.cmd([[colorscheme seoul256]])
	--   end
	-- }

	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	config = function()
	-- 		require("vscode").load("dark")
	-- 	end,
	-- },

	-- {
	-- 	"sainnhe/everforest",
	-- 	config = function()
	-- 		vim.g.everforest_background = "hard"
	-- 		vim.o.background = "dark"
	-- 		-- require("everforest")
	-- 		vim.cmd([[colorscheme everforest]])
	-- 	end,
	-- },
}
