if has('vim_starting')
  set nocompatible

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let Neobundle manage Neobundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'lervag/vimtex'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tomtom/tcomment_vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ここまでNeoBundleの設定
" ここから普通の設定

" 行番号を表示
set number

" シンタックスハイライト
syntax enable

" 大文字小文字を区別しない
set ignorecase

" indentLine
let g:indentLine_char = '¦'
:set list lcs=tab:\|\ 

" インデントの深さ
set tabstop=4
set softtabstop=4
set shiftwidth=4
" ソフトタブ
set expandtab

" MetaキーをOptionキーに
set macmeta

" クリップボードを共有
set clipboard+=unnamed

" unite.vimの設定
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    ,u [unite]

" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]e :<C-u>Unite<Space>register<CR>
nnoremap <silent> ,vr :UniteResume<CR>

" NERD Tree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" airline
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''

" vimtex
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'Skim'
let g:tex_conceal = ''

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
