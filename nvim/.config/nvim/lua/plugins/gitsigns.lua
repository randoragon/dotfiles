gitsigns = require("gitsigns")

gitsigns.setup()

map("n", "]g", gitsigns.next_hunk)
map("n", "[g", gitsigns.prev_hunk)
map("n", "<Leader>gp", gitsigns.preview_hunk)
map("n", "<Leader>gr", gitsigns.reset_hunk)
map("n", "<Leader>gl", gitsigns.toggle_signs)
map("n", "<Leader>gb", function() gitsigns.blame_line({full=true}) end)
map("n", "<Leader>gq", gitsigns.setqflist)
map("n", "<Leader>gs", gitsigns.select_hunk)
