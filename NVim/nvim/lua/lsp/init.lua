local u = require("utils")

local lsp = vim.lsp

-- Neovim stable doesn't have diagnostics API yet
--vim.diagnostic.config({ virtual_text = false, float = border_opts })
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
})

-- border and focusable are options for lsp.handlers.hover/signature_help
-- scope is an option for diagnostic.open_float
-- We just shove them all together and the lsp/diagnostics functions just pick out the options they need from the table.
local border_opts = { border = "single", focusable = false }--, scope = "line" }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)


-- So that we can create the lua command globally (global vars don't need declarations)
_G.diag_border_opts = { scope = "line" }

local on_attach = function(client, bufnr)
    -- commands
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    -- https://github.com/nanotee/nvim-lua-guide#caveats
    -- v:lua is a global Vim variable that allows you to call Lua functions in global namespace _G directly from Vimscripit
    --u.lua_command("LspDiagPrev", "vim.lsp.diagnostic.goto_prev({ popup_opts = v:lua.diag_border_opts })")
    u.lua_command("LspDiagPrev", "vim.lsp.diagnostic.goto_prev({ popup_opts = diag_border_opts })")
    u.lua_command("LspDiagNext", "vim.lsp.diagnostic.goto_next({ popup_opts = diag_border_opts })")
    u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(diag_border_opts)")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")  -- Fixed in later neovim version

    -- bindings
    u.buf_map("n", "gi", ":LspRename<CR>", nil, bufnr)
    u.buf_map("n", "gy", ":LspTypeDef<CR>", nil, bufnr)
    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
    u.buf_map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
    u.buf_map("n", "<Leader>a", ":LspDiagLine<CR>", nil, bufnr)
    u.buf_map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

    -- telescope
    u.buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
    u.buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)
    u.buf_map("n", "ga", ":LspAct<CR>", nil, bufnr)
    u.buf_map("v", "ga", "<Esc><cmd> LspRangeAct<CR>", nil, bufnr)
end

require("lsp.pyright").setup(on_attach)
