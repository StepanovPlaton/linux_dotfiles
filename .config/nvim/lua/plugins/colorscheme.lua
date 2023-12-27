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
      vim.cmd([[colorscheme gruvbox]])
    end
  }

  -- {
  --   "RRethy/nvim-base16",
  --   config = function()
  --     vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
  --   end
  -- }

  -- {
  --   "nanotech/jellybeans.vim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd([[colorscheme jellybeans]])
  --   end
  -- }

  -- {
  --   "junegunn/seoul256.vim",
  --   config = function()
  --     vim.g.seoul256_background = 233
  --     vim.cmd([[colorscheme seoul256]])
  --   end
  -- }

  -- {
  --   "Mofiqul/vscode.nvim",
  --   config = function()
  --     require("vscode").load("dark")
  --   end
  -- }

  -- {
  --   "sainnhe/everforest",
  --   config = function()
  --     vim.g.everforest_background = "hard"
  --     vim.o.background = "dark"
  --     -- require("everforest")
  --     vim.cmd([[colorscheme everforest]])
  --   end
  -- }
}
