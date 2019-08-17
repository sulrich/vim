" python mode configuration
" shiftround - round the indent to a multiple of shiftwidth
autocmd BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=6
    \ shiftwidth=4
    \ shiftround                         
    \ textwidth=79
    \ fileformat=unix

" remove trailing whitespace for python files.
" autocmd BufWritePre *.py :%s/\s\+$//e 
autocmd BufWritePre *.py execute ':Black'

" check python files with flake8
let b:ale_linters = ['flake8', 'pylint']

" fix python files with black
let b:ale_fixers = ['black']

" i'm doing everything in python3 these days.
let g:pymode_python = 'python3'

