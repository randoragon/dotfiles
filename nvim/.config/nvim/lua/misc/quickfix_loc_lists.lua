-- Cycle through QuickFix/Location lists
-- https://vi.stackexchange.com/a/8535
local function add_list_cycle_command(name, cmd, alt_pattern, alt_cmd, msg)
	vim.api.nvim_create_user_command(
		name,
		function()
			local ok, result = pcall(vim.cmd, cmd)
			if not ok and result:find(alt_pattern) then
				if not pcall(vim.cmd, alt_cmd) then
					vim.cmd.echo('"'..msg..'"')
				end
			end
		end,
		{}
	)
end
add_list_cycle_command("Cnext", "cnext", "No Errors", "cfirst", "No quickfix list")
add_list_cycle_command("Cprev", "cprev", "No Errors", "clast", "No quickfix list")
add_list_cycle_command("Lnext", "lnext", "No location list", "lfirst", "No location list")
add_list_cycle_command("Lprev", "lprev", "No location list", "llast", "No location list")


-- Toggle QuickFix/Location lists
-- https://rafaelleru.github.io/blog/quickfix-autocomands/
vim.g.clist_isopen = false
vim.g.llist_isopen = false
local grp = augroup("qffixstates")

local function add_quickfix_autocmd(events, val)
	autocmd(events, {
		pattern = "quickfix",
		group = grp,
		callback = function()
			if vim.fn.getwininfo(vim.fn.win_getid())[1]["loclist"] == 1 then
				vim.g.llist_isopen = val
			else
				vim.g.clist_isopen = val
			end
		end
	})
end
add_quickfix_autocmd({"BufWinEnter"}, true)
add_quickfix_autocmd({"BufWinLeave"}, false)

local function add_list_toggle_command(name, list_name, toggle_var, cmd_open, cmd_close)
	vim.api.nvim_create_user_command(
		name,
		function()
			if vim.g[toggle_var] then
				if pcall(vim.cmd, cmd_close) then
					vim.g[toggle_var] = false
				else
					vim.cmd.echo("'Failed to close "..list_name.." list'")
				end
			else
				if pcall(vim.cmd, cmd_open) then
					vim.g[toggle_var] = true
				else
					vim.cmd.echo("'No "..list_name.." list'")
				end
			end
		end,
		{}
	)
end
add_list_toggle_command("ToggleCList", "quickfix", "clist_isopen", "copen", "cclose")
add_list_toggle_command("ToggleLList", "location", "llist_isopen", "lopen", "lclose")

map("n", "<Leader>q", vim.cmd.ToggleCList, {silent=true})
map("n", "<Leader>d", vim.cmd.ToggleLList, {silent=true})
map("n", "[q", vim.cmd.Cprev, {silent=true})
map("n", "]q", vim.cmd.Cnext, {silent=true})
map("n", "[d", vim.cmd.Lprev, {silent=true})
map("n", "]d", vim.cmd.Lnext, {silent=true})
