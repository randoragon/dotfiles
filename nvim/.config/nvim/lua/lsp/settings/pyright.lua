-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
-- This should be the correct way to specify options to pyright,
-- but I found that it doesn't work for some reason. Luckily,
-- the defaults are just fine.
return {
	python = {
		analysis = {
			typeCheckingMode = "strict",
			autoSearchPaths = true,
			useLibraryCodeForTypes = true,
			diagnosticMode = "openFilesOnly",
		},
	},
}
