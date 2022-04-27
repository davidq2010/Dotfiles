" Put all ungrouped autocmds in this group so they aren't piled up when vimrc is re-sourced
" https://gist.github.com/romainl/6e4c15dfc4885cb4bd64688a71aa7063
augroup vimrc_group
  autocmd!
augroup END

" Source plugins file if it exists
function! SourceIfExists(file)
  if !empty(glob(expand(a:file)))
    exec "source" a:file
  endif
endfunction

call SourceIfExists("~/.config/nvim/functions.vim")
call SourceIfExists("~/.config/nvim/plugins.vim")

"---------- CORE COMMANDS ----------
" Config tabs (autoindent, smarttab, syntax already enabled by default in nvim)
set expandtab     "expand tab characters to spaces
set smartindent   "like autoindent but uses some syntax rules to help

set number

" Highlights trailing whitespace and automatically removes it on write
" https://vim.fandom.com/wiki/Highlight_unwanted_spaces
" Create highlight group
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

" Mappings that should exist in nvim startup by default but don't...
nnoremap Y y$
" https://vim.fandom.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
" https://stackoverflow.com/a/662914
nnoremap <silent> <CR> <Cmd>nohlsearch<CR><CR>

"allows latex suite to recognize all .tex files for syntax highlighting
let g:tex_flavor='latex'

"allow as many tabs to be open with -p as possible
set tpm=30

"set spell check to be on for certain filetypes
augroup spellcheck
  autocmd!
  autocmd FileType tex setlocal spell
  autocmd FileType html setlocal spell
augroup END

"set colorscheme to default
colorscheme ron

set showmode

" Resize panes in a tab when Terminal window is resized
autocmd vimrc_group VimResized * wincmd =

augroup remember_folds
  autocmd!
  " Indent folding + manual folding enabled
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
  " Save folds and restore them for a file
  au BufWinLeave * mkview
  au BufWinEnter * silent! loadview
augroup END

autocmd vimrc_group BufWritePre * call TrimEndLinesAndTrailingWhitespace() " Do this before writing to buffer
