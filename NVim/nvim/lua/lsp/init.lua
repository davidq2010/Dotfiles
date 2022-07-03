local u = require("utils")

local lsp = vim.lsp

-- Diagnostic framework displays errors/warnings from external tools (e.g., linters, LSP servers)
u.map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", nil)
u.map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", nil)
u.map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", nil)
u.map("n", "<space>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", nil) -- Add all diagnostics to quickfix list
u.map("n", "<space>l", "<cmd>lua vim.diagnostic.setloclist()<CR>", nil) -- Add buffer diagnostics to location list

-- Set non-default global diagnostic visualization config values
vim.diagnostic.config({ virtual_text = false })

-- border and focusable are options for lsp.handlers.hover/signature_help (see :nvim_open_win)
local border_opts = { border = "single", focusable = false }

-- This is one of the ways we can set lsp handlers (see :help lsp.handlers)
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

local default_on_attach = function(client, bufnr)
	-- Mappings
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
	u.buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", nil, bufnr)
	u.buf_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", nil, bufnr)
	u.buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", nil, bufnr)
	u.buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", nil, bufnr)
	u.buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", nil, bufnr)
	u.buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", nil, bufnr)
	u.buf_map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", nil, bufnr)
	u.buf_map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", nil, bufnr)
	u.buf_map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", nil, bufnr)
	u.buf_map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", nil, bufnr)
	u.buf_map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", nil, bufnr)
	u.buf_map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", nil, bufnr)
	u.buf_map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", nil, bufnr)
	u.buf_map("n", "<space>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", nil, bufnr)

	require("illuminate").on_attach(client)

	-- https://github.com/jose-elias-alvarez/null-ls.nvim#how-do-i-stop-neovim-from-asking-me-which-server-i-want-to-use-for-formatting
	if client.name ~= "null-ls" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

local lsp_installer = require("nvim-lsp-installer")

local servers = {
    "bashls",
    "ccls",
	'cssls',
	"jsonls",
    "omnisharp",
	"pyright",
	--'eslint',
	"sumneko_lua",
	'tsserver'
}

-- These are based on schemas, which you can see by :LspInstallInfo and expanding installed servers -> schemas
-- Can also look under https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/_generated/schemas
local special_config = {
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	["sumneko_lua"] = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },  -- define 'vim' as a global for diagnostics (so no warning about undefined var)
				},
			},
		},
	},
}

-- automatically install missing language servers
for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end

lsp_installer.on_server_ready(function(server)
	local config = special_config[server.name] or {}
	-- tell server what the client's (i.e., nvim's) completion capabilities are
	config.capabilities = vim.lsp.protocol.make_client_capabilities()
	-- override some of nvim's default capabilities w/cmp_nvim_lsp's broader capabilities
	config.capabilities = require("cmp_nvim_lsp").update_capabilities(config.capabilities)

	-- set on_attach handler
	config.on_attach = default_on_attach
	server:setup(config)
end)
