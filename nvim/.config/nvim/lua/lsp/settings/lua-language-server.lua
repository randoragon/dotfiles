-- https://github.com/LuaLS/lua-language-server/wiki/Settings

return {
	Lua = {
		completion = {
			callSnippet = 'Disable',
			keywordSnippet = 'Disable',
		},

		diagnostics = {
			disable = { 'lowercase-global' },
		},

		workspace = {
			checkThirdParty = true,
			library = { '${3rd}/lfs/library' },
		},
	},
}
