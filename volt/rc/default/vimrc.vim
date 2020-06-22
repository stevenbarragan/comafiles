set termguicolors
set encoding=UTF-8

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax enable

let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" ================ General Config ====================

set relativenumber
set number
set lazyredraw          " redraw only when we need to."
set showmatch           " highlight matching [{()}]}]"
set noshowmode
set nowrap

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

let mapleader=","

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

set foldenable          " enable folding"

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" Create window splits easier
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" https://github.com/junegunn/vim-easy-align#quick-start-guide
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <leader>e :call FzyCommand("ag . --silent -l -g ''", ":e")<cr>
nnoremap <leader>v :call FzyCommand("ag . --silent -l -g ''", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("ag . --silent -l -g ''", ":sp")<cr>

set timeoutlen=1000 ttimeoutlen=0  " Eliminating delays on ESC

" autocmd vimenter * NERDTree

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

let NERDTreeQuitOnOpen=1
nmap <leader>f :NERDTreeFind<cr>

" shortcut for far.vim find
nnoremap <silent> <Find-Shortcut>  :Farf<cr>
vnoremap <silent> <Find-Shortcut>  :Farf<cr>

" shortcut for far.vim replace
nnoremap <silent> <Replace-Shortcut>  :Farr<cr>
vnoremap <silent> <Replace-Shortcut>  :Farr<cr>

" set foldmethod=expr
"   \ foldexpr=lsp#ui#vim#folding#foldexpr()

" let g:lsp_diagnostics_echo_cursor = 1

" nnoremap <silent> ,<space> :LspDefinition<CR>
" nnoremap <silent> L :LspDefinition<CR>
" nnoremap <silent> K :LspHover<CR>

let g:lsp_diagnostics_echo_cursor = 1
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_tsserver_autoimport = 1

nnoremap <silent> ,<space> :ALEGoToDefinition<CR>
nnoremap <silent> L :ALEGoToDefinition<CR>
nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> H :ALEFindReferences<CR>
