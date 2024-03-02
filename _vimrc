" Turn syntax highlighting on.
syntax on
" Highlight cursor line underneath the cursor horizontally.
set cursorline
" Set tab width to 4 columns.
set tabstop=4
" Enable auto completion menu after pressing TAB.
set wildmenu
" Show line number and relative number
set number
set relativenumber

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Load an indent file for the detected file type.
filetype indent on

" While searching though a file incrementally highlight matching characters as you type.
set incsearch
" Ignore capital letters during search.
set ignorecase
" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

let mapleader =" "

call plug#begin()
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Donaldttt/fuzzyy'
call plug#end()
let g:enable_fuzzyy_keymaps = 0
let g:files_respect_gitignore = 0
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
nnoremap <silent> <Leader>j <Plug>(easymotion-bd-w)
nnoremap <silent> <Leader>f :FuzzyFiles<CR>
nnoremap <silent> <Leader>b :FuzzyBuffers<CR>
nnoremap <silent> <Leader>g :FuzzyGrep<CR>
