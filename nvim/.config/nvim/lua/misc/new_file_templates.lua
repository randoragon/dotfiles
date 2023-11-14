-- Automatic templates for new files of certain types

-- Substitutions to do on the template files
local substitutions = {
	["<DATE>"] = function () return vim.fn.strftime("%A, %B %e, %Y") end,
}

local function try_load_template()
	local fpath = os.getenv("HOME") .. "/.config/nvim/templates/" .. vim.bo.filetype
	vim.cmd.echo(('"%s"'):format(fpath))
	if vim.fn.filereadable(fpath) then
		lines = {}
		for line in io.lines(fpath) do
			for pattern, action in pairs(substitutions) do
				local new_line
				if type(action) == "string" then
					new_line = action
				elseif type(action) == "function" then
					new_line = action()
				end
				assert(type(new_line) == "string")
				lines[#lines + 1] = line:gsub(pattern, new_line)
			end
		end
		vim.fn.setline(1, lines:concat("\n"))

		-- Place cursor in the spot indicated by <START>
		vim.fn.searchpos("\\C<START>")
		vim.cmd.normal('"_df')
	end
end

local augroup = vim.api.nvim_create_augroup("new_file_templates", { clear=true })
vim.api.nvim_create_autocmd(
	"BufNewFile", {
		pattern = "*",
		group = augroup,
		callback = try_load_template,
	}
)
