" License: MiT
" Copyright (C) 2017  Ratheesh <ratheeshreddy@gmail.com>
" Author: Ratheesh S
"
" About: local settings for shell ft

set shiftwidth=4
set softtabstop=4
set expandtab

autocmd BufNewFile,BufRead .bashrc*,bashrc,bash.bashrc,.bash_aliases,.bash_profile*,.bash_logout*,*.bash,*.ebuild set filetype=sh
autocmd BufNewFile,BufRead .zshrc,zshrc,.zprofile,zprofile,.zshenv,zshenv,.zimrc,zimrc,.zlogin,zlogin,.zlogout,zlogout set filetype=sh

" End of File
