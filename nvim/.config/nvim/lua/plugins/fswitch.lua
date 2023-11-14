local grp = augroup("fswitch")

local function add_extension_mapping(pattern, extensions)
	autocmd(
		"BufEnter", {
			pattern = pattern,
			group = grp,
			callback = function()
				vim.b.fswitchdst = extensions
				vim.b.fswitchlocs = "."
			end
		}
	)
end

add_extension_mapping("*.cpp", "hpp,h")
add_extension_mapping("*.c", "h")

map("n", "<C-s>", ":FSHere<CR>")
