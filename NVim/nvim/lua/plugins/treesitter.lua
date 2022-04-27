require("nvim-treesitter.configs").setup({
        ensure_installed = "all",

        highlight = {
                enable = true -- false will disable whole extension
                -- disable = { 'json' }, -- list of language that will be disabled
        },
        indent = { enable = true },    -- experimental (indentation based on treesitter for = operator)

        -- plugins
        autotag = { enable = true },
        rainbow = { enable = true },
        context_commentstring = { enable = true },
})
