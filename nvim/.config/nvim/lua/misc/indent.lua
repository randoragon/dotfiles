function indent_style_tab(n, echo)
	n = n or 8
	bo.expandtab = false
	bo.shiftwidth = n
	bo.tabstop = n
	bo.softtabstop = 0
	if echo then
		vim.cmd.echo(("'Indent style: %d-width tabs'"):format(n))
	end
end

function indent_style_sp(n, echo)
	n = n or 4
	bo.expandtab = true
	bo.shiftwidth = n
	bo.tabstop = n
	bo.softtabstop = n
	if echo then
		vim.cmd.echo(("'Indent style: %d spaces'"):format(n))
	end
end

function indent_style_toggle()
	if vim.bo.expandtab then
		indent_style_tab(8, true)
	else
		indent_style_sp(4, true)
	end
end

indent_style_tab()
map("n", "<Leader>T", indent_style_toggle)
