local modpath = (...)

require("paq") {
	"lewis6991/gitsigns.nvim",
	"junegunn/fzf.vim",
	"kylechui/nvim-surround",
	"tpope/vim-speeddating",
	"tpope/vim-repeat",
	"tpope/vim-abolish",
	"tpope/vim-commentary",
	"glts/vim-radical",
	"glts/vim-magnum",
	"kepano/flexoki-neovim",
	"windwp/nvim-autopairs",
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
		build = function() vim.cmd("TSUpdate") end,
	},
	"ms-jpq/coq_nvim",
}

require(modpath .. ".autopairs")
require(modpath .. ".coq")
require(modpath .. ".fswitch")
require(modpath .. ".fzf")
require(modpath .. ".gitsigns")
require(modpath .. ".iron")
require(modpath .. ".scope")
require(modpath .. ".smoothie")
require(modpath .. ".surround")
require(modpath .. ".tabular")
require(modpath .. ".treesitter")
require(modpath .. ".vimtex")
require(modpath .. ".zig")
