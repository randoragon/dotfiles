local M = {}

-- Each buffer remembers its lsp client ID and its lsp configuration.
-- To support 'project mode' where lsp is automatically started for each new
-- buffer, the most recent lsp configuration is stored in a global variable as
-- well.
vim.b.active_lsp_client = nil
vim.b.active_lsp_config = nil
vim.g.active_lsp_config = nil

-- Toggle a LSP for the current buffer.
-- If query_list is not passed, root directory will be set to null.
function M.toggle(config, query_list)
	if vim.b.active_lsp_client == nil then
		if not config.root_dir and query_list then
			local found = vim.fs.find(query_list, {
				upward=true,
				stop=os.getenv('HOME'),
			})[1]
			if found then
				found = vim.fs.dirname(found)
			else
				found = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
			end
			local root = vim.api.nvim_exec(string.format('echo input("lsp root: ", "%s", "dir")', found:gsub('^'..os.getenv('HOME'), '~')), true)
			vim.cmd.echo()
			if #root == 0 then
				return
			end
			config.root_dir = vim.fs.normalize(root)
		end

		vim.b.active_lsp_config = config
		vim.g.active_lsp_config = vim.b.active_lsp_config
		vim.b.active_lsp_client = vim.lsp.start(vim.b.active_lsp_config)
	else
		vim.lsp.stop_client(vim.b.active_lsp_client)
		vim.b.active_lsp_client = nil
		vim.b.active_lsp_config = nil
	end
end

function M.status()
	if vim.b.active_lsp_client == nil then
		return ''
	end
	local warnings = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.WARN})
	local errors   = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.ERROR})
	return '%#MyStatusBarWarn# '..warnings..' %#MyStatusBarError# '..errors..' '
end

return M