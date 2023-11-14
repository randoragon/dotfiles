-- I use this plugin mostly for its motions and surround.vim-like support,
-- so the majority of everything else can go.
vim.g.vimtex_compiler_enabled = 0
vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_format_enables = 1
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_blgparser = {disable = 1}
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_view_enabled = 0
vim.g.vimtex_toc_config = {layers = {"content", "todo"}}
vim.g.vimtex_indent_on_ampersands = 0

local grp = augroup("latex_surround_cmds")

local function add_surround_cmd(keycode, str)
	autocmd(
		"FileType", {
			pattern = "tex",
			group = grp,
			callback = function()
				vim.b["surround_" .. keycode] = str
			end
		}
	)
end

add_surround_cmd(105, "\\emph{\r}")
add_surround_cmd(98, "\\textbf{\r}")
add_surround_cmd(117, "\\underline{\r}")
add_surround_cmd(99, "\\mintinline{\1syntax: \1}{\r}")
add_surround_cmd(118, "\\texttt{\r}")
add_surround_cmd(120, "\\text{\r}")
add_surround_cmd(88, "\\\1command: \1{\r}")
