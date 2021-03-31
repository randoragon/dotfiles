if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.h     setfiletype c
  au! BufNewFile,BufRead *.ms    setfiletype groff-ms | set syntax=groff
  au! BufNewFile,BufRead *.mom   setfiletype groff-mom | set syntax=groff
  au! BufNewFile,BufRead *.groff setfiletype groff | set syntax=groff
  au! BufNewFile,BufRead *.MD    setfiletype markdown
augroup END
