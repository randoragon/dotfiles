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
o.foldlevelstart = 99

-- Searching
o.ignorecase = true
o.smartcase = true

-- Wildmenu
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildignorecase = true
o.wildignore = "*.git/*,*.tags,*.o" 

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Backup directories
o.backup = true
o.writebackup = true
o.backupdir = os.getenv("HOME") .. "/.local/share/nvim/backup/"

-- Status bar
-- https://jdhao.github.io/2019/11/03/vim_custom_statusline/
-- https://shapeshed.com/vim-statuslines/
o.statusline =
	"%#MyRunningInLf#%{%luaeval(\"os.getenv('LF_LEVEL')\")?'[LF]':''%}"  -- Running inside lf indicator
	.. "%#MyProjectMode#%{g:project_mode?'·':''}"    -- Project Mode indicator
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
	name = "wl-copy",
	copy = {
		["+"] = "wl-copy",
		["*"] = "wl-copy"
	},
	paste = {
		["+"] = "wl-paste",
		["*"] = "wl-paste"
	},
	cache_enabled = true
}
