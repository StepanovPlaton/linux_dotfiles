return {
  -- Строка состояния 
  -- (можно конфигурировать, пока не разобрался)
  -- { 
  --   "itchyny/lightline.vim"
  -- }

  -- Лучше выглядит и кастомизируется
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {}
  }
}
