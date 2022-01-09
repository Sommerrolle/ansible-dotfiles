set guicursor=              " cursor as block
set number relativenumber   " add line numbers
set hidden                  " something with buffers
set noerrorbells
set showmatch               " show matching brackets.
set undodir=~/.vim/undodir
set undofile
set scrolloff=8
set signcolumn=yes
" set colorcolumn=80
set mouse=v                 " middle-click paste with mouse

" Tab and Indent configuration
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set smartindent              " indent a new line the same amount as the line just typed

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
set nohlsearch              " highlight search results
set incsearch

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

call plug#begin('~/config/nvim/autoload/plugged')

"Plug 'nvim-telescope/telescope.nvim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
"Plug 'JamshedVesuna/vim-markdown-preview'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
" Plugins for Python Coding
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
" Plug 'tell-k/vim-autopep8' "Autoformatting python file according to PEP 8
" Plug 'nvie/vim-flake8' "Linting python code

" UI related
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Better Visual Guide
Plug 'Yggdroot/indentLine'
" syntax check
Plug 'w0rp/ale'
" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
" Formater
Plug 'Chiel92/vim-autoformat'
call plug#end()

filetype plugin indent on " Wegen tutorial: https://yufanlu.net/2018/09/03/neovim-python/

hi Normal guibg=NONE ctermbg=NONE 
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

let mapleader = " "

" NERDTree settings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-F> :NERDTreeFind<CR>

" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" FINDING FILES:
set path+=**    " Search down into subfolders
set wildmenu    " Display all matching files when we tab complete
nnoremap <C-f> :find<CR>

" Code of Completion (coc) plugin"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Create matching brackets
" Don't need it with jedivim python plugins'
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" Further settings for python coding
" Close auto-complete window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Navigate through auto-complete window with tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Execute Python file
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" davidhalter/jedi-vim configs
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

" vim-autoformat
noremap <F3> :Autoformat<CR>
" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect
  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new line.
  inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
  " uncomment this block if you use vimtex for LaTex
  " autocmd Filetype tex call ncm2#register_source({
  "           \ 'name': 'vimtex',
  "           \ 'priority': 8,
  "           \ 'scope': ['tex'],
  "           \ 'mark': 'tex',
  "           \ 'word_pattern': '\w+',
  "           \ 'complete_pattern': g:vimtex#re#ncm2,
  "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
  "           \ })
augroup END
" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}
" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'


" Activate gruvbox color scheme
"g:gruvbox_contrast_light = 'hard'
"let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
"hi Normal guibg=NONE ctermbg=NONE
