" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Run :source % and :PluginInstall to install plugins
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'

Plugin 'luochen1990/rainbow' " parentheses highlighting

Plugin 'preservim/nerdcommenter'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'maxmellon/vim-jsx-pretty'

" All of your Plugins must be added before the following line
call vundle#end()            " required


" Rainbow Plugin Options (luochen1990/rainbow)
let g:rainbow_active = 1  " 0 if you want to enable it later via :RainbowToggle

" Open NERDTree when vim starts up without files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" How to close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Let <leader>nt be :NERDTree
nmap <leader>nt :NERDTree<cr>

" Let <leader>ntf be :NERDTreeFind
nmap <leader>ntf :NERDTreeFind<cr>
