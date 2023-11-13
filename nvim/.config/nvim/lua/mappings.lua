local map = vim.keymap.set

vim.g.mapleader = ','

-- Miscellaneous
map("n", "<Leader>w", ":set wrap! linebreak!<CR>")
map("n", "Y", "y$", { remap=true })
map("n", "c", '"_c')
map("v", ".", function() vim.cmd.normal(".") end, { silent=true })
map("v", "<Leader>/", vim.cmd.nohlsearch, { silent=true })
map("n", "<PageUp>", "<C-u>", { remap=true })
map("n", "<PageDown>", "<C-d>", { remap=true })
map("n", "<Leader>s", "set spell!<CR>")

-- LSP
map("n", "<Leader>.L", lsp_toggle_project_mode, { silent=true })
map("n", "<Space>", "<Nop>")

-- Quickfix/location lists
map("n", "<Leader>q", vim.cmd.ToggleCList, { silent=true })
map("n", "<Leader>d", vim.cmd.ToggleLList, { silent=true })
map("n", "[q", vim.cmd.Cprev, { silent=true })
map("n", "]q", vim.cmd.Cnext, { silent=true })
map("n", "[d", vim.cmd.Lprev, { silent=true })
map("n", "]d", vim.cmd.Lnext, { silent=true })

-- Folds and indentation
map("n", "<M-i>", "zA")
map("n", "<M-I>", "za")
map("n", "<M-m>", "zM")
map("n", "<M-r>", "zR")
map("n", "<Leader>T", indent_style_toggle)
