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

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1

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
command We execute ":w | :Eval"
