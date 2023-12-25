return {
  { 
    -- Диалоговое окно поиска
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim"
    },
    keys = {
      { "<LEADER>tff", "<CMD>Telescope find_files<CR>" },
      { "<LEADER>tg", "<CMD>Telescope live_grep<CR>" },
      { "<LEADER>tb", "<CMD>Telescope buffers<CR>" },
      { "<LEADER>th", "<CMD>Telescope help_tags<CR>" },

      { "<LEADER>tfb", "<CMD>Telescope file_browser<CR>" },
      { "<LEADER>ts", "<CMD>Telescope symbols<CR>" }
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        extensions = {
          ["ui-select"] = { 
            require("telescope.themes").get_dropdown({})
          },
          ["file_browser"] = {
            theme = "ivy",
          },
          ["symbols"] = {}
        },
        pickers = {
          buffers = {
            mappings = {
              i = { ["<C-d>"] = actions.delete_buffer + actions.move_to_top },
              n = { ["<C-d>"] = actions.delete_buffer + actions.move_to_top }
            }
          }
        }
      })

      telescope.load_extension("file_browser")
      telescope.load_extension("ui-select")
    end,
  }
}
