" escape alternative - insert-mode
imap kj <Esc>
" set the leader to space. this seems to have better behaviors than ','
nnoremap <SPACE> <Nop>
let mapleader=" "

set encoding=utf-8            " self-explanatory
set textwidth=80              " where to wrap
set shortmess=at              " abbreviate and truncate file messages
set showmatch                 " briefly flash to the matching element

set visualbell             " disable the beep
set autoread               " if a file changes externally, update buffer

" address the tabs-vs-spaces debate ...
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" interface configuration
set cmdheight=2        " command line two lines high
set laststatus=2
set ruler              " show line # info, etc.
set showmode           " show the mode in the status line
set showcmd            " show selection infoj

set colorcolumn=80
" i love the chill vibes of nord, but i like the contrast of solarized better. 
" colorscheme nord
" this following is necessary to make things work in vimr. must be loaded before
" setting colorscheme(s)
set termguicolors      
" setting the following prevents the flashing between light and dark on some
" terminals - i just set it to dark. 
set background=dark
colorscheme solarized8
let g:solarized_italics = 0 " i don't like italics

" the following 2 lines are needed to make solarized happy in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"set comments=b:#,:%,n:>,fb:[-],fb:- " see, help: comments
" folding settings
" set foldmethod=syntax      " fold on syntax, always
set foldcolumn=0           " 2 lines of column for fold showing, always
set foldlevelstart=3       " expand folds at start

set wildmode=longest:full
set wildignore+=*.o,*~,.lo " ignore object files
set wildmenu               " menu has tab completion

" make the copy/paste operation seamless w/the OS
set clipboard=unnamed

" delay before swap is written to the disk (100ms)
set updatetime=100
set ttimeout
set ttimeoutlen=100

" split preferences
set splitbelow
set splitright

" per file type specifications
" this triggers the right defaults in programming lang modes
filetype on
filetype indent on
filetype plugin on

" search settings
" ---------------------------------------------------------------------------
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set smartcase                 " search w/a capital is case-sensitive
set hlsearch                  " highlight the search
" clear search highlights
nnoremap <leader><space> :nohlsearch<cr>

" diff settings
set diffopt=filler,iwhite     " ignore all whitespace and sync

" personal abbreviations
ab x70- ----------------------------------------------------------------------
ab x70= ======================================================================

" misc. additional mappings/functions
" remove all trailing whitespace 
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" send stuff to pb - internal pb destination
command! -range=% Pb :<line1>,<line2>w !curl -F c=@- pb

" spell check options.
" note: use 'zg' to add the current word to the dictionary
" use z= to get a list of the possible spelling suggestions.
"---------------------------------------------------------------------
set spelllang=en_us
" personal word list
set spellfile="~/iCloud/src/configs/aspell/aspell.en.pws"
set spellcapcheck=""                " ignore capitalization
" spell check keybindings
" spell check the buffer
noremap <silent><leader>s :set spell!<cr>
nnoremap <silent><leader>S ea<C-X><C-S>
" replace the current word with the 1st suggestion.
" this works - most of the time
nnoremap <silent><leader>r 1z=

" misc. vim support files and settings. swap, backup, etc.
set swapfile
set directory^=~/.vim/swap//
set nowritebackup        " set for coc integration
set nobackup           " but do not persist backup after successful write
set backupcopy=auto    " use rename-and-write-new method whenever safe
set backupdir^=~/.vim/backup//
set undofile           " persist the undo tree for each file
set undodir^=~/.vim/undo//

" mode specific settings below
" ---------------------------------------------------------------------------

" filetype: json 
" disable quote concealing in json files
let g:vim_json_conceal=0


" filetype: markdown 
"open markdown files in marked2
nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'shell=sh']


" vim-markdown-toc elements
let g:vmt_dont_insert_fence = 1
let g:vmt_list_item_char = "-"

" plugin settings below
" --------------------------------------------------------------------------

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
autocmd FileType gitcommit let b:EditorConfig_disable = 1

let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom-snippets"]


" coc configuration
" ----------------------------------------------------------------------

" always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" jump between linting errors 
" use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" coc-snippets configuration
" ----------------------------------------------------------------------
" use <c-l> for trigger snippet expand.
imap <c-l> <Plug>(coc-snippets-expand)

" use <c-j> for select text for visual placeholder of snippet.
vmap <c-j> <Plug>(coc-snippets-select)

" use <c-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" use <c-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" use <c-j> for both expand and jump (make expand higher priority.)
imap <c-j> <plug>(coc-snippets-expand-jump)

" use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" the following enables the use of <tab> for completion w/coc 
inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" the following will enable completion only for the selected filetypes
let g:coc_file_types = ['vim', 'sh', 'python', 'c']
function! s:disable_coc_completion()
  if index(g:coc_file_types, &filetype) == -1
          let b:coc_suggest_disable = 1
  endif
endfunction

augroup CocGroup
  autocmd!
  autocmd BufNew,BufEnter * call s:disable_coc_completion()
augroup end

" dash documentation - search for what the cursor is over
nmap <silent><leader>d <Plug>DashSearch

" fancy status line.
let g:airline_enable_branch = 1
let g:airline_powerline_fonts = 1        " requires powerline fonts
let g:airline#extensions#ale#enabled = 1 " show ale errors on statusline
let g:airline_extensions = ["ale", "branch", "netrw", "virtualenv"]
let g:airline_theme='solarized'

" ALE configuration
" ----------------------------------------------------------------------
" https://github.com/dense-analysis/ale - see the FAQ
" note, for the mac, i need to match on the expanded iCloud path.  this is
" what's going on in the first dict entry here. 
let g:ale_pattern_options = {
\  '.*CloudDocs/notes/.*\.md$': {'ale_enabled': 0},
\  '.*\.notes/.*\.md$': {'ale_enabled': 0},
\}

" move thru ALE errors
nmap <silent> <C-k> :ALEPrevious<cr>
nmap <silent> <C-j> :ALENext<cr>


" vim-ghost setup - note, this is only enabled under nvim.  but it should be
" nicely ignored by vim. 
function! s:SetupGhostBuffer()
    if match(expand("%:a"), '\v/ghost-(partnerissue|gitlab|github|reddit).*-')
        set ft=markdown
    endif
endfunction

augroup vim-ghost
    au!
    au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END

if has("gui_running")
  " only turn on ghost by default in a gui
  let g:ghost_autostart = 1
  "let g:ghost_cmd = 'VimR'
else
  let g:loaded_ghost = 0
endif


" handle vim vs. neovim differences
" ----------------------------------------------------------------------
if has('nvim')

  " workaruond broken column edit behavior. specific to neovim
  map p <Plug>(miniyank-autoput)
  map P <Plug>(miniyank-autoPut)

else
  " vim specific config
  set viminfo=%,'50,\"100,:100,n~/.viminfo
endif

let g:fugitive_gitlab_domains = ['https://gitlab.aristanetworks.com']

" for vim-table-mode use markdown stule corners
let g:table_mode_corner='|'

" import any relevant API keys, etc. 
source ~/.credentials/vim-api-keys


set runtimepath+=~/.vim/pack/default/start/vim-ultisnips
if isdirectory("~/.fzf")
  set runtimepath+=~/.fzf
else
  set runtimepath+=/usr/local/opt/fzf
endif
