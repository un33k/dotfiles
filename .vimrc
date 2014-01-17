"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""" Vim settings """"""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""
""" Pathogen
call pathogen#infect()
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
if exists('+cryptmethod')
    set cryptmethod=blowfish     " crypt algorithm
endif

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
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*.bak,*.exe,*.pyc,*.DS_Store,*.db

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

au InsertEnter * set cul
au InsertLeave * set nocul

" Syntax overriding,
"   * html is always htmldjango
"   * sup files are always mail
au BufRead,BufNewFile *.html set filetype=htmldjango
au BufRead            sup.*  set ft=mail
au BufRead,BufNewFile *.less set filetype=less
au BufRead,BufNewFile *.ru   set filetype=ruby
au BufNewFile,BufRead *.prawn set filetype=ruby
au BufRead,BufNewFile *.slim set filetype=haml
au BufRead,BufNewFile *.eco set filetype=eruby

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

" GUndo
map <leader>u :GundoToggle<cr>

" gist
nmap <leader>g :Gist -p<cr>
vmap <leader>g :Gist -p<cr>

imap jj <ESC>

" helpful mercurial shortcuts
map <leader>au :!hg annotate -nu % \| less<cr>

" set Unix and UTF8 encoding on current file
nmap <leader>q :set fileencoding=utf8 fileformat=unix<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""" Plugins configurations """"""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '&omnifunc'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>", "&completefunc<c-x><c-n>"]

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
autocmd FileType javascript set shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType htmldjango set shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufNewFile,BufRead [vV]agrantfile set filetype=ruby
autocmd BufNewFile,BufRead [cC]apfile set filetype=ruby
autocmd BufNewFile,BufRead [tT]horfile set filetype=ruby
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.mote set filetype=mote
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *.skim set filetype=haml
autocmd FileType gitcommit DiffGitCached | wincmd p | wincmd H


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

" syntastic
let g:syntastic_javascript_checker = 'jslint'
let g:syntastic_javascript_jslint_conf = "--white --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars --es5=false"
let g:syntastic_python_checker_args = '--ignore=E712,E121,E123,E124,E126,E127,E128'
let g:syntastic_python_checker = 'flake8'  " pip install flake8

" powerline
let g:Powerline_symbols = 'fancy'

" UltiSnips
let g:UltiSnipsSnippetsDir = "$HOME/.vim/ultisnips"

" VimColor
let g:cssColorVimDoNotMessMyUpdatetime = 1


" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {'default' : ''}

if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.python = '[^. *\t]\.\w*\|\h\w*::'

" Jedi python autocompletion
let g:jedi#popup_on_dot = 0
let g:jedi#show_function_definition = 0
