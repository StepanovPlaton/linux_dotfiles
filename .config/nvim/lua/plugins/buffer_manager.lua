return {
  {
    "j-morano/buffer_manager.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    keys = {
      { "<LEADER>b", function() require("buffer_manager.ui").toggle_quick_menu() end },
      { "<S-h>", function() require("buffer_manager.ui").nav_prev() end },
      { "<S-l>", function() require("buffer_manager.ui").nav_next() end }
    }
  }
}
