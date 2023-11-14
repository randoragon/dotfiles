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

-- Hexdump editing (requires xxd)
map("n", "<Leader>x", ":%!xxd<CR>:set filetype=xxd<CR>", { silent=true })
map("n", "<Leader>X", ":%!xxd -r<CR>:filetype detect<CR>", { silent=true })

-- Window splits
map("n", "<M-h>", "<C-w>h")
map("n", "<M-j>", "<C-w>j")
map("n", "<M-k>", "<C-w>k")
map("n", "<M-l>", "<C-w>l")
map("n", "<Bar>", "<C-w><Bar>")
map("n", "_", "<C-w>_")
map("n", "<M-s>", vim.cmd.vsplit, { silent=true })
map("n", "<Leader><M-s>",vim.cmd.split, { silent=true })

-- Window buffers
map("n", "<M-CR>", vim.cmd.write, { silent=true })
map("n", "<M-q>", vim.cmd.quit, { silent=true })
map("n", "<M-w>", vim.cmd.Bdelete, { silent=true })
map("n", "<M-n>", vim.cmd.bnext, { silent=true })
map("n", "<M-p>", vim.cmd.bNext, { silent=true })

-- Window Tabs
map("n", "<M-t>", vim.cmd.tabnew, { silent=true })
map("n", "<M-[>", vim.cmd.tabprevious, { silent=true })
map("n", "<M-]>", vim.cmd.tabnext, { silent=true })
map("n", "<M-{>", ":-tabmove<CR>", { silent=true })
map("n", "<M-}>", ":+tabmove<CR>", { silent=true })

-- Map common motions to alt
map("i", "<M-h>", "<Left>")
map("i", "<M-j>", "<Down>")
map("i", "<M-k>", "<Up>")
map("i", "<M-l>", "<Right>")
map("", "<M-e>", "<C-e>", { remap=true })
map("", "<M-y>", "<C-y>", { remap=true })
map("", "<M-d>", "<C-d>", { remap=true })
map("", "<M-u>", "<C-u>", { remap=true })
map("", "<M-f>", "<C-f>", { remap=true })
map("", "<M-b>", "<C-b>", { remap=true })

-- Copy shortcuts
map("n", "<M-a>", ":%y+<CR>", { silent=true })
map("v", "<M-a>", '"+y')

-- Shell/Emacs-like shortcuts
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")
map("i", "<C-y>", "<C-o>P")

-- Paste current date
map("i", "<C-d>", "<C-r>=strftime('%a %Y-%m-%d')<CR>", { silent=true })
map("i", "<Leader><C-d>", "<C-r>=strftime('%Y-%m-%d')<CR>", { silent=true })
map("i", "<Leader>.<C-d>", "<C-r>=strftime('%A, %B %e, %Y')<CR>", { silent=true })

-- Wrap-friendly motions
map("n", "k", "gk")
map("n", "gk", "k")
map("n", "j", "gj")
map("n", "gj", "j")
