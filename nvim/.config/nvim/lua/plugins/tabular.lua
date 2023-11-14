local map = vim.keymap.set

map("v", "<Leader>t=", ":Tabular/=<CR>", {silent=true})
map("v", "<Leader>t-", ":Tabular/-<CR>", {silent=true})
map("v", "<Leader>t+", ":Tabular/+<CR>", {silent=true})
map("v", "<Leader>t<", ":Tabular/<<CR>", {silent=true})
map("v", "<Leader>t>", ":Tabular/><CR>", {silent=true})
map("v", "<Leader>t,", ":Tabular/,/l0r1<CR>", {silent=true})
map("v", "<Leader>t;", ":Tabular/;/l0r1<CR>", {silent=true})
