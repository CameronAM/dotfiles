
" ~~~~~ Swiped from https://github.com/jeffkreeftmeijer/neovim-sensible/blob/master/plugin/neovim-sensible.vim ~~~~~
" Use "hybrid" (both absolute and relative) line numbers
set number relativenumber

" Use the system clipboard
set clipboard=unnamed

" Use a color column on the 80-character mark
set colorcolumn=80

" Use , as the leader key
let mapleader=","
map <Space> <leader>

" Use ,, to switch between buffers
nnoremap <leader><leader> :b#<CR>

" Press <tab>, get two spaces
set expandtab shiftwidth=2

" Show `▸▸` for tabs: 	, `·` for tailing whitespace: 
set list listchars=tab:▸▸,trail:·

" Enable mouse mode
set mouse=a
" ~~~~~ end swipe ~~~~~

" ### goodness me, split in the correct direction! ###
set splitbelow
set splitright

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

  " Make sure you use single quotes

  " file finding/browsing
  " Plug 'wincent/command-t'
  Plug 'junegunn/fzf.vim'
  " Plug 'tpope/vim-vinegar'
  Plug 'justinmk/vim-dirvish'
  Plug 'octref/RootIgnore'

  " looks
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " themes
  Plug 'joshdick/onedark.vim'
  Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'

  " completion - deoplete
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " completion - CoC
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

  Plug 'Shougo/neco-syntax'  " syntax source for deoplete

  " lang support
  Plug 'sheerun/vim-polyglot'

  " integrate ternjs
  " Plug 'neoclide/tern-neovim' " javascript intelligence
  " Plug 'carlitux/deoplete-ternjs' " make sure tern is installed as well

  Plug 'jiangmiao/auto-pairs' " insert pairs of things
  Plug 'tpope/vim-surround'

  " linting
  Plug 'w0rp/ale'

  " block comment support
  Plug 'tomtom/tcomment_vim'

  " git support
  Plug 'tpope/vim-fugitive'

  " make paste work sensibly (ie. re-indent the pasted chunk)
  Plug 'sickill/vim-pasta'

  " add some shell sugar
  Plug 'tpope/vim-eunuch'

  " add EditorConfig support
  Plug 'editorconfig/editorconfig-vim'

  " Initialize plugin system
call plug#end()

" configure dirvish
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r' " sort with dirs first 

" configure airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" enable completion
" let g:deoplete#enable_at_startup = 1
" use tab to cycle completion options
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" enable completion using tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <enter> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on

" colorscheme onedark
colorscheme nord
" set background=dark

" ensures the command just run is at the end of the cli row
set showcmd

" allow unsaved buffers in the background
set hidden

" ejs files should highlight as html
au BufNewFile,BufRead *.ejs set filetype=html

" reload init.vim on save
" map <leader>vimrc :tabe ~/.vim/.vimrc<cr>
autocmd bufwritepost init.vim source $MYVIMRC

" ##############################
" re-introduce some resharper like bindings
" ##############################
nnoremap <leader>gd <Plug>(coc-definition)

" ##############################
" custom leader maps
" ##############################
" sensible split maps
noremap <leader>- :split <CR>
noremap <leader><Bslash> :vsplit <CR>

" FZF
nnoremap <leader>T :Files <CR>
nnoremap <leader>t :GFiles <CR>
nnoremap <leader>b :Buffers <CR>
nnoremap <leader>a :Ag <CR>

