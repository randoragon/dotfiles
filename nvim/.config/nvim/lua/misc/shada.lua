-- Read and write ShaDa automatically to share state between instances

-- Store less information, to lower the overhead of common reads and writes
o.shada="!,'0,/100,<100,s10"

-- We can greatly reduce the number of rshada invocations by caching
-- and comparing timestamps
local SHADA_FPATH = vim.o.shadafile
if SHADA_FPATH == "" then
	SHADA_FPATH = os.getenv("XDG_STATE_HOME") .. "/nvim/shada/main.shada"
end

function get_shada_mtime()
	local f = io.popen("stat -c %Y -- '" .. SHADA_FPATH .. "'")
	return tonumber(f:read())
end


local last_rtime = 0
local grp = augroup("shada")

autocmd(
	{"FocusGained", "VimResume"}, {
		pattern = "*",
		group = grp,
		callback = function()
			local shada_mtime = get_shada_mtime()
			if last_rtime < shada_mtime then
				local ok, _ = pcall(vim.cmd.rshada)
				if ok then
					last_rtime = shada_mtime
				end
			end
		end,
	}
)

autocmd(
	{"TextYankPost"}, {
		pattern = "*",
		group = grp,
		callback = function()
			local ok, _ = pcall(vim.cmd.wshada)
			if ok then
				last_rtime = get_shada_mtime()
			end
		end,
	}
)
