local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local buffer_src_options =
{
    keyword_length = 3,  -- num chars a word must have to appear in autocomplete
    get_bufnrs = function()
        -- complete from visible buffers: https://github.com/hrsh7th/cmp-buffer
        -- limit size of buffers read: https://github.com/hrsh7th/cmp-buffer#performance-on-large-text-files
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
            -- Only use buffers that are less than 10MB
            if byte_size <= 10485760 then
                bufs[vim.api.nvim_win_get_buf(win)] = true
            end
        end
        return vim.tbl_keys(bufs)
    end
}

local mapping =
    {
        ["<c-space>"] = cmp.mapping {
            i = cmp.mapping.complete(),
            c = function()
                if cmp.visible() then
                    if not cmp.confirm({ select = true })then
                        return
                    end
                else
                    cmp.complete()
                end
            end,
        },
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),  -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    }

cmp.setup(
{
    view =
    {
        entries = "native"  -- WARNING: Experimental
    },
    completion =
    {
        -- show popup menu even when only 1 match
        -- do not insert text until user selects match in menu
        completeopt = "menuone,noinsert"
    },
    snippet =
    {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    formatting =
    {
        format = lspkind.cmp_format(
        {
            with_text = true,
            menu =
            {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
            }
        }),
    },
    experimental =
    {
        ghost_text = true  -- WARNING: Conflicts w/Github Copilot
    },
    -- couple of diff ways to specify the mapping
    mapping = mapping,
    -- array of source config to use for completion menu's sort order (i.e., ORDER MATTERS)
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    sources =
    {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        --{ name = "tmux" },
        {
            name = "buffer",
            keyword_length = 5,         -- num chars typed to trigger autocomplete
            option = buffer_src_options
        }
    }
})

-- In / cmdline mode, use a horizontal completion menu
cmp.setup.cmdline('/', {
    view = {
        entries = { name = "wildmenu", separator = '|' }
    },
    mapping = mapping,  -- Used to default to supertab, but cmp removed default, so we have to specify a mapping
    sources = {
        { name = "buffer", keyword_length = 5, option = buffer_src_options }
    }
})

-- : cmdline setup
cmp.setup.cmdline(':', {
    view = {
        entries = { name = "custom" }
    },
    mapping = mapping,
    sources = {
        { name = "path" },
        { name = "cmdline", keyword_length = 5, option = { keyword_length = 3 } }
    }
})

-- Set config for lua filetype
cmp.setup.filetype('lua', {
    sources =
    {
        { name = "nvim_lua" }
    }
})

--[[
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})
--]]

--[[
" Disable cmp for a buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]
