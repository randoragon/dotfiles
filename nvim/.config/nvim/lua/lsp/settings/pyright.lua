-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
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
