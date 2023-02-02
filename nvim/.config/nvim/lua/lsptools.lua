local M = {}

vim.b.active_lsp_client = nil
vim.b.active_lsp_root = nil

-- Toggle a LSP for the current buffer.
-- If query_list is not passed, root directory will be set to the current
-- buffer's directory.
function M.toggle(name, cmd, query_list)
	if vim.b.active_lsp_client == nil then
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
			vim.b.active_lsp_root = vim.fs.normalize(root)
		else
			vim.b.active_lsp_root = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
		end

		vim.b.active_lsp_client = vim.lsp.start({
			name = name,
			cmd = cmd,
			root_dir = vim.b.active_lsp_root,
		})
		-- vim.cmd.echo(string.format('"lsp server started (%d)"', vim.b.active_lsp_client))
	else
		vim.lsp.stop_client(vim.b.active_lsp_client)
		-- vim.cmd.echo(string.format('"lsp server stopped (%d)"', vim.b.active_lsp_client))
		vim.b.active_lsp_client = nil
		vim.b.active_lsp_root = nil
	end
end

function M.status()
	if vim.b.active_lsp_client == nil then
		return ''
	end
	local warnings = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.WARN})
	local errors   = #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.ERROR})
	return '%#DiffChange# '..warnings..' %#ErrorMsg# '..errors..' '
end

return M
