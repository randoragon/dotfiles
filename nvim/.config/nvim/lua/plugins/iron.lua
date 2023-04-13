local iron = require('iron.core')
local view = require('iron.view')

iron.setup {
   config = {
      -- Whether a repl should be discarded or not
      scratch_repl = true,

      repl_definition = {
         sh = {
            command = { 'sh' }
         },
      },

      repl_open_cmd = view.offset({
         width = '40%',
         height = vim.o.lines - 2,
         w_offset = '60%',
         h_offset = 0,
      }),
   },

   keymaps = {
      send_motion = '<Leader>is',
      visual_send = '<M-[>',
      send_file = '<Leader>if',
      send_line = '<Nop>',
      send_mark = '<Nop>',
      mark_motion = '<Nop>',
      mark_visual = '<Nop>',
      remove_mark = '<Leader>id',
      cr = '<Nop>',
      interrupt = '<Leader>ii',
      exit = '<Leader>iq',
      clear = '<Leader>i<C-l>',
   },

   -- For the available options, check nvim_set_hl
   highlight = {
      italic = true,
   },

   -- ignore blank lines when sending visual select lines
   ignore_blank_lines = true,
}
