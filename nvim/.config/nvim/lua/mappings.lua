vim.g.mapleader = ','

local map = vim.keymap.set

-- Miscellaneous
map("n", "<Leader>w", ":set wrap! linebreak!<CR>")
map("n", "Y", "y$", { remap=true })
map("n", "c", '"_c')
map("v", ".", ":normal .<CR>", { silent=true })
map("v", "<Leader>/", ":nohlsearch<CR>", { silent=true })
map("n", "<PageUp>", "<C-u>", { remap=true })
map("n", "<PageDown>", "<C-d>", { remap=true })

-- LSP
map("n", "<Leader>.L", lsp_toggle_project_mode, { silent=true })
map("n", "<Space>", "<Nop>")

-- Quickfix/location lists
map("n", "<Leader>q", ":ToggleCList<CR>", { silent=true })
map("n", "<Leader>d", ":ToggleLList<CR>", { silent=true })
map("n", "[q", ":Cprev<CR>", { silent=true })
map("n", "]q", ":Cnext<CR>", { silent=true })
map("n", "[d", ":Lprev<CR>", { silent=true })
map("n", "]d", ":Lnext<CR>", { silent=true })
