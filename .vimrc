set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
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
:highlight ExtraWhitespace ctermbg=cyan guibg=cyan
:match ExtraWhitespace /\s\+$/
:autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
:autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * match ExtraWhitespace /\s\+$/
:autocmd BufWinLeave * call clearmatches()
:autocmd InsertLeave * redraw!
:autocmd BufWritePre * :%s/\s\+$//e

"allows latex suite to recognize all .tex files for syntax highlighting
:let g:tex_flavor='latex'

"allow as many tabs to be open with -p as possible
:set tpm=30

"allows doxygen formatting to be used
:let g:load_doxygen_syntax=1

"let .incl files be viewed with PHP syntax
:au BufNewFile,BufRead *.incl set ft=php

"set spell check to be on for certain filetypes
:autocmd FileType tex setlocal spell
:autocmd FileType html setlocal spell
:autocmd FileType php setlocal spell

"set colorscheme to default
:colorscheme ron

"allow backspace over line break"
:set backspace=indent,eol,start
:set backspace=2

:set showmode

set noerrorbells                " No beeps

