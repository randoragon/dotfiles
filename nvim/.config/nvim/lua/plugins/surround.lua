-- https://github.com/kylechui/nvim-surround/wiki/Configuration
surround = require("nvim-surround")
local config = require("nvim-surround.config")

surround.setup({
	aliases = {
		["a"] = false,
		["b"] = false,
		["B"] = false,
		["r"] = false,
		["q"] = { '"', "'", "`" },
		["s"] = false,
	},
})

local grp = augroup("custom_surrounds")

local function add_buffer_config_for_filetype(ft, config)
	autocmd(
		"FileType", {
			pattern = ft,
			group = grp,
			callback = function()
				surround.buffer_setup(config)
			end,
		}
	)
end

add_buffer_config_for_filetype("markdown", {
	surrounds = {
		["b"] = {
			add = {{"**"}, {"**"}},
			find = "%*%*.-%*%*",
			delete = "(%*%*)().-(%*%*)()",
		},
		["i"] = {
			add = {{"*"}, {"*"}},
			find = "%*.-%*",
			delete = "(%*)().-(%*)()",
		},
		["u"] = {
			add = {{"<u>"}, {"</u>"}},
			find = "<u>.-</u>",
			delete = "(<u>)().-(</u>)()",
		},
	}
})

add_buffer_config_for_filetype("tex", {
	surrounds = {
		["i"] = {
			add = {{"\\emph{"}, {"}"}},
			find = "\\emph{.-}",
			delete = "(\\emph{)().-(})()",
		},
		["b"] = {
			add = {{"\\textbf{"}, {"}"}},
			find = "\\textbf{.-}",
			delete = "(\\textbf{)().-(})()",
		},
		["u"] = {
			add = {{"\\ul{"}, {"}"}},
			find = "\\ul{.-}",
			delete = "(\\ul{)().-(})()",
		},
		["v"] = {
			add = {{"\\texttt{"}, {"}"}},
			find = "\\texttt{.-}",
			delete = "(\\texttt{)().-(})()",
		},
		["V"] = {
			add = {{"\\verb`"}, {"`"}},
			find = "\\verb`.-`",
			delete = "(\\verb`)().-(`)()",
		},
		["x"] = {
			add = {{"\\text{"}, {"}"}},
			find = "\\text{.-}",
			delete = "(\\text{)().-(})()",
		},
		["c"] = {
			add = function()
				local cmd = config.get_input("Command: ")
				return cmd and {{"\\" .. cmd .. "{"}, {"}"}} or nil
			end,
			-- Change and delete provided by VimTex
		},
		["\\"] = {
			add = function()
				local env = config.get_input("Environment: ")
				return env and {{"\\begin{" .. env .. "}"}, {"\\end{" .. env .. "}"}} or nil
			end,
			-- Change and delete provided by VimTex
		},
	}
})

add_buffer_config_for_filetype("typst", {
	surrounds = {
		["u"] = {
			add = {{"#underline["}, {"]"}},
			find = "#underline%[.-%]",
			delete = "(#underline%[)().-(%])()",
		},
		["s"] = {
			add = {{"#strike["}, {"]"}},
			find = "#strike%[.-%]",
			delete = "(#strike%[)().-(%])()",
		},
		["o"] = {
			add = {{"#overline["}, {"]"}},
			find = "#overline%[.-%]",
			delete = "(#overline%[)().-(%])()",
		},
		["h"] = {
			add = {{"#highlight["}, {"]"}},
			find = "#highlight%[.-%]",
			delete = "(#highlight%[)().-(%])()",
		},
		["c"] = {
			add = {{"#smallcaps["}, {"]"}},
			find = "#smallcaps%[.-%]",
			delete = "(#smallcaps%[)().-(%])()",
		},
		["p"] = {
			add = {{"#super["}, {"]"}},
			find = "#super%[.-%]",
			delete = "(#super%[)().-(%])()",
		},
		["b"] = {
			add = {{"#sub["}, {"]"}},
			find = "#sub%[.-%]",
			delete = "(#sub%[)().-(%])()",
		},
	},
})
