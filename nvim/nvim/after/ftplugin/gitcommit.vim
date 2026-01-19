" License: MiT
" Copyright (C) 2026  Ratheesh <ratheeshreddy@gmail.com>
" Author: Ratheesh
"

" About: local settings for gitcommit ft

setlocal expandtab      " Expand tabs in git commit mode
setlocal scrolloff=0
setlocal spell

call setpos('.', [0, 1, 1, 0]) " set cursor position to starting on gitcommit buffers
execute "set colorcolumn=" . join(range(73,335), ',')

autocmd BufNewFile,BufRead .stgit* set filetype=gitcommit

" End of File
