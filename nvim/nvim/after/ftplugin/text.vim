" License: MiT
" Copyright (C) 2026  Ratheesh <ratheeshreddy@gmail.com>
" Author: Ratheesh

" About: local settings for text files

setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4

" Make text inserted in insertmode into smaller undo chunks.
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap , ,<c-g>u

" End of File
