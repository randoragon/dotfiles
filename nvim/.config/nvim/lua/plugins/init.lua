local modpath = (...)

require("paq") {
	"lewis6991/gitsigns.nvim",
	"junegunn/fzf.vim",
	"tpope/vim-surround",
	"tpope/vim-speeddating",
	"tpope/vim-repeat",
	"tpope/vim-abolish",
	"tpope/vim-commentary",
	"glts/vim-radical",
	"glts/vim-magnum",
	"rebelot/kanagawa.nvim",
	"jiangmiao/auto-pairs",
	"godlygeek/tabular",
	"skywind3000/asyncrun.vim",
	"derekwyatt/vim-fswitch",
	"ap/vim-css-color",
	"psliwka/vim-smoothie",
	"lervag/vimtex",
	"ziglang/zig.vim",
	"Vigemus/iron.nvim",
	"famiu/bufdelete.nvim",
	"tiagovla/scope.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		run = function() vim.cmd("TSUpdate") end,
	},
}

require(modpath .. ".autopairs")
require(modpath .. ".fswitch")
require(modpath .. ".fzf")
require(modpath .. ".gitsigns")
require(modpath .. ".iron")
require(modpath .. ".kanagawa")
require(modpath .. ".scope")
require(modpath .. ".smoothie")
require(modpath .. ".tabular")
require(modpath .. ".treesitter")
require(modpath .. ".vimtex")
require(modpath .. ".zig")
