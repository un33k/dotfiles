"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" Vim settings """"""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""
""" Pathogen
filetype off                " disable filetype, pathogen needs this
call pathogen#runtime_append_all_bundles()
filetype on                 " enable filetype detection
filetype plugin on          " enable plugin loading
filetype plugin indent on   " enable indentation loading

""""""""
""" Misc
set nocompatible             " vi is quite old, ok?
set title                    " set term title
set modelines=2              " avoid some security issues
set ruler                    " show cursor position
set showmode                 " show current mode
set showcmd                  " show command in status line
set encoding=utf-8           " default encoding
"set scrolloff=5              " 5 lines of context when moving
set ttyfast                  " faster tty I/O
set number                   " display numbers
"set relativenumber          " relative numbering
set laststatus=2             " always show status line
set showmatch                " show matching brackets
set wildmenu                 " improved completion option showing
set wildmode=full            " display list of possible completions
set autowrite                " save before switching buffers
set cryptmethod=blowfish     " crypt algorithm
set wrap                     " wrap text at the end
set textwidth=79             " default textwidth
set formatoptions=qrn1       " auto formating options see fo-table
set backupdir=$HOME/.vim/backups " set backup files here
set directory=$HOME/.vim/backups " set swap files here
set gdefault                 " global sustitution by default
set completeopt=menuone,longest,preview " completion menu style
set t_Co=256                 " 256 color compatibility
"set clipboard=unnamed        " use + clipboard by default

"""""""""""""""""""
""" Persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000  " number of changes that can be undone
set undoreload=10000 " number lines to save for undo on a buffer reload

"""""""""""""""""""
""" Tabs and spaces
set autoindent                      " enable autoindenting
set smartindent                     " smarter indenting
set shiftwidth=4                    " 4 spaces indent
set softtabstop=4                   " spaces that represent a tab
set tabstop=4                       " replace tabs with 4 spaces
set expandtab                       " expand tabs to spaces
set smarttab                        " smarting tab
set backspace=indent,eol,start      " backspace behavior

"""""""""""""
""" Searching
set noignorecase        " case is important
set incsearch           " incremental search
set hlsearch            " higlight searching

""""""""""""""""""""
""" Syntax and theme
syntax on                   " enable syntax coloring
syntax sync fromstart       " sync syntax from start
set background=dark         " dark backround for better reading
colorscheme jellybeans      " current colorscheme

" Syntax overriding,
"   * html is always htmldjango
"   * sup files are always mail
au BufRead,BufNewFile *.html set filetype=htmldjango
au BufRead            sup.*  set ft=mail
au BufRead,BufNewFile *.less set filetype=less
au BufRead,BufNewFile *.ru   set filetype=ruby
au BufNewFile,BufRead *.prawn set filetype=ruby

"""""""""""""""
""" Status line
set statusline=%<%F%=%h%m%r%h%w\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}\ %y\ [%{&ff}]\ (%l,%c)\ %P


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" Mappings """"""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","         " set mapleader to something useful

" Enter introduces a new line on command mode
nmap <cr> i<cr><esc>

" toggle line numbering on/off
nmap <leader>n :set number!<cr>

" quick saving
nmap <silent> <F12> :write<cr>
imap <silent> <F12> <esc>:write<cr>

" quick files navigation
noremap <F2> :prev<cr>
noremap <F3> :next<cr>

" easier nice navigation
nnoremap j gj
nnoremap k gk

" clipboard copying
map Y "+y$

" \v disables vim regex rules
" nnoremap / /\v
" vnoremap / /\v

" togle highlighting off
nnoremap <leader><leader> :noh<cr>

" disable the damn help key
inoremap <F1> <esc>
nnoremap <F1> <esc>
vnoremap <F1> <esc>

" tabs shortcuts
nmap sn :tabnew 
nmap sj :tabnext<cr>
nmap sk :tabprevious<cr>

" quick current directory file opening, open in current buffer
" vertical split, horizontal split and new tab
map <leader>e :e <C-R>=expand("%:p:h") . "/" <cr>
map <leader>v :vsp <C-R>=expand("%:p:h") . "/" <cr>
map <leader>h :sp <C-R>=expand("%:p:h") . "/" <cr>
map <leader>o :tabnew <C-R>=expand("%:p:h") . "/" <cr>

" copy between vim sessions using intermediate file
nmap <leader>r :r $HOME/.vimxfer<cr>
nmap <leader>w :'a<leader>.w! $HOME/.vimxfer<cr>
vmap <leader>r c<esc>:r $HOME/.vimxfer<cr>
vmap <leader>w :w! $HOME/.vimxfer<cr>

" spell checking (spanish and english)
nmap <leader>spes :set spell spelllang=es<cr>
nmap <leader>spen :set spell spelllang=en<cr>
nmap <leader>spr :setlocal nospell<cr>
map <leader>c ]sz=
map <leader>C ]s1z=

imap jj <ESC>

" helpful mercurial shortcuts
map <leader>au :!hg annotate -nu % \| less<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""" Plugins configurations """"""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" supertab
let g:SuperTabDefaultCompletionType = "context"

" python_open_module, open current module below cursor in v-split
let pom_key_open_in_win='<leader>p'

" custom scripts loading (top tabline)
source $HOME/.vim/tabline.vim

" nerdtree, it's toggled on/off with <leader>t
let NERDTreeChDirMode = 1
let NERDTreeIgnore = ['\.pyc$', '\~$', '.hg', '.git']
nmap <silent> <leader>t :NERDTreeToggle<cr>

" sparkup mapping
let g:sparkupExecuteMapping = '<c-p>'

autocmd FileType python map <buffer> <F5> :call Pep8()<cr>
autocmd FileType ruby set shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType javascript nmap <leader>l :JSLintUpdate<cr>

" Command-T
nmap <leader>ff :CommandT<cr>

" python syntax highlighting
let python_highlight_builtin_objs = 1
let python_highlight_builtin_funcs = 1
let python_highlight_exceptions = 1
let python_highlight_string_formatting = 1
let python_highlight_indent_errors = 1
let python_highlight_space_errors = 1
let python_highlight_doctests = 1
