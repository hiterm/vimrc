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
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'altercation/vim-colors-solarized'

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
set clipboard=unnamed
