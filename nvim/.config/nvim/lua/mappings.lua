-- Miscellaneous
map("n", "<Leader>w", ":set wrap! linebreak!<CR>", {silent=true})
map("n", "Y", "y$", {remap=true})
map("n", "c", '"_c')
map("v", ".", ":norm .<CR>")
map("n", "<Leader>/", vim.cmd.nohlsearch)
map("n", "<PageUp>", "<C-u>", {remap=true})
map("n", "<PageDown>", "<C-d>", {remap=true})

-- Toggle spell checker
map("n", "<Leader>s",
	function()
		if wo.spell then
			wo.spell = false
			vim.cmd.echo("'Spell check: disabled'")
		else
			wo.spell = true
			vim.cmd.echo("'Spell check: enabled'")
		end
	end
)

-- netrw
map("n", "<Leader>t", function() vim.cmd("Lex!") end)

-- Folds and indentation
map("n", "<M-i>", "zA")
map("n", "<M-I>", "za")
map("n", "<M-m>", "zM")
map("n", "<M-r>", "zR")

-- Hexdump editing (requires xxd)
map("n", "<Leader>x", ":%!xxd<CR>:set filetype=xxd<CR>", {silent=true})
map("n", "<Leader>X", ":%!xxd -r<CR>:filetype detect<CR>", {silent=true})

-- Window splits
map("n", "<M-h>", "<C-w>h")
map("n", "<M-j>", "<C-w>j")
map("n", "<M-k>", "<C-w>k")
map("n", "<M-l>", "<C-w>l")
map("n", "<Bar>", "<C-w><Bar>")
map("n", "_", "<C-w>_")
map("n", "<M-s>", vim.cmd.vsplit)
map("n", "<Leader><M-s>",vim.cmd.split)

-- Window buffers
map("n", "<M-CR>", vim.cmd.write)
map("n", "<M-q>", vim.cmd.quit)
map("n", "<M-w>", vim.cmd.Bdelete)
map("n", "<M-n>", vim.cmd.bnext)
map("n", "<M-p>", vim.cmd.bNext)

-- Window Tabs
map("n", "<M-t>", vim.cmd.tabnew)
map("n", "<M-[>", vim.cmd.tabprevious)
map("n", "<M-]>", vim.cmd.tabnext)
map("n", "<M-{>", ":-tabmove<CR>", {silent=true})
map("n", "<M-}>", ":+tabmove<CR>", {silent=true})

-- Map common motions to alt
map("i", "<M-h>", "<Left>")
map("i", "<M-j>", "<Down>")
map("i", "<M-k>", "<Up>")
map("i", "<M-l>", "<Right>")
map("", "<M-e>", "<C-e>", {remap=true})
map("", "<M-y>", "<C-y>", {remap=true})
map("", "<M-d>", "<C-d>", {remap=true})
map("", "<M-u>", "<C-u>", {remap=true})
map("", "<M-f>", "<C-f>", {remap=true})
map("", "<M-b>", "<C-b>", {remap=true})

-- Copy shortcuts
map("n", "<M-a>", ":%y+<CR>", {silent=true})
map("v", "<M-a>", '"+y')

-- Shell/Emacs-like shortcuts
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")
map("i", "<C-y>", "<C-o>P")

-- Paste current date
map("i", "<C-d>", "<C-r>=strftime('%a %Y-%m-%d')<CR>", {silent=true})
map("i", "<Leader><C-d>", "<C-r>=strftime('%Y-%m-%d')<CR>", {silent=true})
map("i", "<Leader>.<C-d>", "<C-r>=strftime('%A, %B %e, %Y')<CR>", {silent=true})

-- Wrap-friendly motions
map("n", "k", "gk")
map("n", "gk", "k")
map("n", "j", "gj")
map("n", "gj", "j")

-- Center screen after search
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Keymap for surrounding character/selection with spaces,
-- because I had to fix too many people's code that don't surround operators
-- with spaces >:(
map("n", "<M-1>", "ysl l", {remap=true})
map("v", "<M-1>", "S l", {remap=true})
