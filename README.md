# Tmux
If using tmux, it's assumed that you're using Vim with it, so need to do the following:
1. Install Tmux Package Manager:
    1. git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
2. In .tmux.conf press "\<prefix\> + I" (e.g., Ctrl-a + I) to install plugins.
    1. Currently, the only tmux plugin installed is vim-tmux-navigator.

# General
1. .vimrc reads plugins if ~/.vim/vim_plugins.vimrc exists.
2. If using plugins, install Vundle:
    1. git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    2. Within .vimrc, run ":source %" then :PluginInstall to install plugins using Vundle.

# .bash_aliases_personal
Put personal aliases in .bash_aliases_personal
