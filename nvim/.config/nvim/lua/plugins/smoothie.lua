vim.g.smoothie_enabled = os.getenv("NVIM_SMOOTHIE_ENABLED")

if vim.g.smoothie_enabled == nil then
	vim.g.smoothie_enabled = true
end

function toggle_vim_smoothie()
	if vim.g.smoothie_enabled then
		vim.g.smoothie_enabled = false
		vim.cmd.echo("'Smooth scrolling disabled.'")
	else
		vim.g.smoothie_enabled = true
		vim.cmd.echo("'Smooth scrolling enabled.'")
	end
end

map("n", "<Leader>S", toggle_vim_smoothie)
