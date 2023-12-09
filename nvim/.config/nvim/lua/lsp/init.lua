local modpath = (...)

-- Each buffer remembers its lsp client ID and its lsp configuration.
-- To support 'project mode' where lsp is automatically started for each new
-- buffer, the most recent lsp configuration is stored in a global variable as
-- well.
vim.b.active_lsp_client = nil
vim.b.active_lsp_config = nil
vim.g.active_lsp_config = nil
vim.g.project_mode = false

function lsp_toggle_project_mode()
	vim.g.project_mode = not vim.g.project_mode
	vim.cmd.redrawstatus()
end

-- Toggle a LSP for the current buffer.
-- If query_list is not passed, root directory will be set to null.
function lsp_toggle(config, query_list)
	if vim.b.active_lsp_client == nil then
		if not config.root_dir and query_list then
			local found = vim.fs.find(query_list, {
				upward=true,
				stop=os.getenv("HOME"),
			})[1]
			if found then
				found = vim.fs.dirname(found)
			else
				found = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
			end
			found = found:gsub("^" .. os.getenv("HOME"), "~")
			local root = vim.api.nvim_exec(("echo input('lsp root: ', '%s', 'dir')"):format(found), true)
			vim.cmd.echo()
			if #root == 0 then
				return
			end
			config.root_dir = vim.fs.normalize(root)
		end

		-- Disable semantic highlighting by default (I'm not a fan)
		local on_attach = config.on_attach or function(_, _) end
		config.on_attach = function(client, bufnr)
			client.server_capabilities.semanticTokensProvider = nil
			on_attach(client, bufnr)
		end

		vim.b.active_lsp_config = config
		vim.g.active_lsp_config = vim.b.active_lsp_config
		vim.b.active_lsp_client = vim.lsp.start(vim.b.active_lsp_config)
	else
		vim.lsp.stop_client(vim.b.active_lsp_client)
		vim.b.active_lsp_client = nil
		vim.b.active_lsp_config = nil
	end
	vim.cmd.redrawstatus()
end

function lsp_get_status_str()
	if vim.b.active_lsp_client == nil then
		return ""
	end
	local warnings = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.WARN})
	local errors   = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.ERROR})
	return "%#MyStatusBarWarn# " .. warnings .. " %#MyStatusBarError# " .. errors .. " "
end

-- Add borders to floating windows
-- https://vi.stackexchange.com/a/39075
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border="rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border="rounded"})
vim.diagnostic.config({float={border="rounded"}})

require(modpath .. ".autocommands")

map("n", "<Leader>.L", lsp_toggle_project_mode)
map("n", "<Space>", "<Nop>")
