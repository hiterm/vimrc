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
  call dein#begin(s:dein_dir,
        \ [expand('<sfile>:p')] + split(glob('~/.vim/*.rc.vim'))
        \ + split(glob('~/.vim/*.toml'), '\n'))

  call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/deinlazy.toml', {'lazy': 1})

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

" colorscheme
call dein#source(['jellybeans.vim'])
colorscheme jellybeans

" 大文字小文字を区別しない
set ignorecase
set smartcase

" 検索結果をハイライト
set hlsearch

" ビープ音をvisualbellに
set visualbell

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
" ソフトタブ
set expandtab

augroup MyAutoCmd
  autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType tex setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType eruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType haml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
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

" unite {{{2
" The prefix key.
nnoremap [unite] <Nop>
nmap     <Space>u      [unite]

" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite<Space>
nnoremap [unite]<Space> :<C-u>Unite<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<Space>file/new<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]e :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]y :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> ,vr :UniteResume<CR>
nnoremap <silent> [unite]l :<C-u>Unite<Space>location_list<CR>


" vimtex and latex {{{2
let g:tex_flavor='latex'
let g:tex_conceal = ''
let g:vimtex_imaps_enabled = 0
" latexmk
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}
" viewer
if has('mac')
  let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '@line @pdf @tex'
else
  let g:vimtex_view_method='zathura'
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


" omni completion{{{2
" Enable omni completion.
set omnifunc=syntaxcomplete#Complete
augroup MyAutoCmd
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END


" neocomplete {{{2
if dein#tap('neocomplete')
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.tex =
        \ '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'
  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

  " neco-lookを全てのfiletypeで有効に
  let g:neocomplete#text_mode_filetypes = { '_' : 1 }
endif


" neocomplcache {{{2
if dein#tap('neocomplcache')
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Enable heavy features.
  " Use camel case completion.
  "let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  "let g:neocomplcache_enable_underbar_completion = 1

  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplcache_enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplcache_enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplcache_enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif


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
