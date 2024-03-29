" My vimrc

scriptencoding utf-8

" dein{{{1
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
  call dein#load_toml('~/.vim/dein_lsp.toml', {'lazy': 0})

  " Required:
  call dein#end()
  call dein#save_state()
endif

let g:dein#enable_notification = 1
let g:dein#install_log_filename = s:dein_dir . '/dein.log'

" Required:
filetype plugin indent on
syntax enable

" Note: In Vim initializing, you must call the
" "hook_post_source" hooks manually in |VimEnter| if needed.
autocmd VimEnter * call dein#call_hook('post_source')

" End dein Scripts-------------------------
" }}}

" Load settings for each location.{{{
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END
function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" 基本設定 {{{1
augroup MyAutoCmd
  autocmd!
augroup END

let g:mapleader = ' '
" let g:maplocalleader = ' '

" フォント
if has('mac')
  set guifont=monaco:h13
  set guifontwide=Migu\ 1M:h13
elseif has('unix')
  set guifont=Source\ Code\ Pro\ 12
  set guifontwide=Migu\ 1M\ 12
endif

" 全角文字の幅
set ambiwidth=single

" 行番号を表示
set number

" コマンドラインを便利に
set wildmenu

" 現在行をハイライト
set cursorline

" color
set termguicolors

" 大文字小文字を区別しない
set ignorecase
set smartcase

" search
set hlsearch
set incsearch

" ビープ音をvisualbellに
set visualbell

" マウス
set mouse=a

set signcolumn=auto:9

set laststatus=3

" insertモードでEmacs風のカーソル移動
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" インデントの深さ
set tabstop=2
set softtabstop=2
set shiftwidth=2
" ソフトタブ
set expandtab
" ファイルタイプごとのインデント深さ
augroup MyAutoCmd
  autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType go setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType neosnippet setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType css setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType lua setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
augroup END
" インデント深さ変更コマンド
function! ChangeIndent(n)
  execute 'setlocal tabstop=' . a:n . ' softtabstop=' . a:n . ' shiftwidth=' . a:n
  IndentGuidesEnable
endfunction
command! -nargs=1 ChangeIndent call ChangeIndent(<f-args>)

" vim scriptの中のluaのシンタックスハイライトを有効化する
let g:vimsyn_embed = 'l'

if has('nvim')
  set inccommand=split
endif

" json
augroup MyAutoCmd
  autocmd FileType json setlocal conceallevel=0
augroup END

" json
augroup MyAutoCmd
  autocmd FileType markdown setlocal conceallevel=0
augroup END

" MetaキーをOptionキーに
if has('gui_macvim')
  set macmeta
endif

" いらないキーを無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" spell check
set spelllang=en,cjk
augroup MyAutoCmd
  autocmd FileType text setlocal spell
  autocmd FileType markdown setlocal spell
augroup END

" ripgrep
if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif

" Linux fcitx IME制御
if has('unix') && !(has('mac'))
  if has('gui_running')
    set iminsert=0
    set imsearch=0
    set imactivatefunc=ImActivate
    function! ImActivate(active)
      if a:active
        call system('fcitx5-remote -o')
      else
        call system('fcitx5-remote -c')
      endif
    endfunction
    set imstatusfunc=ImStatus
    function! ImStatus()
      return system('fcitx5-remote')[0] is# '2'
    endfunction
  else
    function! ImInActivate ()
      call system('fcitx5-remote -c')
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

" fold
set foldmethod=marker

" cd to current file
command! Cd lcd %:p:h
" cd to git root
function! s:git_root_dir()
    if(system('git rev-parse --is-inside-work-tree') == "true\n")
        return system('git rev-parse --show-toplevel')
    else
        echoerr '!!!This file is outside of git working tree!!!'
    endif
endfunction
function! s:cd_git_root()
  lcd %:p:h

  execute 'lcd ' . s:git_root_dir()
  pwd
endfunction
command! Gcd call s:cd_git_root()

" buffer移動
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

" Python
let g:python3_host_prog = '/usr/bin/python'

" 前にカーソルがあった場所を開く
augroup ReopenGroup
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

set scrolloff=3

" スペースなどを可視化
set list
set listchars=tab:‒‒►,trail:~

if has('wsl')
  let g:clipboard = {
    \   'name': 'myClipboard',
    \   'copy': {
    \      '+': 'win32yank.exe -i',
    \      '*': 'win32yank.exe -i',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o',
    \      '*': 'win32yank.exe -o',
    \   },
    \   'cache_enabled': 1,
    \ }
endif


" plugin, filetypeの設定 {{{1

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

" git {{{2
augroup MyAutoCmd
  autocmd FileType gitcommit setlocal spell
augroup END

" processing
augroup MyAutoCmd
  autocmd BufNewFile,BufRead *.pde set ft=processing
augroup END

" jsx, tsx {{{2
autocmd BufNewFile,BufRead *.jsx set ft=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set ft=typescript.tsx
