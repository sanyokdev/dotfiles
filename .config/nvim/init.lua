require("plugin-setup")

-- -------------------------------------------
-- Vim options
-- -------------------------------------------
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false

-- Indentation & wrapping
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = -1
opt.expandtab = true
opt.smarttab = true

opt.smartindent = true
opt.autoindent = true
opt.cindent = true

opt.wrap = false

opt.backspace = "indent,eol,start"

-- Cursor
opt.cursorline = true
opt.scrolloff = 4
opt.updatetime = 100

-- Cmd & Search
opt.showcmd = true
opt.ignorecase = true
opt.smartcase = true

-- Text & Clipboard
opt.iskeyword:append("-") -- Consider dash as part of a word
opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Window management
opt.splitright = true
opt.splitbelow = true

-- Colors
opt.background = "dark"
opt.termguicolors = true
-- vim.cmd([[colorscheme catppuccin-frappe]])
vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_invert_selection = 0
vim.cmd([[colorscheme gruvbox]])

-- -------------------------------------------
-- General Keybinds
-- -------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Leave terminal mode by hitting esc
keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Move current line up or down
keymap.set("n", "<A-Up>", ":move -2<cr>", opts)
keymap.set("n", "<A-Down>", ":move +1<cr>", opts)

-- Clear search & highlight
keymap.set("n", "<Esc>", ":nohl<CR>:echo ''<CR>", opts)

-- Toggle word wrapping
keymap.set("n", "<leader>wr", ":set wrap!<CR>", opts)

-- Window splits (vertical, horizontal & make equal)
keymap.set("n", "<leader>sv", "<C-w>v", opts)
keymap.set("n", "<leader>sh", "<C-w>s", opts)
keymap.set("n", "<leader>se", "<C-w>=", opts)

keymap.set("n", "<leader>ww", "<C-w>k", opts)
keymap.set("n", "<leader>ss", "<C-w>j", opts)
keymap.set("n", "<leader>aa", "<C-w>h", opts)
keymap.set("n", "<leader>dd", "<C-w>l", opts)

-- Window tabs (open, close, move next & move previous)
keymap.set("n", "<leader>to", ":tabnew<CR>", opts)
keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)
keymap.set("n", "<leader>tn", ":tabn<CR>", opts)
keymap.set("n", "<leader>tp", ":tabp<CR>", opts)

-- Saving and quitting
keymap.set("n", "<C-s>", ":wa<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:wa<CR>", opts)

-- Delete word with ctrl + backspace (note: too buggy, need alternative)
-- function DeleteWordBeforeCursor()
-- 	vim.cmd("normal! b")
-- 	vim.cmd("normal! dw")
-- end
--
-- keymap.set("i", "<C-H>", "<Esc>:lua DeleteWordBeforeCursor()<CR>a", opts)

-- Automatic format on save
vim.cmd([[
augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]])

-- -------------------------------------------
-- Plugin Keybinds
-- -------------------------------------------

-- Lazy package manager
keymap.set("n", "<leader>ll", ":Lazy<CR>", opts)
keymap.set("n", "<leader>lu", ":Lazy update<CR>", opts)

-- Oil file exporer
function GetBufferDir()
	local buffer_name = vim.fn.expand("%:p:h")
	return vim.fn.fnameescape(buffer_name)
end

keymap.set("n", "<leader>fv", ":lua vim.cmd('Oil ' .. GetBufferDir())<CR>", opts) -- [F]ile [V]iew

-- Telescope
keymap.set("n", "<leader>kb", ":Telescope keymaps<CR>", opts) -- [K]ey [B]indings
keymap.set("n", "<leader>ch", ":Telescope command_history<CR>", opts) -- [C]ommand [H]istory

keymap.set(
	"n",
	-- "<leader>ff",
	"<leader><space>",
	":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>",
	opts
) -- [F]ile [F]inder
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", opts) -- [F]ile [S]earch
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", opts) -- [F]ind [W]ord under cursor
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts) -- [F]ind [B]uffer
-- keymap.set("n", "<leader>fd", ":Telescope diagnostics theme=dropdown<CR>", opts) -- [F]ind [D]iagnostics
keymap.set(
	"n",
	"<leader>fd",
	":lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown{layout_config = {width = 0.9}})<CR>",
	opts
) -- [F]ind [D]iagnostics
keymap.set("n", "<leader>fr", ":Telescope lsp_references theme=dropdown<CR>", opts) -- [F]ind [R]eferences

keymap.set("n", "<leader>gd", ":Telescope lsp_definitions<CR>", opts) -- [G]oto [D]efinition
keymap.set("n", "<leader>ds", ":Telescope lsp_document_symbols theme=dropdown<CR>", opts)
keymap.set("n", "<leader>ws", ":Telescope lsp_workspace_symbols theme=dropdown<CR>", opts)

-- Fun
keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", opts)

-- -------------------------------------------
-- Management Keybinds
-- -------------------------------------------

-- Build tasks (needs tasks.json at project root)
function TargetRunner()
	local Menu = require("nui.menu")

	-- Check if file exists
	local path = vim.fn.getcwd():gsub("\\", "/")
	local tasksFilePath = string.format("%s/tasks.json", path)

	if not vim.loop.fs_stat(tasksFilePath) then
		print(string.format("Task runner: tasks.json not found in %s", path))
		return
	end

	-- Read the contents of tasks.json
	local contents = vim.fn.readfile(tasksFilePath)

	-- Decode the JSON string
	local data = vim.fn.json_decode(table.concat(contents, "\n"))

	if data == nil then
		print("Task runner: Invalid JSON provided!")
		return
	end

	-- Base command checks
	if data.cmd == nil then
		print("Task runner: No cmd found!")
		return
	elseif data.cmd == "" then
		print("Task runner: cmd is empty!")
		return
	end

	-- Prepare list data based on specs provided by tasks.json
	local linesData = {}

	if data.tasks ~= nil then
		if #data.tasks > 0 then
			for index, task in ipairs(data.tasks) do
				local itemData = {
					name = task.name,
					silent = "false",
					command = path .. "/" .. data.cmd .. " " .. task.target,
					args = "",
				}

				if task.silent ~= nil and task.silent == "true" then
					itemData.silent = "true"
				end

				if task.args ~= nil then
					itemData.args = task.args
				end

				table.insert(linesData, Menu.item(" " .. index .. ". " .. task.name, itemData))
			end
		else
			print("Task runner: No tasks found!")
			return
		end
	else
		print("Task runner: tasks list is empty!")
		return
	end

	-- Mount the UI
	local menu = Menu({
		position = "50%",
		size = {
			width = 25,
			height = #data.tasks,
		},
		border = {
			style = "single",
			text = {
				top = "[Task-Runner]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = linesData,
		max_width = 20,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("Task runner: cancelled!")
		end,
		on_submit = function(item)
			print("Task runner: executed ", item.name)
			if item.silent == "true" then
				if item.args ~= "" then
					vim.fn.execute("! sh -c '" .. item.command .. " " .. item.args .. "'")
				else
					vim.fn.execute("! sh -c '" .. item.command .. "'")
				end
			else
				if item.args ~= "" then
					vim.fn.execute("split | terminal sh -c '" .. item.command .. " " .. item.args .. "'")
				else
					vim.fn.execute("split | terminal sh -c '" .. item.command .. "'")
				end
			end
		end,
	})

	menu:mount()
end

keymap.set("n", "<leader>tr", ":lua TargetRunner()<CR>", opts)

-- Open projects
function OpenAndChangeCWD(path)
	-- Open file exporer
	local cmd = string.format(":Oil %s", path)
	vim.fn.execute(cmd)

	-- Change the current working directory
	vim.api.nvim_set_current_dir(path)
	print(path)
end

keymap.set("n", "<leader>1", ":lua OpenAndChangeCWD('C:/Dev/dotfiles/.config/nvim')<CR>", opts)
keymap.set("n", "<leader>2", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/libMana')<CR>", opts)
keymap.set("n", "<leader>3", ":lua OpenAndChangeCWD('C:/Dev/projects/c-cpp/steam-game')<CR>", opts)

-- Reload config
keymap.set("n", "<leader><A-r>", ":source C:/Dev/dotfiles/.config/nvim/init.lua<CR>")

-- Complex plugin configs
require("sanyok.lspconfig")
require("sanyok.nvimcmp")
