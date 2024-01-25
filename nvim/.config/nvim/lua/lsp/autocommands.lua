local grp = augroup("lsp")

autocmd(
	"LspAttach", {
		pattern = "*",
		group = grp,
		callback = function()
			vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
			vim.diagnostic.config({virtual_text=false})
			map("n", "<Leader><C-l>", vim.diagnostic.reset, {buffer=true})
			map("n", "<Leader>e", vim.diagnostic.open_float, {buffer=true})
			map("n", "<Leader>[e", vim.diagnostic.goto_prev, {buffer=true})
			map("n", "<Leader>]e", vim.diagnostic.goto_next, {buffer=true})
			map("n", "<Leader>D", vim.diagnostic.setloclist, {buffer=true})
			map("n", "gd", vim.lsp.buf.definition, {buffer=true})
			map("n", "gD", vim.lsp.buf.declaration, {buffer=true})
			map("n", "<Space>", vim.lsp.buf.hover, {buffer=true})
			map("n", "<Leader><Space>", vim.lsp.buf.signature_help, {buffer=true})
			map("n", "<Leader>.<Space>", vim.lsp.buf.code_action, {buffer=true})
			map("n", "<Leader>r", vim.lsp.buf.references, {buffer=true})
			map("n", "<Leader>R", vim.lsp.buf.rename, {buffer=true})
		end,
	}
)

autocmd(
	"BufEnter", {
		pattern = "*",
		group = grp,
		callback = function()
			if vim.g.project_mode and vim.g.active_lsp_config then
				vim.b.active_lsp_client = vim.lsp.start(vim.g.active_lsp_config)
			end
		end,
	}
)

autocmd(
	"DiagnosticChanged", {
		pattern = "*",
		group = grp,
		callback = function()
			vim.diagnostic.setloclist({open=false})
		end,
	}
)

autocmd(
	"ColorScheme", {
		pattern = "*",
		group = grp,
		callback = function()
			vim.cmd.highlight({
				"MyRunningInLf",
				"ctermfg=7", "ctermbg=6", "cterm=bold",
				"guifg=#00C0F0", "guibg=#205050", "gui=bold",
			})
			vim.cmd.highlight({
				"MyProjectMode",
				"ctermfg=7", "ctermbg=6", "cterm=bold",
				"guifg=White", "guibg=DarkCyan", "gui=bold",
			})
			vim.cmd.highlight({
				"MyStatusBarWarn",
				"ctermfg=3", "ctermbg=3", "cterm=bold",
				"guifg=Orange", "guibg=#4b2800", "gui=bold",
			})
			vim.cmd.highlight({
				"MyStatusBarError",
				"ctermfg=1", "ctermbg=1", "cterm=bold",
				"guifg=Red", "guibg=#4b0000", "gui=bold",
			})
		end,
	}
)
