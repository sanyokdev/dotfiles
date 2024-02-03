-- Auto-install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
	-- Colorscheme
	{ "catppuccin/nvim" },

	-- File management
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				-- Restore window options to previous values when leaving an oil buffer
				restore_win_options = false,
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
				},
			})
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
	},

	-- IDE visuals
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "onenord",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.1",
		build = ":TSUpdate",
		event = "BufReadPre",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "markdown", "c", "cpp", "cmake", "make" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- Managing & installing lsp servers, linters & formatters
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"cmake",
					"zls",
				},
			})
		end,
	},

	-- Configuring LSP servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "LspAttach",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				floating_window = false,
				hint_prefix = "",
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- lsp capabilities
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-cmdline", -- source for vim cmd

			-- Snippets
			{ "L3MON4D3/LuaSnip", version = "2.2.0" }, -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- source for autocomplete
		},
	},

	-- Formatting
	{
		"mhartington/formatter.nvim",
		event = { "BufReadPost" },
		config = function()
			-- A temporary monkey-patch until this is fixed @midrare
			local patch_clangformat_bug = function(f)
				local o = f()
				if o.args and type(o.args) == "table" then
					local new_args = {}
					local skip = false
					for i, v in ipairs(o.args) do
						if skip then
							skip = false
						elseif v == "-assume-filename" and (o.args[i + 1] == "''" or o.args[i + 1] == '""') then
							skip = true
						elseif type(v) ~= "string" or not v:find("^-style=") then
							table.insert(new_args, v)
						end
					end
					o.args = new_args
				end
				return o
			end

			require("formatter").setup({
				filetype = {
					lua = { require("formatter.filetypes.lua").stylua },
					c = { patch_clangformat_bug(require("formatter.filetypes.c").clangformat) },
					cpp = { patch_clangformat_bug(require("formatter.filetypes.cpp").clangformat) },
				},
			})
		end,
	},

	-- Utility
	{
		"numToStr/Comment.nvim",
		tag = "v0.8.0",
		event = "BufReadPre",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
				},
			})
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = false },
			})
		end,
	},

	-- Fun
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
})
