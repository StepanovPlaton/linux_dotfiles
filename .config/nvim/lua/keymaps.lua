local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
end

-----------------------------------------------------------
-- Базовые 
-----------------------------------------------------------

-- Командная клавиша
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- 'Нажимает' на ESC при быстром нажатии jj
map('i', 'оо', '<Esc>')
map('i', 'jj', '<Esc>')

-- Отключение стрелочек. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})

map('n', "<C-h>", "<C-w>h")
map('n', "<C-j>", "<C-w>j")
map('n', "<C-k>", "<C-w>k")
map('n', "<C-l>", "<C-w>l")

map('n', '<leader>st', ':set invlist<CR>')

-----------------------------------------------------------
-- F1 .. F12
-----------------------------------------------------------

-- По F1 очищаем последний поиск с подсветкой
map('n', '<F1>', ':nohl<CR>')
map('n', '<leader>nh', ':nohl<CR>')

-- <F5> разные вариации нумераций строк, можно переключаться
map('n', '<F5>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>')

-- <F11> Проверка орфографии  для русского и английского языка
map('n', '<F11>', ':set spell!<CR>')
map('i', '<F11>', '<C-O>:set spell!<CR>')
