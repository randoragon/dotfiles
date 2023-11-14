-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md

return {
	pylsp = {
		configurationSources = {"flake8"},

		plugins = {
			-- https://flake8.pycqa.org/en/latest/user/configuration.html
			-- flake8 combines pyflakes, mccabe and pycodestyle
			flake8 = {
				enabled = true,
				ignore = {
					"E302", -- 2 blank lines before class/function
					"E305", -- 2 blank lines after class/function
					"E401", -- multiple imports on one line
					"E501", -- line too long (>79 characters)
					"E741", -- ambiguous variable names
					"E203", -- whitespace before ':'
					"E241", -- multiple spaces after ':'
				},
			},

			pyflakes = {
				enabled = false,
			},

			mccabe = {
				enabled = false,
			},

			pycodestyle = {
				enabled = false,
			},
		},
	},
}
