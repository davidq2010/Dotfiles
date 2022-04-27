-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD leader.
vim.g.mapleader = ","

-- Mappings
require("config.mappings")

-- Autocmds
require("config.autocommands")

-- The following will look for lua/*/init.lua
require("lsp")
require("plugins")

-- Vim options
require("config.options") -- Sources lua/config/options.lua
