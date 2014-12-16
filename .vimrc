execute pathogen#infect()
syntax on
filetype plugin indent on
colors Tomorrow-Night-Eighties
autocmd vimenter * NERDTree


"======================================
"
"  GENERAL CONFIGS
"
"======================================

" Remap <Leader> to spacebar
let mapleader=" "

" More context around cursor when scrolling
set scrolloff=3

" Autocomplete command mode
set wildmenu
set wildmode=list:longest,full

" Remap Esc
:imap jk <Esc>

" Font stuff
if has('gui_running')
  set guifont=Sauce\ Code\ Powerline:h13
endif

" Column Length Highlighting
highlight OverLength81 ctermbg=yellow ctermfg=gray guibg=#592929
highlight OverLength120 ctermbg=red ctermfg=white guibg=#592929
match OverLength81 /\%81v.\+/
match OverLength120 /\%121v.\+/

" Tab stuff correctly
:set tabstop=2
:set shiftwidth=2
:set expandtab

" Show whitespace
:set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
:set list

" show line numbers
:set number
:set nowrap

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" Keep buffers, instead of closing them
set hidden

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Save on window blur
au FocusLost * :wa

"==================================
"
"  PACKAGE CONFIGS
"
"==================================

" NERD Tree
let NERDTreeShowHidden=1

" Rubocop Config
let g:syntastic_ruby_checkers = ['rubocop']

" CtrlP - Fuzzy file finder
let g:ctrlp_map = '<c-p>'

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '❉'

" Airline
let g:airline_powerline_fonts = 1

" Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Gundo
nnoremap gh :GundoToggle<CR>

" Rainbow Parentheses
" au FileType c,cpp,objc,objcpp,go,rust,javascript,java call rainbow#load()
au FileType clojure call rainbow#load(
            \ [['(', ')'], ['\[', '\]'], ['{', '}']],
            \ '"[-+*/=><%^&$#@!~|:?\\]"')

" Fireplace
:nmap <Leader>We :w<CR>:Eval<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_runner = "os_x_iterm"
