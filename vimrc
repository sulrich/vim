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
set termguicolors      " necessary to make things work in vimr
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
ab seea  see attached ...
ab ssig  { snipped - misc .signatures }
ab sprev { snipped - misc previous correspondence }
ab x70- ----------------------------------------------------------------------
ab x70= ======================================================================
ab cca comments/corrections/additions appreciated

" insert my preferred date time stamp
iab <expr> dstamp strftime("%Y%m%d")
iab <expr> dts strftime("%Y%m%d-%H%M")

" misc. additional mappings/functions
"remove all trailing whitespace by pressing f5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" send stuff to pb
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
set writebackup        " protect against crash-during-write
set nobackup           " but do not persist backup after successful write
set backupcopy=auto    " use rename-and-write-new method whenever safe
set backupdir^=~/.vim/backup//
set undofile           " persist the undo tree for each file
set undodir^=~/.vim/undo//

" mode specific settings below
" ---------------------------------------------------------------------------

" markdown files
"open markdown files in marked2
nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'shell=sh']

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

" nerdtree
map <C-o> :NERDTreeToggle<CR>

" dash documentation - search for what the cursor is over
nmap <silent><leader>d <Plug>DashSearch

" fancy status line.
let g:airline_enable_branch = 1
let g:airline_powerline_fonts = 1        " requires powerline fonts
let g:airline#extensions#ale#enabled = 1 " show ale errors on statusline
let g:airline_extensions = ["ale", "branch", "netrw", "tabline", "virtualenv"]
" let g:airline_theme='nord'
let g:airline_theme='solarized'

" move thru ALE errors
nmap <silent> <C-k> :ALEPrevious<cr>
nmap <silent> <C-j> :ALENext<cr>

" https://github.com/dense-analysis/ale - see the FAQ
" note, for the mac, i need to match on the expanded iCloud path.  this is
" what's going on in the first dict entry here. 
let g:ale_pattern_options = {
\  '.*CloudDocs/notes/.*\.md$': {'ale_enabled': 0},
\  '.*\.notes/.*\.md$': {'ale_enabled': 0},
\}

" handle vim vs. neovim differences
if has('nvim')
  let $GHOSTTEXT_SERVER_PORT = 4001

  augroup nvim_ghost_user_autocommands
    au User www.reddit.com,www.stackoverflow.com set filetype=markdown
    au User partnerissue* set filetype=markdown
    au User gitlab* set filetype=markdown
    au User *github.com set filetype=markdown
  augroup END

  " workaruond broken column edit behavior. specific to neovim
  map p <Plug>(miniyank-autoput)
  map P <Plug>(miniyank-autoPut)

else
  " vim specific config
  set viminfo=%,'50,\"100,:100,n~/.viminfo
endif


set runtimepath+=~/.vim/pack/default/start/vim-ultisnips
set runtimepath+=/usr/local/opt/fzf
