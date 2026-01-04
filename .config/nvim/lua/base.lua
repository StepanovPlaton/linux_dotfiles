local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------

-- Отключить поддержку со старым vi
-- g.nocompatible = true
opt.compatible = false
-- Не делать бекап файла
g.nobackup = true
g.nowritebackup = true
-- Кодировка по умолчанию
g.encoding = "utf-8"

-- Буфер обмена с системой (нужен xclip)
opt.clipboard = "unnamed,unnamedplus"
-- Разделитель на 80 символов
opt.colorcolumn = "80"
-- Словари рус eng
opt.spelllang = { "en_us", "ru" }
-- Включаем нумерацию строк
opt.number = true
-- Вкл. относительную нумерацию строк
opt.relativenumber = true
-- Возможность отката назад
opt.undofile = true
-- vertical split вправо
opt.splitright = true
-- horizontal split вниз
opt.splitbelow = true
-- Отступ во время скрола
opt.scrolloff = 10
-- Показать парную скобку
opt.showmatch = true
-- Всегда показывать столбец для значков
opt.signcolumn = "yes"
-- Скрыть командную строку по умолчанию
opt.cmdheight = 0
-- Не создавать swap файл
opt.swapfile = false

-- Отключить стандартный проводник
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1

-- Игнорировать регистр при поиске, если все буквы строчные
opt.ignorecase = true
opt.smartcase = true
-- Не прыгать при поиске
opt.incsearch = true
-- Подсветка результатов поиска
opt.hlsearch = true

-- Автодополнение путей
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Конфигурация проверки орфографии
opt.spell = true
opt.spelllang = { "en_us", "ru" }
opt.spellsuggest = "best,3"

-- Автоматическое включение проверки для определенных типов файлов
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit", "latex", "tex" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-----------------------------------------------------------
-- Цветовая схема
-----------------------------------------------------------

--  Нужно для поддержки pywal
-- opt.termguicolors = false
-- Устанавливаем тему из pywal
-- cmd([[
-- highlight ColorColumn ctermbg=16
-- ]])

-----------------------------------------------------------
-- Табы и отступы
-----------------------------------------------------------

cmd([[
filetype indent plugin on
syntax enable
]])

-- Использовать пробелы вместо табуляции
opt.expandtab = true
-- Количество пробелов используемых для отступа
opt.shiftwidth = 4
-- 1 таб = 4 пробелам
opt.tabstop = 4
-- Добавлять отступ на новых строках
opt.smartindent = true

-- Не автокомментировать новые строки
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- Удалить маркер длинны строки для выбранных типов файлов
cmd([[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]])

-- 2 пробела для выбранных типов файлов
cmd([[
autocmd FileType xml,html,xhtml,css,scss,sass,javascript,typescript,lua,yaml,htmljinja,vue,svelte setlocal shiftwidth=2 tabstop=2
]])

-- Показывать непечатные символы
opt.list = true
opt.listchars = {
	tab = "▸ ",
	trail = "·",
	nbsp = "␣",
	extends = "❯",
	precedes = "❮",
}

-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------

-- Запоминает где nvim последний раз редактировал файл
cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- Подсвечивает на доли секунды скопированную часть текста
exec(
	[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup end
]],
	false
)

-- Автоматическое перечитывание файла при изменении извне
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})

-----------------------------------------------------------
-- Полезные фишки: Автосохранение с таймаутом
-----------------------------------------------------------
-- local autosave_timers = {}
--
-- -- Функция для сохранения буфера
-- local function save_buffer(bufnr)
-- 	vim.api.nvim_buf_call(bufnr, function()
-- 		vim.cmd("silent! write")
-- 	end)
-- end
--
-- -- Автогруппа для автосохранения
-- vim.api.nvim_create_augroup("autosave_debounced", { clear = true })
--
-- -- Дебаунсим только изменения вне insert mode (TextChanged)
-- vim.api.nvim_create_autocmd("TextChanged", {
-- 	group = "autosave_debounced",
-- 	pattern = "*",
-- 	callback = function(args)
-- 		local bufnr = args.buf
--
-- 		-- Отменяем предыдущий таймер для этого буфера
-- 		if autosave_timers[bufnr] then
-- 			autosave_timers[bufnr]:stop()
-- 			autosave_timers[bufnr]:close()
-- 		end
--
-- 		-- Создаем новый таймер на 500 мс
-- 		autosave_timers[bufnr] = vim.defer_fn(function()
-- 			save_buffer(bufnr)
-- 			autosave_timers[bufnr] = nil
-- 		end, 500)
-- 	end,
-- })
--
-- -- Сохраняем сразу при выходе из insert mode
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	group = "autosave_debounced",
-- 	pattern = "*",
-- 	callback = function(args)
-- 		local bufnr = args.buf
--
-- 		-- Отменяем отложенное сохранение, если оно было запланировано
-- 		if autosave_timers[bufnr] then
-- 			autosave_timers[bufnr]:stop()
-- 			autosave_timers[bufnr]:close()
-- 			autosave_timers[bufnr] = nil
-- 		end
--
-- 		-- Сохраняем сразу
-- 		save_buffer(bufnr)
-- 	end,
-- })
--
-- -- Очистка таймеров при закрытии буфера
-- vim.api.nvim_create_autocmd("BufWipeout", {
-- 	group = "autosave_debounced",
-- 	pattern = "*",
-- 	callback = function(args)
-- 		if autosave_timers[args.buf] then
-- 			autosave_timers[args.buf]:stop()
-- 			autosave_timers[args.buf]:close()
-- 			autosave_timers[args.buf] = nil
-- 		end
-- 	end,
-- })
