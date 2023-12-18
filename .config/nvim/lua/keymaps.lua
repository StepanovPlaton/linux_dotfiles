local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

local gs = package.loaded.gitsigns

-----------------------------------------------------------
-- Базовые 
-----------------------------------------------------------

-- Системный буфер обмена
-- map('v', '<C-y>', '"+y', {})

-- 'Нажимает' на ESC при быстром нажатии jj
map('i', 'оо', '<Esc>')
map('i', 'jj', '<Esc>')

-- Отключение стрелочек. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})

-- Автоформат + сохранение по CTRL-s , как в нормальном, так и в insert режиме
-- map('n', '<C-s>', ':Autoformat<CR>:w<CR>',  default_opts)
-- map('i', '<C-s>', '<esc>:Autoformat<CR>:w<CR>', default_opts)

-- Переключение вкладок с помощью TAB или shift-tab (akinsho/bufferline.nvim)
-- map('n', '<Tab>', ':BufferLineCycleNext<CR>', default_opts)
-- map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', default_opts)

-- Пролистнуть на страницу вниз / вверх (как в браузерах)
-- map('n', '<Space>', '<PageDown> zz', default_opts)
-- map('n', '<C-Space>', '<PageUp> zz', default_opts)

-- " Переводчик рус -> eng
-- map('v', 't', '<Plug>(VTranslate)', {})

-----------------------------------------------------------
-- Плагины 
-----------------------------------------------------------

-- telescope 
local builtin = 
map('n', '<leader>ff', require('telescope.builtin').find_files)
map('n', '<leader>fg', require('telescope.builtin').live_grep)
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- NeoTree
map('n', '<leader>t', ':Neotree toggle<CR>')

-- GitSigns
map('n', ']c', function()
  if vim.wo.diff then return ']c' end
  vim.schedule(function() gs.next_hunk() end)
  return '<Ignore>'
end, {expr=true})

map('n', '[c', function()
  if vim.wo.diff then return '[c' end
  vim.schedule(function() gs.prev_hunk() end)
  return '<Ignore>'
end, {expr=true})

map('n', '<leader>gs', gs.stage_hunk)
map('n', '<leader>gr', gs.reset_hunk)
-- map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
-- map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
map('n', '<leader>gS', gs.stage_buffer)
map('n', '<leader>gu', gs.undo_stage_hunk)
-- map('n', '<leader>hR', gs.reset_buffer)
map('n', '<leader>gp', gs.preview_hunk)
map('n', '<leader>gb', function() gs.blame_line{full=true} end)
-- map('n', '<leader>tb', gs.toggle_current_line_blame)
map('n', '<leader>gd', gs.diffthis)
map('n', '<leader>gD', function() gs.diffthis('~') end)
map('n', '<leader>gtd', gs.toggle_deleted)

-----------------------------------------------------------
-- F1 .. F12
-----------------------------------------------------------
-- По F1 очищаем последний поиск с подсветкой
map('n', '<F1>', ':nohl<CR>')

-- <F3> перечитать конфигурацию nvim
map('n', '<F3>', ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/plugins.lua<CR>:so ~/.config/nvim/lua/base.lua<CR>:so ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })

-- <S-F3> Открыть всю nvim конфигурацию для редактирования
map('n', '<S-F3>', ':e ~/.config/nvim/init.lua<CR>:e ~/.config/nvim/lua/plugins.lua<CR>:e ~/.config/nvim/lua/base.lua<CR>:e ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })

-- <F4> Поиск слова под курсором
map('n', '<F4>', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])

-- <S-F4> Поиск слова в модальном окошке
map('n', '<S-F4>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])

-- <F5> разные вариации нумераций строк, можно переключаться
map('n', '<F5>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>')

-- <F6> дерево файлов.
map('n', '<F6>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>')

-- <F8>  Показ дерева классов и функций, плагин majutsushi/tagbar
map('n', '<F8>', ':TagbarToggle<CR>')

-- <F11> Проверка орфографии  для русского и английского языка
map('n', '<F11>', ':set spell!<CR>')
map('i', '<F11>', '<C-O>:set spell!<CR>')
