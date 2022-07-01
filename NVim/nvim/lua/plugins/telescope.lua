local telescope = require("telescope")

telescope.setup{
    defaults = {
        prompt_prefix = ': ',
        selection_caret = '> ',
        layout_config = { horizontal = { preview_width = 0.5 } },
        -- https://github.com/nvim-telescope/telescope.nvim#default-mappings
        mappings = {
            i = {
                ['<C-j>'] = "move_selection_next",
                ['<C-k>'] = "move_selection_previous",
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            },
            n = { ['<C-c>'] = "close" },
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
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

telescope.load_extension('fzf')
