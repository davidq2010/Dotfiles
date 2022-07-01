local null_ls = require("null-ls")

null_ls.setup({
        sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.diagnostics.cppcheck,
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.diagnostics.shellcheck,
                -- require("null-ls").builtins.completion.spell,
        },
})
