-- Required by nvim-treesitter-commentstring: https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
-- Default mappings at https://github.com/numToStr/Comment.nvim#-usage
-- comment.nvim supports nvim's commentstring, but it's last in the priority order (first is pre_hook)
require("Comment").setup({
        -- integrate with nvim-ts-context-commentstring for more advanced use cases (tsx/jsx)
        pre_hook = function(ctx)
                local comment_utils = require("Comment.utils")
                local type = ctx.ctype == comment_utils.ctype.line and "__default" or "__multiline"

                local location = nil
                if ctx.ctype == comment_utils.ctype.block then
                        location = require("ts_context_commentstring.utils").get_cursor_location()
                elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
                        location = require("ts_context_commentstring.utils").get_visual_start_location()
                end

                return require("ts_context_commentstring.internal").calculate_commentstring({
                        key = type,
                        location = location,
                })
        end,
})
