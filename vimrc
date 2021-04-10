 " escape alternative - insert-mode
imap kj <Esc>
let mapleader=","             " better than the use of the \

set encoding=utf-8            " self-explanator
set textwidth=80              " where to wrap
set shortmess=at              " abbreviate and truncate file messages
set showmatch                 " briefly flash to the matching element

set visualbell             " disable the beep
set autoread               " if a file changes externally, update buffer

" address the tabs-vs-spaces debate ...
set softtabstop=2
set expandtab 


" let's see what happens with the sensible plugin here. 
" set formatoptions=tcqrt2          " XXX - document this better
" set linebreak
" set wrapwidth=80

" interface configuration
set cmdheight=2        " command line two lines high
set laststatus=2
set ruler              " show line # info, etc.
set showmode           " show the mode in the status line
set showcmd            " show selection infoj

set colorcolumn=80
colorscheme nord

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
ab seea  see attached ...
ab ssig  { snipped - misc .signatures }
ab sprev { snipped - misc previous correspondence }
ab x70- ----------------------------------------------------------------------
ab x70= ======================================================================
ab cca comments/corrections/additions appreciated

" spell check options. 
" note: use 'zg' to add the current word to the dictionary
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
nnoremap <silent><leader>r 1z

" misc. vim support files and settings. swap, backup, etc.
set swapfile
set directory^=~/.vim/swap//
set writebackup        " protect against crash-during-write
set nobackup           " but do not persist backup after successful write
set backupcopy=auto    " use rename-and-write-new method whenever safe
set backupdir^=~/.vim/backup//
set undofile           " persist the undo tree for each file
set undodir^=~/.vim/undo//
set viminfo=%,'50,\"100,:100,n~/.viminfo

" mode specific settings below
" ---------------------------------------------------------------------------

" mutt messages
autocmd BufNewFile,BufRead mutt-* set syntax=mail spell tw=78 fo+=2n ai
autocmd BufNewFile,BufRead *.txt,*.tex 
 \ set wrap linebreak nolist textwidth=0 wrapmargin=0

" markdown files
"open markdown files in marked2
nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>
let g:markdown_folding = 1
let g:markdown_enable_folding = 1

" plugin settings below
" --------------------------------------------------------------------------

" editorconfig 
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
autocmd FileType gitcommit let b:EditorConfig_disable = 1

" trigger configuration. do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<M-j>"
let g:UltiSnipsJumpBackwardTrigger="<M-k>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom-snippets"]

" notational velocity for vim
let g:nv_search_paths = ['~/.notes']
let g:nv_default_extension = '.md'
let g:nv_create_note_key = 'ctrl-x'
let g:nv_create_note_window = 'tabedit'

" nerdtree
map <C-o> :NERDTreeToggle<CR>  

" dash documentation - search for what the cursor is over
nmap <silent><leader>d <Plug>DashSearch

" fancy status line.
let g:airline_enable_branch = 1
let g:airline_powerline_fonts = 1        " requires powerline fonts
let g:airline#extensions#ale#enabled = 1 " show ale errors on statusline
let g:airline_extensions = ["ale", "branch", "netrw", "tabline", "virtualenv"]
let g:airline_theme='nord'

" move thru ALE errors
nmap <silent> <C-k> :ALEPrevious<cr>
nmap <silent> <C-j> :ALENext<cr>

set runtimepath+=~/.vim/pack/default/start/vim-ultisnips
