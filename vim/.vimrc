" True colour support
if (has("termguicolors"))
  set termguicolors
endif

" Plug Plugin Manager
call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-pathogen'

  " IDE
  Plug 'terryma/vim-multiple-cursors'
  Plug 'Yggdroot/indentLine'
  Plug 'kien/ctrlp.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'bronson/vim-crosshairs'
  Plug 'pablopunk/native-sidebar.vim'
  Plug 'wincent/terminus'
  Plug 'tpope/vim-surround'
  Plug 'ericbn/vim-relativize'
  Plug 'godlygeek/tabular'
  
  " UI
  Plug 'itchyny/lightline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'majutsushi/tagbar'

  " VCS
  Plug 'editorconfig/editorconfig-vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " Themes
  Plug 'connorholyday/vim-snazzy'

  " Language Support
  Plug 'rodjek/vim-puppet'
  Plug 'shmargum/vim-sass-colors'
  Plug 'tobyS/pdv'
  Plug '2072/PHP-Indenting-for-VIm'
  Plug 'hashivim/vim-terraform'
  Plug 'vim-syntastic/syntastic'

  " Other
  Plug 'freitass/todo.txt-vim'

" Initialize plugin system
call plug#end()

" UI Setup
colorscheme snazzy
"set t_Co=256
"set background=dark
set relativenumber
syntax enable
set number
set syntax=whitespace
set redrawtime=10000

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_phpmd_args = "~/.config/composer/vendor/designamite/src/ruleset-2.8.xml"

" Rulers
highlight ColorColumn ctermbg=1 guibg=#0a0a0a
let &colorcolumn="80,120"

" Transparent Background
"highlight Normal guibg=NONE ctermbg=NONE

" Environment
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set noeol
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list
set lcs+=space:·
set runtimepath^=~/.vim/bundle/ctrlp.vim
set cursorline
set cursorcolumn
set autoindent

" Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 40

" Sidebar
let g:native_sidebar_shortcut = '<c-t>'

" Emmet
let g:user_emmet_leader_key=','

" CTRL P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|web/node_modules\|modules'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='lucius'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

" Spaces to tabs
function! Tabre()
  let &l:tabstop=2
  let &l:shiftwidth=2
  set noexpandtab
  retab!
endfunction

command! Tabre call Tabre()
