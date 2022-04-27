-- From https://github.com/jose-elias-alvarez/dotfiles

-- For all docs, can do :help <keyword>

-- nvim lua docs: https://neovim.io/doc/user/lua.html
-- nvim API: https://neovim.io/doc/user/api.html

local get_map_options = function(custom_options)
    local options = { noremap = true, silent = true }
    if custom_options then
        options = vim.tbl_extend("force", options, custom_options)
    end
    return options
end

-- TODO: Define my own autocmd interface

-- https://github.com/nanotee/nvim-lua-guide#modules
local M = {}

-- Although we call it "map", they're really noremap b/c of get_map_options()
M.map = function(mode, target, source, opts)
    vim.api.nvim_set_keymap(mode, target, source, get_map_options(opts))
end

-- Add some common map modes to M
for _, mode in ipairs({ "n", "o", "i", "x", "t" }) do
    M[mode .. "map"] = function(...)
        M.map(mode, ...)
    end
end

-- Buffer-local mapping
M.buf_map = function(mode, target, source, opts, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, get_map_options(opts))
end

-- Defines a ':' command; the bang means redefine the command if it already exists
-- 'command' assigns a name to a ':' command while <cmd>...<CR> avoids mode-changes and doesn't trigger CmdlineEnter/Leave events (helps perf)
M.command = function(name, fn)
    vim.cmd(string.format("command! %s %s", name, fn))
end

M.lua_command = function(name, fn)
    M.command(name, "lua " .. fn)
end

M.t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
    vim.api.nvim_feedkeys(M.t(keys), mode or "i", true)
end

M.warn = function(msg)
    vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
end

return M
