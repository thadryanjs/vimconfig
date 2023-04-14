" largely based on this:
" https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number
set relativenumber
set relativenumber
set relativenumber
set relativenumber
set relativenumber

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not let cursor scroll below or above N number of lines when scrolling.
"set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Undo config: https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" back up config: https://stackoverflow.com/questions/25318875/how-to-configure-vim-backup-directories
set backup
if !isdirectory($HOME."/.vim/backupdir")
    silent! execute "!mkdir ~/.vim/backupdir"
endif
set backupdir=~/.vim/backupdir

" change the cursor when the mode changes 
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

    " linter - too fancy, will learn to configure/simplify it later
    " Plug 'dense-analysis/ale'
    
    " for the filetree 
    Plug 'preservim/nerdtree'
    Plug 'flazz/vim-colorschemes'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'quarto-dev/quarto-vim'
    Plug 'vim-pandoc/vim-rmarkdown'
"     Plug 'quarto-dev/quarto-nvim'
"     Plug 'neovim/nvim-lspconfig'
"     Plug 'jmbuhr/otter.nvim'


call plug#end()

" }}}

" now we can use the colorscheme color
" colorscheme Atelier_SavannaDark



"MAPPINGS --------------------------------------------------------------- {{{

"inoremap <f8> <Esc>
imap jj <Esc>
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" navigate visual lines not logical ones
nmap j gj
nmap k gk
nmap <Up> gk
nmap <Down> gj
nmap <C-c> "+y
nmap <C-v> "+p


" filetree plugin mappings
nnoremap <leader>n :NERDTree<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" do nothing on ctrl z
nnoremap <c-z> <nop>

" modified from here: https://github.com/jalvesaq/Nvim-R/issues/85
autocmd FileType r inoremap <buffer> <C-p> <Esc>:normal! a%>%<CR>a 
autocmd FileType rnoweb inoremap <buffer> <C-p> <Esc>:normal!a %>%<CR>a 
autocmd FileType rmd inoremap <buffer> <C-p> <Esc>:normal! a%>%<CR>a 
" }}}



" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
"augroup filetype_vim
"    autocmd!
"    autocmd FileType vim setlocal foldmethod=marker
"augroup END

" func! WordProcessorMode()
"     setlocal textwidth=80
"     setlocal smartindent
"     setlocal noexpandtab
"     " spellcheck on
"     setlocal spell spelllang=en_us
"     " remove spellcheck highlighting style
"     hi clear SpellBad
"     " add underline style instead
"     hi SpellBad cterm=underline
"     " do the same for capitalization 
"     hi clear SpellCap
"     hi SpellCap cterm=underline
" endfu

func! WordProcessorMode()
    set textwidth=0
    set wrapmargin=0
    set nonumber
    set wrap
    " Have j and k navigate visual lines rather than logical ones
    nmap j gj
    nmap k gk
    " (optional - breaks by word rather than character)
    set linebreak
    setlocal smartindent
    setlocal noexpandtab
    " spellcheck on
    setlocal spell spelllang=en_us
    " remove spellcheck highlighting style
    hi clear SpellBad
    " add underline style instead
    hi SpellBad cterm=underline
    " do the same for capitalization
    hi clear SpellCap
    hi SpellCap cterm=underline
endfu

" turn on spellcheck without the other stuff (for markdown, etc)
func! Spellcheck()
    " spellcheck on
    setlocal spell spelllang=en_us
    " remove spellcheck highlighting style
    hi clear SpellBad
    " add underline style instead
    hi SpellBad cterm=underline
    " do the same for capitalization
    hi clear SpellCap
    hi SpellCap cterm=underline
endfu    
" }}}

func! WordCount()
    :w !wc
endfu


let g:word_count=wordcount().words
function LiveWordCount()
    if has_key(wordcount(),'visual_words')
        let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
    else
        let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
    endif
    return g:word_count
endfunction

function ToggleWordCount()
    set statusline+=\ w:%{LiveWordCount()},
    set laststatus=2
endfunction

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
"set statusline=

" Status line left side.
"set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
"set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
"set laststatus=2

" a mode for non-code text editing

" }}}



" MACROS  --------------------------------------------------------------- {{{

let @f=':NERDTree␗␗:vert botright term␗␗␗␗␗20>␗␗␗␗:term␗␒␗␗'

" }}}


