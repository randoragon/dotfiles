-- https://github.com/windwp/nvim-autopairs
local autopairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.setup({
	disable_filetype = {"TelescopePrompt", "spectre_panel"},
	disable_in_macro = true,
	disable_in_visualblock = false,
	disable_in_replace_mode = true,
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_moveright = true,
	enable_afterquote = true,
	enable_check_bracket_line = false,
	enable_bracket_in_quote = true,
	enable_abbr = false,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%>%]%)%}%,]]=],
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment"
	},
	break_undo = true,
	check_ts = true,
	map_cr = false,  -- See mappings.lua
	map_bs = false,  -- See mappings.lua
	map_c_h = false,
	map_c_w = false,
})

-- Fix nvim-autopairs and nvim_coq conflicting mappings
-- NOTE: for some reason, using vim.keymap.set() does not work for these.
function autopairs_coq_cr()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({"selected"}).selected ~= -1 then
			-- Completion menu is open and something is selected
			return autopairs.esc("<C-y>")
		else
			-- Completion menu is open, but nothing is selected
			return autopairs.esc("<C-e>") .. autopairs.autopairs_cr()
		end
	else
		return autopairs.autopairs_cr()
	end
end
function autopairs_coq_bs()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({"selected"}).selected ~= -1 then
		-- Completion menu is open and something is selected
		return autopairs.esc("<C-y>") .. autopairs.autopairs_bs()
	else
		return autopairs.autopairs_bs()
	end
end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.autopairs_coq_cr()", {expr=true, noremap=true})
vim.api.nvim_set_keymap("i", "<BS>", "v:lua.autopairs_coq_bs()", {expr=true, noremap=true})
