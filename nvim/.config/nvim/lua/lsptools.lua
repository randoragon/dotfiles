local M = {}

-- Each buffer remembers its lsp client ID and its lsp configuration.
-- To support 'project mode' where lsp is automatically started for each new
-- buffer, the most recent lsp configuration is stored in a global variable as
-- well.
vim.b.active_lsp_client = nil
vim.b.active_lsp_config = nil
vim.g.active_lsp_config = nil

-- Toggle a LSP for the current buffer.
-- If query_list is not passed, root directory will be set to the current
-- buffer's directory.
function M.toggle(name, cmd, query_list)
	if vim.b.active_lsp_client == nil then
		local lsp_root
		if query_list ~= nil then
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
			lsp_root = vim.fs.normalize(root)
		else
			lsp_root = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
		end

		vim.b.active_lsp_config = {
			name = name,
			cmd = cmd,
			root_dir = lsp_root,
		}
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
