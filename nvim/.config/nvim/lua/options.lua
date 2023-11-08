local o = vim.o
local wo = vim.wo
local bo = vim.bo

wo.wrap = false
wo.number = true
wo.cursorline = true
o.mouse = "a"
o.hidden = true
o.listchars = "tab:  ┊,trail:·,nbsp:·"
wo.list = true
o.timeoutlen = 500
o.history = 1000
