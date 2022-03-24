if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

" Run :source ~/.config/nvim/init.vim and :PlugInstall to install plugins
" https://github.com/junegunn/vim-plug#commands
" :PlugUpdate to update plugins
" Run :PlugUpgrade to upgrade vim-plug itself
" :PlugClean to delete unused plugins
call plug#begin()
" Make sure you use single quotes
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }  "On-demand loading

Plug 'luochen1990/rainbow'                              "Parentheses highlighting

Plug 'preservim/nerdcommenter'

Plug 'christoomey/vim-tmux-navigator'                   "Tmux conf is .tmux.conf

Plug 'maxmellon/vim-jsx-pretty'                         "React syntax highlighting and indenting plugin for vim

Plug 'jiangmiao/auto-pairs'                             "Auto pair brackets

" NodeJS >= 12.12 required: https://github.com/nodesource/distributions/blob/master/README.md
"Plug 'neoclide/coc.nvim', {'branch': 'release'}         "Release branch recommended

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
endif

" All of your Plugins must be added before the following line
call plug#end()

" Source lua/lsp/init.lua, which sources all lsp-related config
" Source lua/plugin/init.lua, which sources all lua plugin-related config
if has("nvim")
  lua require("lsp")
  lua require("plugin")
endif
