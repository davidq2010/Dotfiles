local lspconfig = require("lspconfig")
local M = {}

--https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright has the defaults
M.setup = function(on_attach)
    lspconfig.pyright.setup({ on_attach = on_attach })
end

return M
