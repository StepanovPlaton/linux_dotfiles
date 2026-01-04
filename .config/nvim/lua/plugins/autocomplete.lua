return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",

			"hrsh7th/cmp-nvim-lsp",

			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			require("luasnip.loaders.from_vscode").lazy_load()

			local has_words_before = function()
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				end
				local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("%S")
			end

			cmp.setup({
				-- Производительность
				performance = {
					debounce = 60,
					throttle = 30,
					fetching_timeout = 200,
					async_budget = 1,
					max_view_entries = 10,
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				-- Сортировка источников по приоритету
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000, keyword_length = 2 },
					{ name = "luasnip", priority = 900, keyword_length = 1 },
					{ name = "buffer", priority = 500, keyword_length = 3 },
					{ name = "path", priority = 250, keyword_length = 1 },
				}),
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
				},
				-- Форматирование
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						-- Иконки
						local icons = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰜢",
							Variable = "󰀫",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "󰑭",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "󰈇",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "󰙅",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "",
						}

						vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "?", vim_item.kind)

						local source_name = entry.source.name
						local menu_map = {
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							buffer = "[Buf]",
							path = "[Path]",
							nvim_lua = "[Lua]",
							cmdline = "[Cmd]",
						}

						vim_item.menu = menu_map[source_name] or ("[" .. source_name .. "]")

						-- Укорочение длинных имен
						local label = vim_item.abbr
						local truncated_label = vim.fn.strcharpart(label, 0, 50)
						if truncated_label ~= label then
							vim_item.abbr = truncated_label .. "…"
						end

						return vim_item
					end,
				},

				-- Экспериментальные фичи
				experimental = {
					ghost_text = {
						hl_group = "Comment", -- призрачный текст
					},
				},
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({ { name = "git" } }, { { name = "buffer" } }),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},
}
