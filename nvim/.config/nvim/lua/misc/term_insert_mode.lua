-- Automatically enter insert mode when starting a terminal in NeoVim
-- https://github.com/neovim/neovim/issues/8816#issuecomment-410512452
if vim.fn.has("nvim") then
	autocmd(
		"TermOpen", {
			pattern = "term://*",
			callback = function()  -- Must be wrapped in a lambda to discard arguments
				vim.cmd.startinsert()
			end,
		}
	)
end
