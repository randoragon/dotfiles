-- https://github.com/nvim-treesitter/nvim-treesitter
treesitter = require("nvim-treesitter.configs")

treesitter.setup {
	ensure_installed = {
		"awk",
		"bash",
		"c", "cpp", "c_sharp",
		"diff",
		"dockerfile",
		"dot",
		"gitcommit", "git_config", "gitignore", "git_rebase", "gitattributes",
		"go", "gosum", "gowork",
		"html", "css", "javascript", "typescript", "jsdoc",
		"json", "yaml",
		"latex", "bibtex",
		"ledger",
		"lua", "luadoc", "luap",
		"markdown", "markdown_inline", "rst",
		"nix",
		"passwd",
		"python",
		"regex",
		"ruby",
		"rust",
		"sql",
		"typst",
		"vim", "vimdoc",
		"zig",
	},

	sync_install = false,
	auto_install = false,
	ignore_install = {},

	highlight = {
		enable = true,

		-- Disable highlighting for files over 100KiB
		disable = function(lang, buf)
			local max_filesize = 100 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}
