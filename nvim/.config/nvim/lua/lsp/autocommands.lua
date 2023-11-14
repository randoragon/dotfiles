local map = vim.keymap.set

local augroup = vim.api.nvim_create_augroup("lsp", {clear=true})

vim.api.nvim_create_autocmd(
	"LspAttach", {
		pattern = "*",
		group = augroup,
		callback = function()
			vim.bo.omnifunc = vim.lsp.omnifunc
			vim.diagnostic.config({virtual_text=false})
			map("n", "<Leader><C-l>"  , vim.diagnostic.reset      , {silent=true})
			map("n", "<Leader>e"      , vim.diagnostic.open_float , {silent=true})
			map("n", "<Leader>[e"     , vim.diagnostic.goto_prev  , {silent=true})
			map("n", "<Leader>]e"     , vim.diagnostic.goto_next  , {silent=true})
			map("n", "<Leader>D"      , vim.diagnostic.setloclist , {silent=true})
			map("n", "gd"             , vim.lsp.buf.definition    , {silent=true})
			map("n", "gD"             , vim.lsp.buf.declaration   , {silent=true})
			map("n", "<Space>"        , vim.lsp.buf.hover         , {silent=true})
			map("n", "<Leader><Space>", vim.lsp.buf.signature_help, {silent=true})
			map("n", "<Leader>r"      , vim.lsp.buf.references    , {silent=true})
			map("n", "<Leader>R"      , vim.lsp.buf.rename        , {silent=true})
		end,
	}
)

vim.api.nvim_create_autocmd(
	"BufEnter", {
		pattern = "*",
		group = augroup,
		callback = function()
			if vim.g.project_mode and vim.g.active_lsp_config then
				vim.b.active_lsp_client = vim.lsp.start(vim.g.active_lsp_config)
			end
		end,
	}
)

vim.api.nvim_create_autocmd(
	"DiagnosticChanged", {
		pattern = "*",
		group = augroup,
		callback = function()
			vim.diagnostic.setloclist({open=false})
		end,
	}
)

vim.api.nvim_create_autocmd(
	"ColorScheme", {
		pattern = "*",
		group = augroup,
		callback = function()
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
