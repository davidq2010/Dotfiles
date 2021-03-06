set nocompatible              " be iMproved, required
filetype off                  " required

" Source plugins file if it exists
function SourceIfExists(file)
  if !empty(glob(expand(a:file)))
    exec "source" a:file
  endif
endfunction

call SourceIfExists("~/.vim/vim_plugins.vimrc")

filetype plugin indent on    " required
" To ignore plugin *indent* changes, instead use:
"filetype plugin on

""" CORE COMMANDS """
"show line numbers on the left
:set number

"highlight search strings
:set hlsearch

:set textwidth=80

:set expandtab     "expand tab characters to spaces
:set smarttab      "use sw for tab characters
:syntax on
:set autoindent    "use indent from previous line to decide indenting
:set smartindent   "like autoindent but uses some syntax rules to help

"highlights 3 columns after 80 characters, to let you know to end your line
:set colorcolumn=+1,+2,+3  " highlight three columns after 'textwidth'
:highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

"highlights trailing whitespace and automatically removes it on write
"Create highlight group
:highlight ExtraWhitespace ctermbg=cyan guibg=cyan
"Prevent colorschemes loaded later from clearing custom highlight groups
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=cyan guibg=cyan
:match ExtraWhitespace /\s\+$/
:autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
:autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * match ExtraWhitespace /\s\+$/
:autocmd BufWinLeave * call clearmatches()
"Remove trailing whitespace on write
:autocmd BufWritePre * :%s/\s\+$//e

"allows latex suite to recognize all .tex files for syntax highlighting
:let g:tex_flavor='latex'

"allow as many tabs to be open with -p as possible
:set tpm=30

"allows doxygen formatting to be used
:let g:load_doxygen_syntax=1

"set spell check to be on for certain filetypes
:autocmd FileType tex setlocal spell
:autocmd FileType html setlocal spell

"set colorscheme to default
:colorscheme ron

"allow backspace over line break"
:set backspace=indent,eol,start
:set backspace=2

:set showmode

set noerrorbells                " No beeps

" See when <leader> is pressed
set showcmd

" Resize panes in a tab when Terminal window is resized
autocmd VimResized * wincmd =

" Indent folding + manual folding enabled
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" Save folds and restore them for a file
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Remove blank lines at end of file and remember cursor position
function TrimEndLines()
  let save_cursor = getpos(".")
  silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction

autocmd BufWritePre * call TrimEndLines()
