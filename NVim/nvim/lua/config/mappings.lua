local u = require("utils")

u.nmap("Y", "y$")
-- https://vim.fandom.com/wiki/Recover_from_accidental_Ctrl-U
u.imap("<C-U>", "<C-G>u<C-U>")
u.imap("<C-W>", "<C-G>u<C-W>")
-- https://stackoverflow.com/a/662914
u.nmap("<CR>", "<Cmd>nohlsearch<CR><CR>")
