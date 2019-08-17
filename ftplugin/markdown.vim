autocmd BufNewFile,BufFilePre,BufRead *.md 
 \ set filetype plugin off
 \ set filetype indent off
 \ set filetype=markdown 
 \ textwidth=0 
 \ wrapmargin=0 
 \ wrap 
 \ linebreak 
 \ nolist 

setlocal comments=fb:-,fb:*
" setlocal autoindent
setlocal colorcolumn=0
setlocal linebreak
setlocal nonumber
setlocal shiftwidth=2
setlocal spell
setlocal tabstop=2
setlocal wrap

" ----------------------------------------------------------------------------
"  markdown configuration
let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding=1 
let g:vim_markdown_folding_style_pythonic=1 
let g:vim_markdown_folding_level=1
let g:vim_markdown_override_foldtext=1
let g:vim_markdown_enable_folding=1 
let g:vim_markdown_conceal=0  " disable concealing markup 




