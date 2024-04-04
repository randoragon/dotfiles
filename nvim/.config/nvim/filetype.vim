if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.h     setfiletype c
  au! BufNewFile,BufRead *.mm    setfiletype neat-mm | set syntax=groff
  au! BufNewFile,BufRead *.ms    setfiletype neat-ms | set syntax=groff
  au! BufNewFile,BufRead *.mom   setfiletype groff-mom | set syntax=groff
  au! BufNewFile,BufRead *.rnd   setfiletype neat-rnd | set syntax=groff
  au! BufNewFile,BufRead *.groff setfiletype groff | set syntax=groff
  au! BufNewFile,BufRead *.MD    setfiletype markdown
  au! BufNewFile,BufRead *.sent  setfiletype sent | set syntax=conf
  au! BufNewFile,BufRead *.msc   setfiletype mscgen | set syntax=dot
  au! BufNewFile,BufRead *.tex   setfiletype tex
  au! BufNewFile,BufRead *.typ   setfiletype typst
augroup END
