-- Highlights trailing whitespace and automatically removes it on write
-- https://vim.fandom.com/wiki/Highlight_unwanted_spaces
-- Create highlight group
vim.cmd([[
  highlight ExtraWhitespace ctermbg=cyan guibg=cyan
  augroup highlight_extrawhitespace
    autocmd!
    " Prevent colorschemes loaded later from clearing custom highlight groups
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=cyan guibg=cyan
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/             "Matches in all buffers
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/      "Don't match when typing at end of line
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/             "Match after leaving Insert Mode
    autocmd BufWinLeave * call clearmatches()                       "Prevent memory leaks
  augroup END
]])

vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    command = "wincmd =",
    desc = "Resize panes when Vim window is resized",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
    desc = "Briefly highlight on yank",
})

-- Remember folds
local au_id = vim.api.nvim_create_augroup("remember_folds", {clear = true})
-- Indent and manual folding enabled: https://vim.fandom.com/wiki/Folding#Indent_folding_with_manual_folds
-- The first two autocmds will be overriden by treesitter's foldmethod (in treesitter config file)
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*",
    command = "setlocal foldmethod=indent",
    group = au_id,
    desc = "Set 'indent' as fold method before loading file"
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    command = "if &foldmethod == 'indent' | setlocal foldmethod=manual | endif",
    group = au_id,
    desc = "Allow manual folding while editing (only if foldmethod is 'indent')"
})
-- https://vi.stackexchange.com/questions/13864/bufwinleave-mkview-with-unnamed-file-error-32
-- bufleave but not bufwinleave captures closing 2nd tab
-- nested is needed by bufwrite* (if triggered via other autocmd)
-- BufHidden for compatibility with `set hidden`"
vim.api.nvim_create_autocmd({"BufWinLeave", "BufLeave", "BufWritePost", "BufHidden", "QuitPre"}, {
    pattern = "?*",
    command = "silent! mkview!",
    nested = true,
    group = au_id,
    desc = "Save folds"
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "?*",
    command = "silent! loadview",
    group = au_id,
    desc = "Load folds"
})

-- Remove blank lines at end of file and remember cursor position
-- https://stackoverflow.com/questions/7495932/how-can-i-trim-blank-lines-at-the-end-of-file-in-vim
vim.cmd([[
  function TrimEndLinesAndTrailingWhitespace()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##  "Substitute adjacent lines terminated by EOF w/null string
    silent! %s#\s\+$##e           "Remove trailing whitespace
    call setpos('.', save_cursor)
  endfunction
]])
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = "g:TrimEndLinesAndTrailingWhitespace",
    desc = "Remove blank lines at end of file and remember cursor position",
})

-- Do not auto-wrap comments using textwidth
-- Do not automatically insert comment leader after hitting o or O in Normal mode
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=o formatoptions-=c",
    desc = "Set options for how Vim formats text"
})
