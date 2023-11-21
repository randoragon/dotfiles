-- Automatic templates for new files of certain types

-- Substitutions to do on the template files
local substitutions = {
	["<DATE>"] = function() return vim.fn.strftime("%A, %B %e, %Y") end,
}

function try_load_template()
	if not vim.b.is_new_file then
		return
	end
	local fpath = os.getenv("HOME") .. "/.config/nvim/templates/" .. bo.filetype
	local ok, result = pcall(vim.fn.filereadable, fpath)
	if ok and result == 1 then
		lines = {}
		for line in io.lines(fpath) do
			for pattern, action in pairs(substitutions) do
				local new_val
				if type(action) == "string" then
					new_val = action
				elseif type(action) == "function" then
					new_val = action()
				end
				assert(type(new_val) == "string")
				line = line:gsub(vim.pesc(pattern), new_val)
			end
			lines[#lines + 1] = line
		end
		vim.fn.setline(1, lines)

		-- Place cursor in the spot indicated by <START>
		local pos = vim.fn.searchpos("\\C<START>")
		if not (pos[1] == 0 and pos[2] == 0) then
			vim.cmd.normal('"_cf> ')
		end
	end
end

local grp = augroup("new_file_templates")
-- try_load_template needs bo.filetype, but BufNewFile happens before that
-- variable gets set. To work around this, set a 'b:is_new_file' variable in
-- BufNewFile, and call try_load_template at FileType.
autocmd(
	"BufNewFile", {
		pattern = "*",
		group = grp,
		callback = function() vim.b.is_new_file = true end,
	}
)
autocmd(
	"FileType", {
		pattern = "*",
		group = grp,
		callback = try_load_template,
	}
)
