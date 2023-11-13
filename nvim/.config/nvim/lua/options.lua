local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Miscellaneous
wo.wrap = false
wo.number = true
wo.cursorline = true
o.mouse = "a"
o.hidden = true
o.listchars = "tab:  ┊,trail:·,nbsp:·"
wo.list = true
o.timeoutlen = 500
o.history = 1000
bo.spelllang = "en_us"

-- Status bar
-- https://jdhao.github.io/2019/11/03/vim_custom_statusline/
-- https://shapeshed.com/vim-statuslines/
o.statusline =
	"%#MyProjectMode#%{g:project_mode?'·':''}"       -- Project Mode indicator
	.. "%{%luaeval(\"lsp_get_status_str()\")%}"      -- LSP warnings/errors
	.. "%#Visual# %f "                               -- File path
	.. "%#WarningMsg#%h%m%r"                         -- {help, modified, readonly} flags
	.. "%#CursorColumn#%="                           -- Align the rest to the right
	.. "%#Conceal#%y "                               -- File type
	.. "%{&fileencoding?&fileencoding:&encoding} "   -- File encoding
	.. "%#MsgArea#  %v:%l/%L (%p%%) "                -- Position in file
	.. " "

-- Clipboard integration
vim.g.clipboard = {
	name = "xclip",
	copy = {
		["+"] = "xclip -selection clipboard",
		["*"] = "xclip -selection clipboard"
	},
	paste = {
		["+"] = "xclip -selection clipboard -o",
		["*"] = "xclip -o"
	},
	cache_enabled = true
}
