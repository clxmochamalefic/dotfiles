" define tabstop by filetype
augroup FileTypeIndent
  autocmd!

  autocmd BufNewFile,BufRead *.html       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.phtml      setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.js         setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.jsx        setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.ts         setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tsx        setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.css        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.sass       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.scss       setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.prisma     setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.vim        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yaml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.toml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.lua        setlocal tabstop=2 softtabstop=2 shiftwidth=2

  "autocmd BufNewFile,BufRead *.blade.php  setlocal syntax=html
  "autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html
  "autocmd BufNewFile,BufRead *.blade.php  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  "autocmd BufNewFile,BufRead *.blade      setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=blade
  autocmd FileType blade                  setlocal tabstop=2 softtabstop=2 shiftwidth=2

augroup END

