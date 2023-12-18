-- Установка lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Загрука темы из pywal
  { "dylanaraps/wal.vim", 
    priority = 1000,
    config = function() 
      vim.cmd([[colorscheme wal]])
    end,
  },

  -- Подсветка синтаксиса
  { "nvim-treesitter/nvim-treesitter", 
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
        })
    end
  },

  { 'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'mason-org/mason-registry',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("null-ls").setup()
    end,
  },

  -- Диалоговое окно поиска
  { 'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
  },

  -- Файловый менеджер
  -- ? в окне проводника для горячих клавиш
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = true,
    cmd = 'Neotree',
    branch = "v3.x",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim',
    },
  },

  -- Строка состояния 
  -- (можно конфигурировать, пока не разобрался)
  { 'itchyny/lightline.vim' },

  -- Быстрое комментирование
  -- gcc - закоментировать строку
  -- (VISUAL) gc - закоментировать выделенные строки 
  { 'tpope/vim-commentary' },

  -- Поддержка git
  { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Поддержка русского языка в командном режиме
  { 'powerman/vim-plugin-ruscmd' },

  -- Подсветка комбинаций клавиш
  { "folke/which-key.nvim",
    config = function()
      -- Временно отключен
      -- Плохо выглядит с pywal base16-gruvbox-hard
      -- require('which-key').setup()
    end
  }, 
}, {
  defaults = {
    lazy = false
  }
})
