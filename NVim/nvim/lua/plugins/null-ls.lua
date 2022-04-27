local null_ls = require("null-ls")

null_ls.setup({
        sources = {
                null_ls.builtins.formatting.stylua,
                -- require("null-ls").builtins.diagnostics.eslint,
                -- require("null-ls").builtins.completion.spell,
        },
})
