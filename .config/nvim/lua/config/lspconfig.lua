local lspconfig = require("lspconfig")
local opts = { noremap = true, silent = true }

-- See ":help vim.diagnostic.*" for docs
vim.keymap.set("n", "<leader>ge", ":lua vim.diagnostic.open_float()<CR>", opts)

-- Enable keybinds for available lsp server
local custom_attach = function(_, bufnr)
	-- See ":help vim.lsp.*" for docs
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", ":lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)

	vim.api.nvim_buf_set_keymap(bufnr, "n", ",wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", ",wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		",wl",
		":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
end

local custom_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
custom_capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Lua language server (Lua)
lspconfig["lua_ls"].setup({
	capabilities = custom_capabilities,
	on_attach = custom_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- Clangd (C/C++)
lspconfig["clangd"].setup({
	capabilities = custom_capabilities,
	on_attach = custom_attach,
	filetypes = { "c", "cpp" },
	cmd = {
		"clangd",
		"--all-scopes-completion",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--header-insertion-decorators",
		"--header-insertion=iwyu",
		"-j=4",
		"--pch-storage=memory",
		"--pretty",
		-- "--log=verbose",
	},
	init_option = { fallbackFlags = { "-std=c99" } },
	root_dir = require("lspconfig").util.root_pattern(".git", ".clang-format"),
})

-- CMake (build system)
lspconfig["cmake"].setup({
	capabilities = custom_capabilities,
	on_attach = custom_attach,
})

-- Odin
lspconfig["ols"].setup({
	capabilities = custom_capabilities,
	on_attach = custom_attach,
})
