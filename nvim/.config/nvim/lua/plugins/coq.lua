-- https://github.com/ms-jpq/coq_nvim/blob/coq/docs/CONF.md
vim.g.coq_settings = {
	auto_start = true,
	xdg = true,
	["display.statusline.helo"] = false,

	clients = {
		snippets = {
			enabled = false,
			warn = {},
			user_path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/plugins/coq-user-snippets/",
		},
	},

	keymap = {
		manual_complete_insertion_only = true,
	},
}
