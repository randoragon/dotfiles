-- https://github.com/LuaLS/lua-language-server/wiki/Settings

return {
	Lua = {
		completion = {
			callSnippet = "Disable",
			keywordSnippet = "Disable",
		},

		diagnostics = {
			disable = {
				"lowercase-global",
				"redefined-local",
			},
		},

		workspace = {
			checkThirdParty = false,
			library = {
				"~/.config/lua/init.lua",
				"~/Software/LLS-Addons/addons/luafilesystem/module/library",
				"~/Software/LLS-Addons/addons/lpeg/module/library",
				"~/Software/LLS-Addons/addons/penlight//module/library",
			},
		},
	},
}
