return {
	{
		"mason-org/mason.nvim",
		opts = {},
		dependencies = {
			"mason-org/mason-registry",
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
			automatic_enable = true,
			ensure_installed = {
				"bashls",
				"lua_ls",

				"vtsls", -- ts_ls + vue support
				"html",
				"cssls",
				"jsonls",

				"pyright",

				"yamlls",
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
			"j-hui/fidget.nvim",
			"folke/trouble.nvim",
		},
		keys = {
			{ "<LEADER>l", desc = "LSP Features" },
			{ "<LEADER>lh", vim.lsp.buf.hover, desc = "Get info from LSP" },
			{ "<LEADER>lr", vim.lsp.buf.rename, desc = "Rename" },
			{
				"<LEADER>lf",
				function()
					vim.lsp.buf.format({
						async = true,
						-- bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
				desc = "Format code",
			},
			{ "<LEADER>lgr", vim.lsp.buf.references, desc = "Open references" },
			{ "<LEADER>lgi", vim.lsp.buf.implementation, desc = "Open implementation" },
			{ "<LEADER>lsh", vim.lsp.buf.signature_help, desc = "Optn signature help" },

			{ "<LEADER>ldj", vim.diagnostic.goto_next, desc = "Go to next problem" },
			{
				"<LEADER>ldk",
				vim.diagnostic.goto_prev,
				desc = "Go to previous problem",
			},

			{ "<LEADER>lgd", vim.lsp.buf.definition, desc = "Open definition" },
			{ "<LEADER>lgt", vim.lsp.buf.type_definition, desc = "Open type definition" },

			{
				"<LEADER>law",
				vim.lsp.buf.add_workspace_folder,
				desc = "Add folder to workspace",
			},
			{
				"<LEADER>ldw",
				vim.lsp.buf.remove_workspace_folder,
				desc = "Remove folder from workspace",
			},
			{
				"<LEADER>llw",
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				desc = "List workspace folders",
			},
			{
				"<LEADER>lca",
				vim.lsp.buf.code_action,
				desc = "Open code actions",
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				vim.notify(client.name .. " attached", vim.log.levels.INFO)
			end

			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = on_attach,
			})
			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = vim.fn.stdpath("data")
										.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
									languages = { "vue" },
									configNamespace = "typescript",
								},
							},
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					clangd = {
						fallbackFlags = {
							"--std=c++23",
							"-Wall",
							"-Wextra",
							"-Wpedantic",
						},
					},
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "tpp" },
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = {
				"prettierd",
				"eslint_d",

				"stylua",

				"shfmt",
				"shellcheck",

				"autopep8",
				"black",
				"isort",
			},
			automatic_installation = true,
			handlers = {},
		},
	},

	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local null_ls = require("null-ls")

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				source = {},
				on_attach = function(client, bufnr)
					local sources = null_ls.get_sources()
					local source_names = {}
					for _, source in ipairs(sources) do
						if source.filetypes then
							for ft, _ in pairs(source.filetypes) do
								if ft == vim.bo[bufnr].filetype then
									table.insert(source_names, source.name)
								end
							end
						end
					end
					local message = "NullLS attached"
					if #source_names > 0 then
						message = message .. " with sources: " .. table.concat(source_names, ", ")
					else
						message = message .. " (no sources for this filetype)"
					end
					vim.notify(message, vim.log.levels.INFO)

					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									async = false,
									filter = function(format_client)
										return format_client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			})
		end,
	},

	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					max_width = 60,
					max_height = 5,
					winblend = 0,
				},
				filter = vim.log.levels.DEBUG,
			},
		},
		config = function(_, opts)
			local fidget = require("fidget")
			fidget.setup(opts)
			vim.notify = fidget.notify
		end,
	},
}
