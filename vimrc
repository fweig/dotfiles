syntax on
filetype plugin indent on

" --- Enable packages
packadd! onedark
packadd! fzf
" packadd! nerdtree
packadd! fugitive
packadd! ycm

" --- Colorscheme
colorscheme onedark

" --- Modify defaults
set background=dark
set lazyredraw                    " Dont redraw screen during macros
set number                        " Display line numbers
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
set mouse=a                       " Enable mouse support
set autowriteall                  " autosave when leaving the buffer (e.g. call make or use fzf)
set timeoutlen=1000 ttimeoutlen=0 " Wait one second after a mapped key
set wildmenu
set wildmode=longest:full         " show completion matches and complete longest substring
set cinoptions+=:0                " Dont indent case labels in switch-statements.
set cinoptions+=g0                " Dont indent public/private/protected-declarations.
set wildignore=*.o,*.a
set belloff=all                   " Disable all bell sounds
set guioptions=c                  " Use console dialogs instead of popups
set exrc                          " Load .vimrc in current folder

set statusline=%f\ %r%=Ln\ %l,\ Col\ %c " Display filename and position in statusline

" --- Enable true color support outside of TMUX
if (empty($TMUX))
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" --- use ag instead of grep if it exists
if executable('rg')
    set grepprg=rg\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
endif

let mapleader = "\<Space>"

inoremap jk <esc>
nnoremap <cr> :up<cr>

" --- NerdTree setup

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

nnoremap <leader>f :NERDTreeToggle<CR>
" If another buffer tries to replace NERDTree, put it in the other window, and
" bring back NERDTree.
 autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Automatically make NERDTree window unlisted
autocmd FileType nerdtree setlocal bufhidden=wipe nobuflisted

" Skip non-normal buffers when cycling
function! NextNormalWindow()
  let i = 0
  let startWin = winnr()
  while i < winnr('$')
    wincmd w
    if &buftype == '' && &filetype != 'nerdtree'
      break
    endif
    let i += 1
    if i >= winnr('$') || winnr() == startWin
      break
    endif
  endwhile
endfunction

" nnoremap <C-W><C-W> :call NextNormalWindow()<CR>

" --- command shortcuts
nmap <C-p> :Files<cr>

" --- highlight last inserted text
nnoremap gV `[v`]

" --- Show buffer list
nnoremap <Leader><Leader> :ls<cr>:b

" --- Copy and paste shortcuts
vnoremap <C-S-c> "+y
inoremap <C-S-v> <C-r>+
nnoremap <C-S-v> "+p
cnoremap <C-S-v> <C-r>+

" --- quickfix
nnoremap <Leader>c :cc<cr>
nnoremap <Leader>n :cn<cr>
nnoremap <Leader>p :cp<cr>

" --- Run compiler
nnoremap <F5> :make<cr>

" --- Edit / reload vimrc
nnoremap <Leader>ev :tabnew $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" --- YouCompleteMe
let g:ycm_goto_buffer_command = 'vertical-split'

nnoremap gd :YcmCompleter GoToDefinition<cr>
nnoremap gD :YcmCompleter GoToDeclaration<cr>


" --- Trim trailing whitespace
autocmd BufWritePre * let [v,c,l]=[winsaveview(),&cuc,&cul]
                  \ | set cuc cul
                  \ | keeppatterns %s/\s\+$//e
                  \ | let [&cuc,&cul]=[c,l]
                  \ | call winrestview(v)
                  \ | unlet v l c
