syntax on
filetype plugin indent on

colorscheme default

set background=dark
set lazyredraw                    " Dont redraw screen during macros
set tabstop=4                     " Number of spaces for a tab in a file
set shiftwidth=4                  " Number of spaces per indent step
set softtabstop=4                 " Number of spaces when inserting <Tab>
set expandtab                     " Expand tabs to spaces
set scrolloff=10                  " Number of lines to keep above / under cursor
set smartindent                   " Auto indent on new lines
set ignorecase                    " Ignore case for search
set smartcase                     " Allow explicit search for upper case characters
set textwidth=79                  " Insert automatic linebreaks
set cursorline                    " Highlight current cursorline
set formatoptions=qrn1
set splitbelow                    " Open new vert splits below
set splitright                    " Open new horiz splits right
set laststatus=2                  " Always display status line
set incsearch                     " Jump to search result   
set nohlsearch                    " Dont highlight search result
set mouse=                        " no mouse
set autowrite                     " save when using make
set timeoutlen=1000 ttimeoutlen=0 " Wait one second after a mapped key
set wildmenu
set wildmode=longest:full         " show completion matches and complete longest substring
set cinoptions+=:0                " Dont indent case labels in switch-statements.
set cinoptions+=g0                " Dont indent public/private/protected-declarations.
set wildignore=*.o,*.a 

set statusline=%f\ %r%=Ln\ %l,\ Col\ %c " Display filename and position in statusline

" use ag instead of grep if it exists
if executable('rg')
    set grepprg=rg\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
endif

if has('nvim')
    " neovim terminal stuff
    tnoremap <Esc> <C-\><C-n>
endif

let mapleader = "\<Space>"

inoremap jk <esc>
nnoremap <cr> :up<cr>

" highlight last inserted text
nnoremap gV `[v`]

" Show buffer list
nnoremap <Leader><Leader> :ls<cr>:b 

"quickfix
nnoremap <Leader>c :cc<cr>
nnoremap <Leader>n :cn<cr>
nnoremap <Leader>p :cp<cr>

"Edit / reload vimrc
nnoremap <Leader>ev :tabnew $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
