-- https://github.com/Vigemus/iron.nvim
iron = require("iron.core")
local view = require("iron.view")

iron.setup {
	config = {
		-- Whether a repl should be discarded or not
		scratch_repl = true,

		repl_definition = {
			sh = {
				command = {"sh"}
			},
			python = {
				command = {"python"}
			}
		},

		repl_open_cmd = view.offset({
			width = "40%",
			height = vim.o.lines - 2,
			w_offset = "60%",
			h_offset = 0,
		}),
	},

	keymaps = {
		send_motion = "<Leader>is",
		visual_send = "<M-9>",
		send_file = "<Leader>if",
		send_line = "<Nop>",
		send_mark = "<Nop>",
		mark_motion = "<Nop>",
		mark_visual = "<Nop>",
		remove_mark = "<Leader>id",
		cr = "<Nop>",
		interrupt = "<Leader>ii",
		exit = "<Leader>iq",
		clear = "<Leader>i<C-l>",
	},

	-- For the available options, check nvim_set_hl
	highlight = {
		italic = true,
	},

	-- ignore blank lines when sending visual select lines
	ignore_blank_lines = true,
}

map("n", "<Leader>i<Space>", function()
	iron.repl_for(bo.filetype)
end)
map("n", "<Leader>ir", iron.repl_restart)
map("n", "<Leader>ie", function()
	iron.focus_on(bo.filetype)
	vim.cmd.startinsert()
end)
map("n", "<M-(>", ":lua iron.run_motion('send_motion')<CR>ip", {silent=true})
map("n", "<M-)>", ":lua iron.run_motion('send_motion')<CR>ip}+", {silent=true})
map("n", "<M-9>", iron.send_line)
map("n", "<M-0>", function()
	iron.send_line()
	vim.cmd.normal("+")
end)
