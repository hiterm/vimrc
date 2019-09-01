" My vimrc

scriptencoding utf-8

" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" Required:
execute 'set runtimepath+=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)  " 失敗したら
  call dein#begin(s:dein_dir)

  call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/dein_lazy.toml', {'lazy': 1})
  call dein#load_toml('~/.vim/dein_completion.toml', {'lazy': 0})

  " Required:
  call dein#end()
  call dein#save_state()
endif

let g:dein#enable_notification = 1
let g:dein#install_log_filename = s:dein_dir . '/dein.log'

" Required:
filetype plugin indent on
syntax enable

" End dein Scripts-------------------------

" 基本設定 {{{1
augroup MyAutoCmd
  autocmd!
augroup END

let g:mapleader = ','
let g:maplocalleader = ' '

" フォント
if has('mac')
  set guifont=monaco:h13
  set guifontwide=Migu\ 1M:h13
elseif has('unix')
  set guifont=Source\ Code\ Pro\ 12
  set guifontwide=Migu\ 1M\ 12
endif

" 全角文字の幅
set ambiwidth=double

" 行番号を表示
set number

" コマンドラインを便利に
set wildmenu

" 現在行をハイライト
set cursorline

" colorscheme
set termguicolors
call dein#source(['nord-vim'])
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1
colorscheme nord
let g:lightline.colorscheme = 'nord'

" 大文字小文字を区別しない
set ignorecase
set smartcase

" 検索結果をハイライト
set hlsearch

" ビープ音をvisualbellに
set visualbell

" マウス
set mouse=a

" current directoryを自動移動
augroup MyAutoCmd
  autocmd BufEnter * silent! lcd %:p:h
augroup END

" insertモードでEmacs風のカーソル移動
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" indentLine
let g:indentLine_char = '¦'
:set list lcs=tab:\|\ 

" インデントの深さ
set tabstop=2
set softtabstop=2
set shiftwidth=2
" ソフトタブ
set expandtab

if has('nvim')
  set inccommand=split
endif

augroup MyAutoCmd
  autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" MetaキーをOptionキーに
if has('gui_macvim')
  set macmeta
endif

" いらないキーを無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" jkで表示上の行を動くように
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" spell check
set spelllang=en,cjk

" migemo
if executable('cmigemo')
  nnoremap g/ :Migemo<CR>
endif

" Linux fcitx IME制御
if has('unix') && !(has('mac'))
  if has('gui_running')
    set iminsert=0
    set imsearch=0
    set imactivatefunc=ImActivate
    function! ImActivate(active)
      if a:active
        call system('fcitx-remote -o')
      else
        call system('fcitx-remote -c')
      endif
    endfunction
    set imstatusfunc=ImStatus
    function! ImStatus()
      return system('fcitx-remote')[0] is# '2'
    endfunction
  else
    function! ImInActivate ()
      call system('fcitx-remote -c')
    endfunction
    augroup MyAutoCmd
      autocmd InsertLeave * call ImInActivate()
      autocmd CmdwinLeave * call ImInActivate()
    augroup END
  endif
endif

" ctags
set tags+=./tags;

" 保存しなくてもバッファ間の移動ができるように
set hidden

" helpをqで閉じる
autocmd MyAutoCmd FileType help nnoremap <buffer> q <C-w>c

" plugin, filetypeの設定 {{{1

" denite {{{2
if dein#tap('denite.nvim')
  call denite#custom#option('default', {
        \ 'prompt': '>',
        \ 'split': 'floating',
        \ })

	" Define mappings
	autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
	  nnoremap <silent><buffer><expr> <CR>
	  \ denite#do_map('do_action')
	  nnoremap <silent><buffer><expr> d
	  \ denite#do_map('do_action', 'delete')
	  nnoremap <silent><buffer><expr> p
	  \ denite#do_map('do_action', 'preview')
	  nnoremap <silent><buffer><expr> q
	  \ denite#do_map('quit')
	  nnoremap <silent><buffer><expr> i
	  \ denite#do_map('open_filter_buffer')
	  nnoremap <silent><buffer><expr> <Space>
	  \ denite#do_map('toggle_select').'j'
	endfunction

  " The prefix key.
  nnoremap [denite] <Nop>
  nmap     <Space>u      [denite]

  " denite.vim keymap
  " https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
  nnoremap [denite]u          :<C-u>Denite<Space>
  nnoremap [denite]<Space>    :<C-u>Denite<Space>
  nnoremap <silent> [denite]f :<C-u>Denite<Space>file<Space>file:new<CR>
  nnoremap <silent> [denite]b :<C-u>Denite<Space>buffer<CR>
  nnoremap <silent> [denite]o :<C-u>Denite<Space>unite:bookmark<CR>
  nnoremap <silent> [denite]r :<C-u>Denite<Space>file_mru<CR>
  nnoremap <silent> [denite]e :<C-u>Denite<Space>register<CR>
  nnoremap <silent> [denite]y :<C-u>Denite<Space>neoyank<CR>
  nnoremap <silent> [denite]l :<C-u>Denite<Space>line<CR>
  nnoremap <silent> [denite]h :<C-u>Denite<Space>help<CR>
  nnoremap <silent> ,vr :Denite -resume<CR>
endif


" vimtex and latex {{{2
let g:tex_flavor='latex'
let g:tex_conceal = ''
let g:vimtex_imaps_enabled = 0
" latexmk
let g:vimtex_compiler_latexmk_engines = {
      \ '_'                : '-pdfdvi',
      \ 'uplatex'          : '-pdfdvi',
      \ 'pdflatex'         : '-pdf',
      \ 'lualatex'         : '-lualatex',
      \ 'xelatex'          : '-xelatex',
      \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
      \ 'context (luatex)' : '-pdf -pdflatex=context',
      \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
      \}
" viewer
if has('mac')
  let g:vimtex_view_method='skim'
else
  let g:vimtex_view_method='zathura'
endif
if has('nvim')
  let g:vimtex_compiler_progname
        \ = 'nvr'
endif
augroup MyAutoCmd
  autocmd FileType tex syntax spell toplevel
augroup END
" template commands
command! TeXTemplateLuaTeX 0r ~/.vim/template/luatex.tex
command! TeXTemplateUpLaTeX 0r ~/.vim/template/uplatex.tex
" load template
augroup MyAutoCmd
  autocmd BufNewFile *.tex 0r ~/.vim/template/uplatex.tex
augroup END
" 句読点の設定
augroup MyAutoCmd
  autocmd FileType tex imap <buffer> 、 ，
  autocmd FileType tex imap <buffer> 。 ．
augroup END

" neosnippet {{{2
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

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

" snippets directory
let g:neosnippet#snippets_directory = '~/.vim/snippets'


" lilypond {{{2
augroup MyAutoCmd
  autocmd FileType lilypond setlocal tabstop=2 shiftwidth=2
augroup END
if has('mac')
  augroup MyAutoCmd
    autocmd FileType lilypond
          \ nmap <buffer> <LocalLeader>lv :!FILE="%" && open "${FILE\%.*}.pdf"<CR><CR>
  augroup END
endif


" easymotion {{{2
map <Leader> <Plug>(easymotion-prefix)
if executable('cmigemo')
  let g:EasyMotion_use_migemo = 1
endif
" keep cursor colum JK motion
let g:EasyMotion_startofline = 0
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
xmap s <Plug>(easymotion-bd-f2)
omap s <Plug>(easymotion-bd-f2)
" Extend search motions with vital-over command line interface
" " `<Tab>` & `<S-Tab>` to scroll up/down a page of next match
" " :h easymotion-command-line
nmap ,/ <Plug>(easymotion-sn)
xmap ,/ <Plug>(easymotion-sn)
omap ,/ <Plug>(easymotion-tn)
" overwrite f, F
nmap f <Plug>(easymotion-fl)
xmap f <Plug>(easymotion-fl)
omap f <Plug>(easymotion-fl)
nmap F <Plug>(easymotion-Fl)
xmap F <Plug>(easymotion-Fl)
omap F <Plug>(easymotion-Fl)
nmap t <Plug>(easymotion-tl)
xmap t <Plug>(easymotion-tl)
omap t <Plug>(easymotion-tl)
nmap T <Plug>(easymotion-Tl)
xmap T <Plug>(easymotion-Tl)
omap T <Plug>(easymotion-Tl)

" surround.vim {{{2
" $でも効くように
nnoremap ds$ f$x<Esc>F$x<Esc>

" git {{{2
augroup MyAutoCmd
  autocmd FileType gitcommit setlocal spell
augroup END

" shiba {{{2
if executable('shiba')
  command! ShibaPreview !shiba --detach %
endif
