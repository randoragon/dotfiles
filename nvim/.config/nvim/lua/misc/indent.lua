local bo = vim.bo

function indent_style_tab(n)
	bo.expandtab = false
	bo.shiftwidth = n or 8
	bo.tabstop = n or 8
	bo.softtabstop = 0
end

function indent_style_sp(n)
	bo.expandtab = true
	bo.shiftwidth = n or 4
	bo.tabstop = n or 4
	bo.softtabstop = 4
end

function indent_style_toggle()
	if bo.expandtab then
		indent_style_tab()
	else
		indent_style_sp()
	end
end

indent_style_tab()

-- For markdown folding
-- https://stackoverflow.com/a/4677454
function indent_markdown_level()
	local h = vim.fn.matchstr(vim.fn.getline(vim.v.lnum), "^#\\+")
	if vim.fn.empty(h) then
		return "="
	else
		return (">"):rep(h)
	end
end
