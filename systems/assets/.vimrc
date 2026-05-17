" --- True colour for modern terminals ---
if has('termguicolors')
    set termguicolors
endif

" --- Plugins ---
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
call plug#end()

let mapleader = " "

" --- Editing ---
set cursorline
set expandtab shiftwidth=4 tabstop=4
set ignorecase smartcase
set list listchars=tab:»∙,trail:∙,extends:»,precedes:«,nbsp:∙
set noerrorbells novisualbell
set nowrap
set number
set scrolloff=5 sidescrolloff=10
set splitbelow splitright

" --- Files & history ---
set directory=~/.vim/swap
set undodir=~/.vim/undo/
set undofile undolevels=1000 undoreload=10000
set path+=**

" --- Netrw (still useful for :Explore even alongside fern) ---
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
if exists('*netrw_gitignore#Hide')
    let g:netrw_list_hide = netrw_gitignore#Hide()
    let g:netrw_list_hide .= ',\(^\|\s\s\)\zs\.\S\+'
endif

" --- fern.vim ---
" Hijack netrw so :Explore (and opening a directory) uses fern
let g:fern#default_hidden = 1                " show dotfiles by default
let g:fern#disable_default_mappings = 0
let g:fern#drawer_width = 35

" Replace netrw with fern when opening directories
let g:fern#disable_drawer_auto_quit = 0

" Custom keymaps inside fern buffers
function! s:fern_settings() abort
    nmap <silent><buffer> <CR>     <Plug>(fern-action-open-or-expand)
    nmap <silent><buffer> o        <Plug>(fern-action-open-or-expand)
    nmap <silent><buffer> s        <Plug>(fern-action-open:split)
    nmap <silent><buffer> v        <Plug>(fern-action-open:vsplit)
    nmap <silent><buffer> t        <Plug>(fern-action-open:tabedit)
    nmap <silent><buffer> N        <Plug>(fern-action-new-file)
    nmap <silent><buffer> K        <Plug>(fern-action-new-dir)
    nmap <silent><buffer> d        <Plug>(fern-action-remove)
    nmap <silent><buffer> r        <Plug>(fern-action-rename)
    nmap <silent><buffer> m        <Plug>(fern-action-move)
    nmap <silent><buffer> y        <Plug>(fern-action-yank)
    nmap <silent><buffer> R        <Plug>(fern-action-reload)
    nmap <silent><buffer> H        <Plug>(fern-action-hidden-toggle)
    nmap <silent><buffer> q        :<C-u>quit<CR>
endfunction

augroup fern_custom
    autocmd!
    autocmd FileType fern call s:fern_settings()
augroup END

" --- Colour scheme ---
set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_enable_italic = 1
colorscheme gruvbox-material

" --- Force pure black background ---
" Overrides gruvbox-material's dark-grey bg with #000000 across all UI groups.
" Re-applies on any :colorscheme change so it survives theme reloads.
function! s:pure_black_bg() abort
    highlight Normal       guibg=#000000 ctermbg=black
    highlight NonText      guibg=#000000 ctermbg=black
    highlight EndOfBuffer  guibg=#000000 ctermbg=black
    highlight LineNr       guibg=#000000 ctermbg=black
    highlight CursorLineNr guibg=#000000 ctermbg=black
    highlight SignColumn   guibg=#000000 ctermbg=black
    highlight VertSplit    guibg=#000000 ctermbg=black
    highlight Folded       guibg=#000000 ctermbg=black
    highlight FoldColumn   guibg=#000000 ctermbg=black
endfunction

augroup pure_black_bg
    autocmd!
    autocmd ColorScheme * call s:pure_black_bg()
augroup END

call s:pure_black_bg()

" --- lightline ---
let g:lightline = { 'colorscheme': 'powerline' }

" --- gitgutter ---
set updatetime=250                      " gitgutter recommends <=250ms for responsiveness
let g:gitgutter_map_keys = 0            " don't claim default mappings; bind explicitly below
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)

" --- Leader mappings ---
" File-tree drawer (NERDTree replacement)
nnoremap <silent> <leader>` :Fern . -drawer -toggle -reveal=%<CR>

" fzf
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>

" Project-wide search (ripgrep via fzf.vim) — replaces ack.vim
nnoremap <leader>a :Rg<Space>

" Clear search highlight
nnoremap <silent> <leader><Esc> :nohlsearch<CR>
