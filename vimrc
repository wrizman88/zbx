"""""""""""""""""""""""""""""""""""""""""""""""
" support  C++, Javascript, HTML, markdown,
" javascript, python
"""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" keyword completion system
" Key: Tab
Plugin 'Shougo/neocomplete.vim'
" comment
" Key: gcc
Plugin 'tpope/vim-commentary'
" The NERD tree allows you to explore your filesystem and to open files and
" directories.
" Key: F7
" <CR> to open in current window. s to split window and t to a new tab
Plugin 'scrooloose/nerdtree'
" Show the structure
" Key: F8
Plugin 'majutsushi/tagbar'
" color for parentheses
" Key: auto
Plugin 'luochen1990/rainbow'
" This plugin is used for displaying thin vertical lines at each indentation
" level for code indented with spaces
" Key: auto
Plugin 'Yggdroot/indentLine'
" syntax and indent plugin for js
" Key: auto
Plugin 'pangloss/vim-javascript'
" all trailing whitespace characters (spaces and tabs) to be highlighted
" Key: auto
Plugin 'ntpeters/vim-better-whitespace'
" Use Clang to complete c++
" Key: auto
Plugin 'osyo-manga/vim-marching'
" Powerful syntax checking
" Key: auto
Plugin 'scrooloose/syntastic'
" fuzzy finding
" Key: <C-p> cancelled.
" Command: :CtrlP
Plugin 'elzr/vim-json'
Plugin 'mxw/vim-jsx'
Plugin 'kien/ctrlp.vim'
" Plugin 'mileszs/ack.vim'
Plugin 'editorconfig/editorconfig-vim'
" status bar and tabline
" Key: <leader>1,<leader>2,..,<C-n> to create,<C-q> to next, or gt to next
" Command: :tabnew, tabnext
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'digitaltoad/vim-jade'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'jiangmiao/auto-pairs'
" The most reccent use
" Key: <C-m>
Plugin 'vim-scripts/mru.vim'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'lyuts/vim-rtags'
" :A switches to the header file corresponding to the current file being
Plugin 'a.vim'
" Simple tmux statusline generator with support for powerline symbols and vim/airline/lightline statusline integration
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on


""""""""""""""""""""""""
" Conf for neocomplete "
""""""""""""""""""""""""
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"""""""""""""""""""""""
" Conf for rtags      "
"""""""""""""""""""""""
" let g:rtagsUseDefaultMappings = 0
let g:rtagsUseLocationList = 0
let g:rtagsJumpStackMaxSize = 100

function! SetupNeocomleteForCppWithRtags()
    " Enable heavy omni completion.
    setlocal omnifunc=RtagsCompleteFunc

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let l:cpp_patterns='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.cpp = l:cpp_patterns
    set completeopt+=longest,menuone
endfunction

autocmd FileType cpp,c call SetupNeocomleteForCppWithRtags()

"""""""""""""""""""""""
" Conf for commentary "
"""""""""""""""""""""""
autocmd FileType markdown setlocal commentstring=<!--%s-->
autocmd FileType cpp setlocal commentstring=//\ %s

"""""""""""""""""""""
" Conf for nerdtree "
"""""""""""""""""""""
noremap <F7> <ESC>:NERDTreeToggle<CR>

"""""""""""""""""""
" Conf for tagbar "
"""""""""""""""""""
nnoremap <F8> <ESC>:Tagbar<CR>

""""""""""""""""""""""""""""
" Conf for vim-javascripts "
""""""""""""""""""""""""""""
let g:javascript_enable_domhtmlcss= 0

"""""""""""""""""""""""""
" Conf for vim-marching "
"""""""""""""""""""""""""
let g:clang_user_options="-std=c++11"
let g:marching_clang_command = "/usr/bin/clang"
let g:marching_include_paths = [
      \ "/usr/include/c++/4.8"
      \ ]
let g:marching_enable_neocomplete = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
" let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

""""""""""""""""""""
" Conf for rainbow "
""""""""""""""""""""
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan'],
    \   'operators': '_,_',
    \   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
    \   'separately': {
    \       '*': {},
    \       'html': {},
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \           'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
    \       },
    \       'vim': {
    \           'parentheses': [['fu\w* \s*.*)','endfu\w*'], ['for','endfor'], ['while', 'endwhile'], ['if','_elseif\|else_','endif'], ['(',')'], ['\[','\]'], ['{','}']],
    \       },
    \       'tex': {
    \           'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
    \       },
    \       'css': 0,
    \       'stylus': 0,
    \   }
    \}

""""""""""""""""""""""
" Conf for syntastic "
""""""""""""""""""""""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['puppet', 'html'] }
noremap <F9> <ESC>:SyntasticToggleMode<CR>
" let g:syntastic_c_config_file = '.syntastic_c_config'
" let g:syntastic_c_checkers = ['gcc', 'cppcheck']
" let g:syntastic_cpp_checkers = ['gcc', 'cppcheck']
" let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_css_checkers = ['csslint']

"""""""""""""""""""""""""""""""""
" Conf for vim-colors-solarized "
"""""""""""""""""""""""""""""""""
let g:solarized_bold = 0
let g:solarized_contrast = "low"
" let g:solarized_termcolors = 256

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized


"""""""""""""""""""""
" Conf for Vim-Json "
"""""""""""""""""""""
" let g:vim_json_syntax_conceal = 0
" let g:indentLine_noConcealCursor=""

autocmd InsertEnter *.json setlocal conceallevel=2 concealcursor=
autocmd InsertLeave *.json setlocal conceallevel=2 concealcursor=inc

"""""""""""""""""""""
" Conf for Vim-jsx  "
"""""""""""""""""""""
" let g:jsx_ext_required = 0

""""""""""""""""""""""
" Conf for airline   "
""""""""""""""""""""""
" nnoremap <C-f> :CtrlP<CR>

""""""""""""""""""""""
" Conf for airline   "
""""""""""""""""""""""
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number


" inoremap <C-n> <ESC>:w<CR>:tabnew<CR>
" nnoremap <C-n> :tabnew<CR>
inoremap <C-n> <ESC>:w<CR>:tabnext<CR>
nnoremap <C-n> :tabnext<CR>

let g:airline_theme='luna'
" let g:airline_theme='wombat'
" let g:airline_theme='molokai'
" let g:airline_theme='papercolor'

" let g:airline#extensions#tmuxline#enabled = 0
" let airline#extensions#tmuxline#color_template = 'normal'
" let airline#extensions#tmuxline#color_template = 'insert'
let airline#extensions#tmuxline#snapshot_file = "~/.tmuxline.conf"

let g:airline#extensions#branch#enabled = 1

"""""""""""""""""""""
" Conf for Vim-Json "
"""""""""""""""""""""
" nnoremap <C-m> :MRU<CR>

""""""""""""""""""""
" Conf for markdown"
""""""""""""""""""""
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 6
autocmd FileType markdown let g:indentLine_conceallevel=1

autocmd InsertEnter *.md setlocal conceallevel=1 concealcursor=
autocmd InsertLeave *.md setlocal conceallevel=1 concealcursor=inc


""""""""""""""""""""
" Conf for tags    "
""""""""""""""""""""
set tags+=./tags

"""""""""""""""""""""""
" General vim settings "
"""""""""""""""""""""""
" nnoremap <C-s> :w<CR>
" inoremap <C-s> <ESC>:w<CR>i

syntax on
set scrolloff=4


set modeline
set modelines=5

set ignorecase
set hlsearch
set smartcase
set incsearch

set wildmenu
set wildmode=longest,list

set backspace=indent,eol,start
set autoindent
set cindent
set smartindent

set expandtab
set smarttab

set shiftwidth=4
set tabstop=4
set softtabstop=4

set number
set novisualbell
set noerrorbells
set laststatus=2
set vb t_vb=
set ruler
set showcmd
set t_Co=256
" if $TERM == "xterm-256color"
"     set t_Co=256
" endif
set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=237 ctermfg=NONE guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=235 ctermfg=NONE guibg=darkred guifg=white
" set mouse=a

set undofile
set undodir=/usr/gcy/.vimundo

autocmd BufRead,BufNew *.md setlocal ft=markdown

autocmd BufReadPost *
      \ if line("'\"")>0&&line("'\"")<=line("$") |
      \	exe "normal g'\"" |
      \ endif
