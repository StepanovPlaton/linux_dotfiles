return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "mason-org/mason-registry",
    },
    opts = {}
  },
  { 
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    keys = {
      { "<LEADER>lh", vim.lsp.buf.hover },
      { "<LEADER>lr", vim.lsp.buf.rename },
      { "<LEADER>lf", function()
          vim.lsp.buf.format({ 
            async = true,
            bufnr = bufnr,
            filter = function(client) 
              return client.name == "null-ls" 
            end
          })
        end 
      },
      { "<LEADER>lgr", vim.lsp.buf.references },
      { "<LEADER>lgi", vim.lsp.buf.implementation },
      { "<LEADER>lsh", vim.lsp.buf.signature_help },

      { "<LEADER>ldj", vim.diagnostic.goto_next },
      { "<LEADER>ldk", vim.diagnostic.goto_prev },

      { "<LEADER>lgd", vim.lsp.buf.definition },
      { "<LEADER>lgtd", vim.lsp.buf.type_definition },

      { "<LEADER>law", vim.lsp.buf.add_workspace_folder },
      { "<LEADER>ldw", vim.lsp.buf.remove_workspace_folder },
      { "<LEADER>llw", function() 
        print(vim.inspect(vim.lsp.buf.list_workplace_folders())) 
      end },

      { "<LEADER>lca", vim.lsp.buf.code_action },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      local LSP_SERVERS = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "pyright"
      }

      mason_lspconfig.setup({
        ensure_installed = LSP_SERVERS,
        automatic_installation = true,
      })
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      for _, server in pairs(LSP_SERVERS) do
        lspconfig[server].setup(
          {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        )
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "williamboman/mason-null-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        source = {
          -- null_ls.builtins.diagnostics.eslint_d,
          -- null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.diagnostics.pycodestyle,
          null_ls.builtins.diagnostics.pydocstyle,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("LspFormatting", {}),
              buffer = bufnr,
              callback = function() 
                vim.lsp.buf.format({ 
                  async = false,
                  bufnr = bufnr,
                  filter = function(client) 
                    return client.name == "null-ls" 
                  end
                })
              end,
            })
          end
        end,
      })
      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        handlers = {}
      })
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {}
  },
}
