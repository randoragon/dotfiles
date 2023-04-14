-- https://github.com/kdheepak/tabline.nvim
kanagawa = require('kanagawa')

kanagawa.setup {
	compile = true,              -- enable compiling the colorscheme
	undercurl = false,           -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = true,          -- do not set background color
	dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
	terminalColors = true,       -- define vim.g.terminal_color_{0,17}

	-- add/modify theme and palette colors
	colors = {
		palette = {},
		theme = {
			wave = {},
			lotus = {},
			dragon = {},
			all = {}
		},
	},

	-- add/modify highlights
	overrides = function(colors)
		return {}
	end,
	theme = "wave",              -- Load "wave" theme when 'background' option is not set

	-- map the value of 'background' option to a theme
	background = {
		dark = "wave",
		light = "lotus"
	},
}
