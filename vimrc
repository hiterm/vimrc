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
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
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

" フォント
set guifont=monaco:h12

" 行番号を表示
set number

" シンタックスハイライト
syntax enable
if has("gui_running")
  colorscheme hybrid
else
  colorscheme jellybeans
endif

" 大文字小文字を区別しない
set ignorecase

" insertモードでEmacs風のカーソル移動
inoremap <C-f> <Right>
inoremap <C-b> <Left>

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
let g:tex_conceal = ''
let g:vimtex_latexmk_options = ''
" viewer
let g:vimtex_view_general_viewer
\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '@line @pdf @tex'

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" 末尾の空白を強調
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END
" 削除する関数
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction
" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" lexima
" tex
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'tex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '{', 'at': '\\\%#', 'input_after': '\}', 'filetype': 'tex'})
call lexima#add_rule({'char': '[', 'at': '\\\%#', 'input_after': '\]', 'filetype': 'tex'})

" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
