return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      { "<LEADER>T", "<CMD>ToggleTerm<CR>" },
      { "<LEADER>Tf", "<CMD>ToggleTerm direction=float<CR>" },
      { "<LEADER>Th", "<CMD>ToggleTerm direction=horizontal<CR>" },
      { "<LEADER>Tv", "<CMD>ToggleTerm direction=vertical<CR>" },
      { "<ESC>", [[<C-\><C-n>]], mode = "t" },
      { "<C-T>", "<CMD>ToggleTerm<CR>", mode = "t" },
      { "<C-d>", false, mode = "t" },
      { "<C-T>c", [[<C-\><C-n><CMD>:bd!<CR>]], mode = "t" }
    }
  }

}
