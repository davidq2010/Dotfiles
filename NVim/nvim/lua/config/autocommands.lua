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

-- Resize panes when Vim window resized
vim.cmd('autocmd! VimResized * wincmd =')

-- Highlight on yank
vim.cmd('autocmd! TextYankPost * lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })')

-- Remember folds
vim.cmd([[
  augroup remember_folds
    autocmd!
    " Indent folding + manual folding enabled
    autocmd BufReadPre * setlocal foldmethod=indent
    autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
    " Save folds and restore them for a file
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
  augroup END
]])

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

vim.cmd([[autocmd! BufWritePre * call TrimEndLinesAndTrailingWhitespace()]])

vim.cmd([[autocmd! FileType * setlocal formatoptions-=o formatoptions-=c]])
