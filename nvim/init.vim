set nocompatible
filetype off
" make sure to add vim-plug to the autoload dir
call plug#begin()

Plug 'neomake/neomake'

" Plug 'Numkil/ag.nvim'
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/deoplete.nvim'
" Plug 'cloudhead/neovim-fuzzy'
" Plug 'kien/rainbow_parentheses.vim'
" Plug 'luochen1990/rainbow'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'tomtom/tlib_vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'jacoborus/tender'
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kchmck/vim-coffee-script'
Plug 'kshenoy/vim-signature'
Plug 'lambdatoast/elm.vim'
Plug 'majutsushi/tagbar'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'simnalamburt/vim-mundo'
Plug 'terryma/vim-expand-region'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"======================================
"
"  GENERAL CONFIGS
"
"======================================
autocmd vimenter * NERDTree

" Remap <Leader> to spacebar
let mapleader=" "

"-------------------------------------
" Display
"-------------------------------------
" Font stuff
if has('gui_running')
" set guifont=Sauce\ Code\ Powerline:h13
  " set guifont=Office\ Code\ Pro:h13
  set guifont=Fira\ Code:h13
endif
set tenc=utf8


if (has("termguicolors"))
 set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

syntax enable

" colors Tomorrow-Night-Eighties
colorscheme tender

" Show whitespace
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" show line numbers
set number
" set relativenumber
set nowrap

" Keep buffers, instead of closing them
set hidden

" Stop from hiding quotes in JSON, etc
set conceallevel=0

" Save on window blur
au FocusLost * :wa

" Automatically resize panes when the terminal is resized
autocmd VimResized * :wincmd =

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Set columns at 80 and 120 chars
if exists('+colorcolumn')
  set colorcolumn=80,120
  " hi ColorColumn ctermbg=236
endif

"-------------------------------------
" Cursor
"-------------------------------------
" Redraw quicker
set lazyredraw
set ttyfast

" More context around cursor when scrolling
set scrolloff=999 " Hack to set cursor in the middle of the screen
set cursorline

"-------------------------------------
" Yank/Paste/Registers
"-------------------------------------
" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Delete character should not squash paste buffer
nnoremap <silent> x "xx
vnoremap <silent> x "xx

" Fix for Sierra's clipboard
set clipboard=unnamed

" Toggle paste mode on and off
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"-------------------------------------
" Searching
"-------------------------------------
" Search stuff
set incsearch
set hlsearch
set smartcase
nmap <Leader>/ :nohl<cr>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Ignore .git et al from results
set wildignore+=*/.hg/*,*/.svn/*,*/bower_components/*,*/node_modules/*,*/tmp/*

"-------------------------------------
" Command
"-------------------------------------
" Remap the default leader to next character, since I use <Space> for leader
nnoremap \ ;
vnoremap \ ;
" Remap command to not have to use <Shift>
nnoremap ; :
vnoremap ; :

" Autocomplete command mode
set wildmenu
set wildmode=list:longest,full

" Set to auto read when a file is changed from the outside
set autoread

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set noswapfile " swapfiles don't really do anything for me

"-------------------------------------
" Insert Mode
"-------------------------------------
" Remap Esc
imap jk <Esc>

" Tab stuff correctly
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

"-------------------------------------
" Visual Mode
"-------------------------------------
" Remap Esc
vmap <Leader><Leader> <Esc>

" Shortcut to visual line mode
nmap <Leader><Leader> V

"==================================
"
"  PACKAGE CONFIGS
"
"==================================
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, guifg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermfg='. a:fg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'green', '#c9d05c')
call NERDTreeHighlightFile('config', 'green', '#c9d05c')
call NERDTreeHighlightFile('conf', 'green', '#c9d05c')
call NERDTreeHighlightFile('json', 'green', '#d3b987')
call NERDTreeHighlightFile('js', 'yellow', '#d3b987')
call NERDTreeHighlightFile('html', 'cyan', '#44778d')
call NERDTreeHighlightFile('hbs', 'cyan', '#44778d')
call NERDTreeHighlightFile('scss', 'cyan', '#44778d')
call NERDTreeHighlightFile('css', 'cyan', '#44778d')
call NERDTreeHighlightFile('coffee', 'brown', '#f43753')
call NERDTreeHighlightFile('rb', 'Red', '#f43753')
call NERDTreeHighlightFile('ex', 'Magenta', '#ff00ff')
call NERDTreeHighlightFile('exs', 'Magenta', '#ff00ff')

" NERDTree Git
if !exists('g:NERDTreeIndicatorMap')
    let g:NERDTreeIndicatorMap = {
                \ "Modified"  : "⚠",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "•",
                \ "Clean"     : "✔︎",
                \ "Unknown"   : "?"
                \ }
endif

" Fixes problem with GitGutter: ihttps://github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_realtime = 0

" Indent Guide
" autocmd vimenter * IndentGuidesEnable
" let g:indent_guides_auto_colors = 0
" let g:indent_guides_guide_size  = 1
" highlight IndentGuidesOdd ctermbg=236
" highlight IndentGuidesEven ctermbg=236
let g:indentLine_color_gui = '#444444'
let g:indentLine_bgcolor_term = 236
let g:indentLine_char = '┇'

" Multi Cursor
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_quit_key='<Esc>'

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Easymotion
nmap <Enter> <Plug>(easymotion-prefix)

" Neosnippet / Deoplete
" imap <C-j> <Plug>(neosnippet_expand_or_jump)
" smap <C-j> <Plug>(neosnippet_expand_or_jump)
" xmap <C-j> <Plug>(neosnippet_expand_target)

" deoplete tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" let g:deoplete#enable_at_startup = 1

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" NERD Tree
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>

" NERDCommenter
let NERDSpaceDelims = 1

" NeoFuzzy - Fuzzy file finder
nnoremap <Leader>o :Files<CR>

" Neomake
autocmd! BufWritePost * Neomake

let g:neomake_warning_sign = {
  \ 'text': '⚠',
  \ }
let g:neomake_error_sign = {
  \ 'text': '✗',
  \ }

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_makers = ['rubocop']

" Airline
let g:airline_theme='tender'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Gundo
let g:mundo_prefer_python3 = 1
nnoremap gh :MundoToggle<CR>
set undofile
set undodir=~/.nvim/undo

" Rainbow Parentheses
" let g:rbpt_colorpairs = [
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]


" au VimEnter * RainbowParenthesesToggle
" au Syntax clojure RainbowParenthesesLoadRound
" au Syntax clojure RainbowParenthesesLoadSquare
" au Syntax clojure RainbowParenthesesLoadBraces

" Rainbow

" Fireplace
" au FileType clojure nmap <Leader>t :w<CR>:Require<CR>:Eval<CR>
" au FileType clojure nmap <Leader>s :w<CR>:Eval<CR>

let test#strategy = "vimux"
let test#python#runner = "pytest"

" Test runner mappings
nmap <silent> <Leader>t :w<CR> :TestFile<CR>
nmap <silent> <Leader>s :w<CR> :TestNearest<CR>
nmap <silent> <Leader>l :w<CR> :TestLast<CR>
nmap <silent> <Leader>L :w<CR> :TestVisit<CR>
nmap <silent> <Leader>a :w<CR> :TestSuite<CR>


if has('gui_running')
  let g:rspec_runner = "os_x_iterm"
else
  let g:rspec_command = 'call VimuxRunCommand("clear; RAILS_ENV=test bundle exec rspec {spec}")'
end

" Vim/tmux navigator
let g:tmux_navigator_save_on_switch = 1

" Tmuxline
let g:tmuxline_powerline_separators = 1

let g:tmuxline_preset = {
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '',
        \ 'y': ['%a %b %d', '%R'],
        \ 'z': '#h'}

"==================================
"
"  SUPPORT FUNCTIONS
"
"==================================

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"


    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")


    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif


    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction
