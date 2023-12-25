return {
  {
    "folke/todo-comments.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim"
    },
    opts = {},
    config = function()
      require("todo-comments").setup()
    end,
    keys = {
      { "<LEADER>Ct", "<CMD>TroubleToggle todo<CR>" }
    }
  }
}
