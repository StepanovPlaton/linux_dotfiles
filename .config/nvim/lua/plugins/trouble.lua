return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<LEADER>tt", "<CMD>TroubleToggle<CR>" },
			{ "<LEADER>tc", "<CMD>TroubleClose<CR>" },

			{ "<LEADER>ttw", "<CMD>TroubleToggle workspace_diagnostics<CR>" },
			{ "<LEADER>ttd", "<CMD>TroubleToggle document_diagnostics<CR>" },

			{ "<LEADER>ttf", "<CMD>TroubleToggle quickfix<CR>" },
			{ "<LEADER>ttl", "<CMD>TroubleToggle loclist<CR>" },

			{ "<LEADER>tlr", "<CMD>TroubleToggle lsp_references<CR>" },
			{ "<LEADER>tld", "<CMD>TroubleToggle lsp_definitions<CR>" },
			{ "<LEADER>tltd", "<CMD>TroubleToggle lsp_type_definitions<CR>" },
		}
  }
}
