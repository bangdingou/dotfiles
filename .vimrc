"Last edited: Fri Jan 12 16:46:36 2024
"==============================================================================
                                 "Settings
"==============================================================================
set nocompatible                        " Use Vim settings, must be first
filetype plugin on                      " Vim plugins are enabled (for NETRW)

                        "### Vim Editor Look && Feel ###
let &t_SI = "\e[5 q"                    " Line cursor in insert
let &t_EI = "\e[2 q"                    " Block cursor not in insert
set cmdheight=2                         " The command bar height
set cursorline                          " Shows a highlighted cursor line
set laststatus=2                        " Last window will have a status line
set list                                " Shows invisible characters
set listchars=tab:>-,eol:$              " Invisible characters to show
set number                              " Always shows line numbers 
set relativenumber                      " Show relative line numbers
set ruler                               " Shows status line cursor position 
set scrolloff=3                         " Lines visible when scrolling
set ttyfast                             " Redraws quickly for a fast terminal
set wildmode=list:longest,full          " Vim autocompletion menus
set wildmenu                            " Shows the menu for tab completion
set showcmd                             " Current command shown in lower left

                               "### Searching ###
set gdefault                            " Substitutions globally
set hlsearch                            " Highlight search terms
set ignorecase                          " Ignores case during searches
set incsearch                           " Incremental searching
set smartcase                           " Capitalized word search exact match

                                "### Editing ###
set autoindent                          " New line, same indent level
set backspace=indent,eol,start          " Allows backspace over lines in Insert
set breakindent                         " Sets the indent on a block of text
set encoding=utf-8                      " Sets encoding
set expandtab                           " Use spaces instead of tabs
set linebreak                           " No broken words during wrapping
set shiftwidth=4                        " Enforces consistent tab behavior
set showmatch                           " Show matching brackets
set softtabstop=4                       " Soft tabs to 4 spaces
set tabstop=4                           " Sets the tabs to 4 spaces
set textwidth=80                        " Wraps at 80 characters
set whichwrap+=h,l                      " Allows line traversal
set wrap                                " Soft wrapping at 80 chars

                               "### Spelling ###
setlocal spell spelllang=eng_us         " Sets the spell check to US English
syntax enable                           " Highlighting of misspelled words

                         "### Vim Behind the Scenes ###
set noswapfile                          " No annoying intermediate swap files
set undofile                            " Undo information saved past a close
setlocal keywordprg=:help               " Shift-k for under-cursor lookup

                     "### Sets the undo and backup directories ###
set backup
let &backupdir = expand('~/.vim/vimdata/backup//')
set undofile
let &undodir = expand('~/.vim/vimdata/undo//')

if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif

                                 "### NETRW ###
" ?? let g:netrw_browse_split = 0       " Opens files in a new buffer
                                        " Needed if only using :Lex?
let g:netrw_winsize = 30                " Size of the preview window
let g:netrw_liststyle = 3               " Tree directory listing
let g:netrw_home = '~/.vim/vimdata'     " Home for my files
let g:netrw_banner = 0                  " Gets rid of the banner
let g:netrw_preview = 1                 " Vertical splitting preview default

"==============================================================================
                                 "Ranger
"==============================================================================
" From here: https://www.everythingcli.org/use-ranger-as-a-file-explorer-in-vim/
function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>

"==============================================================================
                                 "Mappings
"==============================================================================
" Leaders
let mapleader = ";"
let maplocalleader=","

" Insert mode escape
inoremap jj <ESC>

" Opens a NETRW window
nnoremap <Leader>l :Lex ~/Desktop/.vimwiki<CR>

" Disables arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Turns off highlights after search
nnoremap <Space> :nohl<CR>

" Mappings to traverse buffer list, quit a buffer, and start new file
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [q :bp <BAR> bd #<CR>
nnoremap <silent> [N :enew<CR>

" Easy moves from pane to pane
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle spell check
nnoremap <F5> :setlocal spell!<CR>

" Toggle all white space characters
nnoremap <F7> :set list!<CR>

" Saving and Restoring Sessions
nnoremap <Leader>ss :mks! ~/.vim/vimdata/sessions/current.vim
nnoremap <Leader>sr :so ~/.vim/vimdata/sessions/current.vim

" Insert date and time
map <Leader>D :r! date

" Edit/View and source $VIMRC quickly
nnoremap <Leader>ev :edit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" MarkdownPreview invocation
nnoremap <Leader>md <Plug>MarkdownPreviewToggle

" Tabularize invocation
if exists(":Tabularize")
  nnoremap <Leader>t :Tabularize /\|<CR>
  vnoremap <Leader>t :Tabularize /\|<CR>
  nnoremap <Leader>tb :Tabularize /
  vnoremap <Leader>tb :Tabularize /
endif

" Goyo invocation
nnoremap <Leader>gy :Goyo<CR>

"==============================================================================
"                                   Abbreviations
"==============================================================================
iabbrev @@ sumtingwong@mac.com

"==============================================================================
"                                   Plugins
"==============================================================================
" Directory for Plugins
" Using June Gunn's plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Plug 'junegunn/vim-plug'

" Some help with lining up text
" https://github.com/godlygeek/tabular
Plug 'godlygeek/tabular'

" Markdown Syntax highlighting, matching rules, and mappings
" https://github.com/preservim/vim-markdown 
Plug 'preservim/vim-markdown'

" Preview markdown in the browser with synchronized scrolling and flexible configuration
" https://github.com/iamcco/markdown-preview.nvim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" A simple tool to paste images into markdown files
" https://github.com/img-paste-devs/img-paste.vim
Plug 'img-paste-devs/img-paste.vim'

" FZF for Vim, a supersuperfast fuzzy finder
" https://github.com/junegunn/fzf.vim
" Plug 'junegunn/fzf', { 'do': { ->fzf#install() } }
Plug 'junegunn/fzf.vim'

" todo.txt-vim is a simple and easy todo list on any device
" http://todotxt.org/ and https://github.com/freitass/todo.txt-vim
Plug 'freitass/todo.txt-vim'

" Distraction-free writing in Vim
" https://github.com/junegunn/goyo.vim
Plug 'junegunn/goyo.vim'

" Lean & mean status/tabline for vim that's light as air
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" List ends-plugins become visible to vim after this call
call plug#end()

"==============================================================================
                                "Plugin settings
"==============================================================================
                                "### Airline ###
"
" Displays all buffers even when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" Enable/disable displaying tab type (e.g. [buffers]/[tabs])
let g:airline#extensions#tabline#show_tab_type = 1

" Show buffer label at first position
let g:airline#extensions#tabline#buf_label_first = 1

" Shows all buffers and tabs
:let g:airline#extensions#tabline#show_buffers=1

" Sets word count for all file types
let g:airline#extensions#wordcount#filetypes = ['all']

" enable/disable displaying open splits per tab (only when tabs are opened)
let g:airline#extensions#tabline#show_splits = 1

" Formats the file names in the top buffer status line, 't' for tail
let g:airline#extensions#tabline#fnamemod = ':t'
"
" Powerline Fonts for eye candy
let g:airline_powerline_fonts = 1

" Set the theme
let g:airline_theme='simple'

                                 "### FZF ###
set rtp+=/opt/homebrew/opt/fzf

                                 "### Goyo ###

                               "### IMG Paste ###
                               
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'
" autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'

                           "### MarkDown Preview ###

" CSS file for display in the browser
let g:mkdp_markdown_css='~/.vim/CSS/github-markdown.css'

" Set to 1 for all files, otherwise default is only .md files
let g:mkdp_command_for_global = 1

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 1,
    \ 'toc': {}
    \ }

                               "### Vim Markdown ###
" Prevents foldtext from being set
let g:vim_markdown_override_foldtext=0

" Disables default key mappings (test)
let g:vim_markdown_no_default_key_mappings=1

" Set conceal level for markdown
set conceallevel=2
let g:vim_markdown_conceal=0

" Strikethrough
let g:vim_markdown_strikethrough=1

" No shown markdown links
let g:vim_markdown_no_extensions_in_markdown=1
