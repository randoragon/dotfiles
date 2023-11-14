function indent_style_tab(n)
	n = n or 8
	bo.expandtab = false
	bo.shiftwidth = n
	bo.tabstop = n
	bo.softtabstop = 0
	vim.cmd.echo(("'Indent style: %d-width tabs'"):format(n))
end

function indent_style_sp(n)
	n = n or 4
	bo.expandtab = true
	bo.shiftwidth = n
	bo.tabstop = n
	bo.softtabstop = n
	vim.cmd.echo(("'Indent style: %d spaces'"):format(n))
end

function indent_style_toggle()
	if vim.bo.expandtab then
		indent_style_tab()
	else
		indent_style_sp()
	end
end

indent_style_tab()
map("n", "<Leader>T", indent_style_toggle)
