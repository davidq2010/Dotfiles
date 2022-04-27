local u = require("utils")

--[[ local illuminate = require("illuminate")

u.nmap("<a-n>", function()
    illuminate.next_reference({ wrap = true })
end)
u.nmap("<a-p>", function()
    illuminate.next_reference({ reverse = true, wrap = true })
end) ]]

u.nmap("<a-n>", '<cmd> lua require"illuminate".next_reference{wrap=true}<CR>')
u.nmap("<a-p>", '<cmd> lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>')
