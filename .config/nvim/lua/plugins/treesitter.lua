return {
  { 
    -- Подсветка синтаксиса
    "nvim-treesitter/nvim-treesitter", 
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { 
          "html", "markdown", "latex",
          "css", "scss", -- "less", not found
          "javascript", -- "jsx", not found
          "typescript", "tsx",
          "python", "lua",
          "vim", "vimdoc", "query",
          "bash",
          "c",
          "json", "yaml",
        },
        sync_install = false,
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },  
        autotag = { enable = true }
      })
    end
  }
}
