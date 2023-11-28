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
		recommended = false,
		manual_complete_insertion_only = true,
	},
}

-- Default keymaps, except CR and BS (needs special handling due to autopairs)
local function ifelsepumvisible(iftrue, iffalse)
	return function()
		if vim.fn.pumvisible() ~= 0 then
			return vim.api.nvim_replace_termcodes(iftrue, true, false, true)
		end
		return vim.api.nvim_replace_termcodes(iffalse, true, false, true)
	end
end
map("i", "<Esc>", ifelsepumvisible("<C-e><Esc>", "<Esc>"), {expr=true})
map("i", "<C-c>", ifelsepumvisible("<C-e><C-c>", "<C-c>"), {expr=true})
map("i", "<Tab>", ifelsepumvisible("<C-n>", "<Tab>"), {expr=true})
map("i", "<S-Tab>", ifelsepumvisible("<C-p>", "<BS>"), {expr=true})
