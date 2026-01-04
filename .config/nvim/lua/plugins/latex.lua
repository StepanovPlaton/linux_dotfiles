return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.maplocalleader = ","
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				vim.opt_local.syntax = "on" -- Использовать синтаксис VimTeX
			end,
		})
	end,
	config = function() end,
}
