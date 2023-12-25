return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "mason-org/mason-registry",
    },
    opts = {}
  },
  {
    "williamboman/mason-null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls.nvim",
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
              callback = function() vim.lsp.buf.format({ async = false }) end,
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
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            elseif has_words_before() then cmp.complete()
            else fallback() end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        -- mapping = cmp.mapping.preset.insert({
        --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --   ['<C-Space>'] = cmp.mapping.complete(),
        --   ['<C-e>'] = cmp.mapping.abort(),
        --   ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources(
          {{ name = 'git' }}, 
          {{ name = 'buffer' }}
        )
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {{ name = 'buffer' }}
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {{ name = 'path' }},
          {{ name = 'cmdline' }}
        )
      })
    end,
  },
  { 
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      -- "ms-jpq/coq_nvim",
      -- "ms-jpq/coq.artifacts",
      -- "ms-jpq/coq.thirdparty"
      "hrsh7th/cmp-nvim-lsp",
    },
    keys = {
      { "<LEADER>lh", vim.lsp.buf.hover },
      { "<LEADER>lr", vim.lsp.buf.rename },
      { "<LEADER>lf", function() vim.lsp.buf.format({async = true}) end},
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
        if server ~= "tsserver" then 
          lspconfig[server].setup(
            {
              capabilities = capabilities,
              on_attach = on_attach,
            }
          )
        end
      end
      lspconfig["tsserver"].setup(
        {
          capabilities = capabilities,
          on_attach = function(client)
            client.resolved_capabilities.document_formatting = false 
          end,
        }
      )
    end,
  },
}
