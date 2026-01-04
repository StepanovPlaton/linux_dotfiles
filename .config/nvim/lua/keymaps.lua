local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
	opts = opts or default_opts
	-- opts.buffer = bufnr
	vim.keymap.set(mode, l, r, opts)
end

-----------------------------------------------------------
-- Базовые
-----------------------------------------------------------

-- Командная клавиша
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- Быстрое перемещение
map("n", "<A-j>", "10j")
map("n", "<A-k>", "10k")

-- Быстрое сохранение
map("n", "<leader>w", "<cmd>write<CR>")
map("n", "<leader>q", "<cmd>quit<CR>")

-- 'Нажимает' на ESC при быстром нажатии jj
-- map("i", "оо", "<Esc>")
-- map("i", "jj", "<Esc>")

-- Переход в режим ввода на русском при нажатии R
vim.keymap.set("n", "R", function()
	os.execute("xkb-switch -s ru")
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>i", true, true, true), "n", true)
end, { noremap = true, silent = true })

local returnFromInsert = function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
	os.execute("xkb-switch -s us")
end
vim.keymap.set("i", "jj", returnFromInsert, { noremap = true, silent = true })
vim.keymap.set("i", "оо", returnFromInsert, { noremap = true, silent = true })

-- Отключение стрелочек. Использовать hjkl
-- map("", "<up>", ':echoe "Use k"<CR>', { noremap = true, silent = false })
-- map("", "<down>", ':echoe "Use j"<CR>', { noremap = true, silent = false })
-- map("", "<left>", ':echoe "Use h"<CR>', { noremap = true, silent = false })
-- map("", "<right>", ':echoe "Use l"<CR>', { noremap = true, silent = false })

-- Ресайз окон
map("n", "<Up>", "<cmd>resize +2<CR>")
map("n", "<Down>", "<cmd>resize -2<CR>")
map("n", "<Left>", "<cmd>vertical resize +2<CR>")
map("n", "<Right>", "<cmd>vertical resize -2<CR>")

-- Перемещение между окнами
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>st", ":set invlist<CR>")

-----------------------------------------------------------
-- Spell Check
-----------------------------------------------------------
-- Включить/выключить проверку
map("n", "<leader>ss", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })

-- Навигация по ошибкам
map("n", "]s", "<cmd>normal! ]s<CR>", { desc = "Next spelling error" })
map("n", "[s", "<cmd>normal! [s<CR>", { desc = "Previous spelling error" })

-- Добавить слово в словарь
map("n", "<leader>sda", "<cmd>normal! zg<CR>", { desc = "Add to dictionary" })
map("n", "<leader>sdd", "<cmd>normal! zw<CR>", { desc = "Mark as wrong" })

-- Показать варианты исправления
map("n", "<leader>sp", "<cmd>normal! z=<CR>", { desc = "Show spelling suggestions" })

-- Русская раскладка в справках
vim.cmd([[
" Русские подсказки для проверки орфографии
set spellcapcheck=  " Отключить проверку заглавных букв для русского
]])

-- Альтернативный путь к словарям (если стандартный не работает)
local spell_paths = {
	"/usr/share/hunspell/",
	"/usr/share/myspell/dicts/",
	"/usr/share/myspell/",
	vim.fn.expand("~/.local/share/nvim/spell/"),
}

-- Проверить и установить словари если нужно
local function setup_spell()
	local has_dicts = false

	for _, path in ipairs(spell_paths) do
		if vim.fn.isdirectory(path) == 1 then
			vim.opt.spellfile = vim.fn.glob(path .. "/*.add")
			has_dicts = true
			break
		end
	end

	if not has_dicts then
		vim.notify(
			"Словари не найдены. Установите: sudo apt install hunspell-ru hunspell-en-us",
			vim.log.levels.WARN
		)
	end
end

-- Вызвать настройку при запуске
vim.defer_fn(setup_spell, 100)

-----------------------------------------------------------
-- F1 .. F12
-----------------------------------------------------------

-- По F1 очищаем последний поиск с подсветкой
-- map("n", "<F1>", ":nohl<CR>")
map("n", "<leader>nh", ":nohl<CR>")

-- <F5> разные вариации нумераций строк, можно переключаться
map("n", "<F5>", ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>')

-- <F11> Проверка орфографии  для русского и английского языка
map("n", "<F11>", ":set spell!<CR>")
map("i", "<F11>", "<C-O>:set spell!<CR>")
