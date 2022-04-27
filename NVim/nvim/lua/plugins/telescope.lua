local telescope = require("telescope")

telescope.setup{
    defaults = {
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        layout_config = { horizontal = { preview_width = 0.5 } },
        mappings = {
            i = {
                ['<C-j>'] = telescope.actions.move_selection_next,
                ['<C-k>'] = telescope.actions.move_selection_previous,
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            },
            n = { ['<C-c>'] = telescope.actions.close },
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        --Your extension configuration goes here:
        -- extension_name = {
        --extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}
