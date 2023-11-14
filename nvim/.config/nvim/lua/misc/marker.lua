-- <,,> marker functions

function goto_marker()
	return vim.fn.search("<,,>", "cswz") ~= 0
end

function get_last_selection()
	-- Get the lines in the selection
	local pos1, pos2 = vim.fn.getpos("'<"), vim.fn.getpos("'>")
	local line1, ncol1 = pos1[2], pos1[3]
	local line2, ncol2 = pos2[2], pos2[3]
	local lines = vim.fn.getline(line1, line2)
	if #lines == 0 then
		return ""
	end

	-- Truncate pending newline if selection isn't inclusive
	if o.selection == "inclusive" then
		lines[#lines] = lines[#lines]:sub(1, ncol2)
	else
		lines[#lines] = lines[#lines]:sub(1, ncol2 - 1)
	end
	lines[1] = lines[1]:sub(ncol1)
	while lines[1]:sub(1, 1) == "\t" do
		lines[1] = lines[1]:sub(2)
	end
	return table.concat(lines, "\n")
end

-- Jump to the next marker
map("n", "<M-o>", ':lua goto_marker()<CR>"_cf>', {silent=true})
map("i", "<M-o>", '<Esc>:lua goto_marker()<CR>"_cf>', {silent=true})

-- Yank current line/selection, jump to next marker and paste
map("n", "<M-O>", '^"py$:lua goto_marker()<CR>"pPl"_df>', {silent=true})
map("i", "<M-O>", '<Esc>^"py$:lua goto_marker()<CR>"pPl"_df>', {silent=true})
map("v", "<M-O>", '<Esc>:lua goto_marker()<CR>"_df>"=luaeval("get_last_selection()")<CR>P', {silent=true})
