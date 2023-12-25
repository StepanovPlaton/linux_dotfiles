local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------

-- Откллючить поддержку со старым vi
g.nocompatible = true
-- Не делать бекап файла
g.nobackup = true
g.nowritebackup = true
-- Кодировка по умолчанию
g.encoding = "utf-8"

-- Буфер обмена с системой (нужен xclip)
opt.clipboard = "unnamed,unnamedplus"
-- Разделитель на 80 символов
opt.colorcolumn = '80'              
-- Словари рус eng
opt.spelllang = { 'en_us', 'ru' }   
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

-----------------------------------------------------------
-- Цветовая схема
-----------------------------------------------------------

--  Нужно для поддежки pywal
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
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]])

-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------

-- Запоминает где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup end
]], false)
