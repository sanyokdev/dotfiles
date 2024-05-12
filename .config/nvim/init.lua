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
-- (Gruvbox)
opt.background = "dark"
opt.termguicolors = true

vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_invert_selection = 0
vim.cmd([[colorscheme gruvbox]])

-- (OneNord)
-- vim.opt.background = "light"
-- vim.opt.termguicolors = true
-- vim.cmd([[colorscheme onenord]])

--[[
local colors = require("onenord.colors").load()
require("onenord").setup({
	styles = {
		comments = "none",
		strings = "none",
		keywords = "none",

		functions = "none",
		variables = "none",
		diagnostics = "underline",
	},
	disable = {
		eob_lines = true,
	},
	inverse = {
		match_paren = false,
	},
	custom_highlights = {
		---- Reference: https://github.com/rmehri01/onenord.nvim/blob/main/lua/onenord/theme.lua#L318

		----------------
		---- Syntax ----
		----------------
		StorageClass = { fg = colors.red },
		Structure = { fg = colors.red },
		Constant = { fg = colors.purple },
		Number = { fg = colors.purple },
		Boolean = { fg = colors.purple },
		Float = { fg = colors.purple },
		Statement = { fg = colors.orange },
		Label = { fg = colors.orange },
		Operator = { fg = colors.fg_light },
		PreProc = { fg = colors.yellow },
		Include = { fg = colors.yellow },
		Define = { fg = colors.yellow },
		Macro = { fg = colors.purple },
		Typedef = { fg = colors.red },
		PreCondit = { fg = colors.yellow },
		Special = { fg = colors.purple },
		SpecialChar = { fg = colors.purple },
		Delimiter = { fg = colors.fg_light },
		Comment = { fg = colors.gray },
		Conditional = { fg = colors.orange },
		Keyword = { fg = colors.orange },
		Repeat = { fg = colors.orange },

		htmlArg = { fg = colors.cyan },
		htmlTag = { fg = colors.red },
		htmlEndTag = { fg = colors.red },
		htmlTagN = { fg = colors.orange },
		htmlTagName = { fg = colors.orange },
		htmlSpecialTagName = { fg = colors.orange },
		htmlH1 = { fg = colors.red, style = "bold" },
		htmlH3 = { fg = colors.red, style = "bold" },
		htmlH4 = { fg = colors.red, style = "bold" },
		htmlH5 = { fg = colors.red, style = "bold" },

		cssAttributeSelector = { fg = colors.cyan },
		cssSelectorOp = { fg = colors.blue },
		cssTagName = { fg = colors.red },

		----------------
		---- Editor ----
		----------------
		IncSearch = { fg = colors.bg, bg = colors.orange, style = "bold" },
		LineNr = { fg = colors.gray },
		CursorLineNr = { style = "italic" },
		MatchParen = { fg = colors.orange },
		Search = { bg = "#E8EBF0" },
		WildMenu = { fg = colors.yellow },
		CursorLine = { bg = "#E2E6EC" },
		NormalMode = { fg = colors.blue },
		CommandMode = { fg = colors.orange },

		--------------------
		---- Treesitter ----
		--------------------
		["@boolean"] = { fg = colors.purple },
		["@comment"] = { fg = colors.gray },
		["@conditional"] = { fg = colors.orange },
		["@constant"] = { fg = colors.purple, style = "bold" },
		["@constant.builtin"] = { fg = colors.purple },
		["@constant.macro"] = { fg = colors.purple },
		["@constructor"] = { fg = colors.blue },
		["@field"] = { fg = colors.cyan },
		["@function.builtin"] = { fg = colors.blue },
		["@function.macro"] = { fg = colors.purple },
		["@include"] = { fg = colors.yellow, style = "italic" },
		["@define"] = { fg = colors.yellow, style = "italic" },
		["@keyword"] = { fg = colors.red },
		["@keyword.function"] = { fg = colors.red },
		["@keyword.operator"] = { fg = colors.red },
		["@keyword.return"] = { fg = colors.red },
		["@namespace"] = { fg = colors.orange },
		["@number"] = { fg = colors.purple },
		["@operator"] = { fg = colors.fg_light },
		["@parameter"] = { fg = colors.fg },
		["@parameter.reference"] = { fg = colors.fg },
		["@property"] = { fg = colors.cyan },
		["@punctuation.delimiter"] = { fg = colors.light_gray },
		["@punctuation.bracket"] = { fg = colors.light_gray },
		["@punctuation.special"] = { fg = colors.light_gray },
		["@repeat"] = { fg = colors.orange },
		["@string.regex"] = { fg = colors.purple },
		["@string.escape"] = { fg = colors.purple },
		["@symbol"] = { fg = colors.red },
		["@tag"] = { fg = colors.red },
		["@tag.attribute"] = { fg = colors.cyan },
		["@tag.delimiter"] = { fg = colors.fg },
		["@text.strong"] = { fg = colors.yellow, style = "bold" },
		["@text.emphasis"] = { fg = colors.orange, style = "italic" },
		["@text.title"] = { fg = colors.purple, style = "bold" },
		["@text.uri"] = { fg = colors.blue, style = "underline" },
		["@text.environment.name"] = { fg = colors.red },
		["@type.builtin"] = { fg = colors.red },

		-----------------
		---- Plugins ----
		-----------------
		-- TODO: Configure plugin colors

		-- Cmp
		CmpItemKindText = { fg = colors.fg_light },

		CmpItemKindMethod = { fg = colors.blue },
		CmpItemKindFunction = { fg = colors.blue },
		CmpItemKindConstructor = { fg = colors.yellow },
		CmpItemKindField = { fg = colors.blue },
		CmpItemKindClass = { fg = colors.yellow },
		CmpItemKindInterface = { fg = colors.yellow },
		CmpItemKindModule = { fg = colors.blue },
		CmpItemKindProperty = { fg = colors.blue },
		CmpItemKindValue = { fg = colors.orange },
		CmpItemKindEnum = { fg = colors.yellow },
		CmpItemKindKeyword = { fg = colors.purple },
		CmpItemKindSnippet = { fg = colors.green },
		CmpItemKindFile = { fg = colors.blue },
		CmpItemKindEnumMember = { fg = colors.cyan },
		CmpItemKindConstant = { fg = colors.orange },
		CmpItemKindStruct = { fg = colors.yellow },
		CmpItemKindTypeParameter = { fg = colors.yellow },

		-- Telescope
		TelescopeNormal = { fg = colors.fg, bg = colors.bg },
		TelescopePromptPrefix = { fg = colors.purple },
		TelescopePromptBorder = { fg = colors.blue },
		TelescopeResultsBorder = { fg = colors.blue },
		TelescopePreviewBorder = { fg = colors.blue },
		TelescopeSelectionCaret = { fg = colors.cyan },
		TelescopeSelection = { fg = colors.cyan },
		TelescopeMatching = { fg = colors.yellow, style = "bold" },

		-- LspSaga
		TitleString = { fg = colors.fg },
		TitleIcon = { fg = colors.red },
		SagaBorder = { bg = colors.bg, fg = colors.blue },
		SagaNormal = { bg = colors.bg },
		SagaExpand = { fg = colors.dark_blue },
		SagaCollapse = { fg = colors.dark_blue },
		SagaBeacon = { bg = colors.purple },
		ActionPreviewNormal = { link = "SagaNormal" },
		ActionPreviewBorder = { link = "SagaBorder" },
		ActionPreviewTitle = { fg = colors.yellow, bg = colors.bg },
		CodeActionNormal = { link = "SagaNormal" },
		CodeActionBorder = { link = "SagaBorder" },
		CodeActionText = { fg = colors.orange },
		CodeActionNumber = { fg = colors.green },
		FinderSelection = { fg = colors.cyan, style = "bold" },
		FinderFileName = { fg = colors.fg_light },
		FinderCount = { link = "Label" },
		FinderIcon = { fg = colors.cyan },
		FinderType = { fg = colors.yellow },
		FinderSpinnerTitle = { fg = colors.purple, style = "bold" },
		FinderSpinner = { fg = colors.purple, style = "bold" },
		FinderPreviewSearch = { link = "Search" },
		FinderVirtText = { fg = colors.dark_blue },
		FinderNormal = { link = "SagaNormal" },
		FinderBorder = { link = "SagaBorder" },
		FinderPreviewBorder = { link = "SagaBorder" },
		DefinitionBorder = { link = "SagaBorder" },
		DefinitionNormal = { link = "SagaNormal" },
		DefinitionSearch = { link = "Search" },
		HoverNormal = { link = "SagaNormal" },
		HoverBorder = { link = "SagaBorder" },
		RenameBorder = { link = "SagaBorder" },
		RenameNormal = { fg = colors.orange, bg = colors.bg },
		RenameMatch = { link = "Search" },
		DiagnosticBorder = { link = "SagaBorder" },
		DiagnosticSource = { fg = "gray" },
		DiagnosticNormal = { link = "SagaNormal" },
		DiagnosticErrorBorder = { link = "DiagnosticError" },
		DiagnosticWarnBorder = { link = "DiagnosticWarn" },
		DiagnosticHintBorder = { link = "DiagnosticHint" },
		DiagnosticInfoBorder = { link = "DiagnosticInfo" },
		DiagnosticPos = { fg = colors.light_gray },
		DiagnosticWord = { fg = colors.fg },
		CallHierarchyNormal = { link = "SagaNormal" },
		CallHierarchyBorder = { link = "SagaBorder" },
		CallHierarchyIcon = { fg = colors.purple },
		CallHierarchyTitle = { fg = colors.red },
		LspSagaLightBulb = { link = "DiagnosticSignHint" },
		SagaShadow = { bg = colors.float },
		OutlineIndent = { fg = colors.dark_blue },
		OutlinePreviewBorder = { link = "SagaNormal" },
		OutlinePreviewNormal = { link = "SagaBorder" },
		TerminalBorder = { link = "SagaBorder" },
		TerminalNormal = { link = "SagaNormal" },
		LspSagaWinbarSep = { fg = colors.cyan },
		LspSagaWinbarFile = { fg = colors.fg },
		LspSagaWinbarWord = { fg = colors.fg_light },
		LspSagaWinbarFolderName = { fg = colors.fg },
	},
	custom_colors = {
		highlight = "#E3E6EC",
	},
})
--]]

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
keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:w<CR>", opts)

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
