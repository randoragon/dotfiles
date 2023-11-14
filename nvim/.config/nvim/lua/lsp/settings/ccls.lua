-- https://github.com/MaskRay/ccls/wiki/Customization#initialization-options

return {
	cache = {
		directory = '/tmp/ccls-cache',
	},

	clang = {
		extraArgs = {'-std=c99', '-Wall', '-Wextra', '-pedantic'},
	},

	completion = {
		filterAndSort = false,
	},
}
