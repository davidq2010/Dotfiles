" Open NERDTree when vim starts up without files specified
autocmd vimrc_group StdinReadPre * let s:std_in=1
function! OpenNerdTree()
    if argc() == 0 && !exists("s:std_in")
        exec "NERDTree"
    endif
endfunction
autocmd vimrc_group VimEnter * call OpenNerdTree()

" How to close vim if the only window left open is a NERDTree
function! CloseNerdTree()
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.IsTabTree())
        exec "q"
    endif
endfunction
autocmd vimrc_group bufenter * call CloseNerdTree()

" Let <leader>nt be :NERDTree
nmap <leader>nt :NERDTree<cr>

" Let <leader>ntf be :NERDTreeFind
nmap <leader>ntf :NERDTreeFind<cr>
