vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

-- Make build system (project specific - bad)
vim.keymap.set("n", "<F5>", "<cmd>lua RunMake('run','false')<CR>", opts) -- Run debug
vim.keymap.set("n", "<S-F5>", "<cmd>lua RunMake('run','true')<CR>", opts) -- Run release
vim.keymap.set("n", "<F6>", "<cmd>lua RunMake('clean-build','false')<CR>", opts) -- Build debug
vim.keymap.set("n", "<S-F6>", "<cmd>lua RunMake('clean-build','true')<CR>", opts) -- Build release
vim.keymap.set("n", "<F7>", "<cmd>lua RunMake('all','false')<CR>", opts) -- All debug
vim.keymap.set("n", "<S-F7>", "<cmd>lua RunMake('all','true')<CR>", opts) -- All release

-- Terminal
vim.keymap.set("n", "<leader>tr", ":term<CR>", opts)

-- Lazy
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", opts)
vim.keymap.set("n", "<leader>lc", ":Lazy clean<CR>", opts)
vim.keymap.set("n", "<leader>lu", ":Lazy update<CR>", opts)

-- Saving and quitting
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>wq", ":wqa<CR>", opts)
vim.keymap.set("n", "<leader>qq", ":qall<CR>", opts)

-- Automatic format on save
vim.cmd([[
augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]])

-- Window splits
vim.keymap.set("n", "<leader>sd", ":split<CR>", opts)
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)

local function MapWindowMovement()
	local directions = {
		w = "k", -- Move up
		s = "j", -- Move down
		a = "h", -- Move left
		d = "l", -- Move right
	}

	for leader, direction in pairs(directions) do
		local mapping = string.format("<leader>%s%s", leader, leader)
		local command = string.format("<C-w>%s", direction)
		vim.keymap.set("n", mapping, command, opts)
	end
end

MapWindowMovement()

-- Oil file exporer
vim.keymap.set("n", "<leader>fv", ":lua vim.cmd('Oil ' .. GetCurBufferDir())<CR>", opts) -- Open parent directory of current file
vim.keymap.set("n", "<leader>dv", ":Oil " .. GetCurBufferDir() .. "<CR>", opts) -- Open current working dir

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set(
	"n",
	"<leader><space>",
	":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer=false}))<CR>",
	opts
)
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>:", ":Telescope command_history<CR>", opts)
vim.keymap.set("n", "<leader>tb", ":Telescope buffers show_all_buffers=true<CR>", opts)

vim.keymap.set("n", "<leader>gae", ":Telescope diagnostics theme=dropdown<CR>", opts)
vim.keymap.set("n", "<leader>gs", ":Telescope lsp_document_symbols theme=dropdown<CR>", opts)
vim.keymap.set("n", "<leader>gas", ":Telescope lsp_dynamic_workspace_symbols theme=dropdown<CR>", opts)
vim.keymap.set("n", "<leader>gr", ":Telescope lsp_references theme=dropdown<CR>", opts)
vim.keymap.set("n", "<leader>gd", ":Telescope lsp_definitions<CR>", opts)
vim.keymap.set("n", "<leader>gk", ":Telescope keymaps<CR>", opts)

-- Helper
vim.keymap.set("n", "<leader>cd", ":pwd<CR>", opts)

-- Fun
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", opts)
