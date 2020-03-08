" denite

" Define mappings
augroup MyDenite
  autocmd!
  autocmd FileType denite call s:denite_my_settings()
augroup END
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> s
        \ denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> *
        \ denite#do_map('toggle_select_all')
  nnoremap <silent><buffer><expr> <Tab>
        \ denite#do_map('choose_action')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  imap <silent><buffer> <Esc> <C-R>=lexima#insmode#escape()<CR><Plug>(denite_filter_quit)q
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  inoremap <buffer> <C-e> <END>
  inoremap <buffer> <C-a> <HOME>
  inoremap <silent><buffer> <C-n> <Esc>:call MoveToDeniteWindow()<CR>j:call MoveToDeniteFilterWindow()<CR>i
  inoremap <silent><buffer> <C-p> <Esc>:call MoveToDeniteWindow()<CR>k:call MoveToDeniteFilterWindow()<CR>i
endfunction

function! MoveToDeniteWindow()
  let l:bnr = bufnr('[denite]-default')
  let l:wnr = win_findbuf(l:bnr)[0]
  call win_gotoid(l:wnr)
endfunction

function! MoveToDeniteFilterWindow()
  let l:bnr = bufnr('denite-filter')
  let l:wnr = win_findbuf(l:bnr)[0]
  call win_gotoid(l:wnr)
endfunction

" The prefix key.
nnoremap [denite] <Nop>
nmap     <Space>u [denite]

" denite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [denite]u          :<C-u>Denite
nnoremap [denite]<Space>    :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]f :<C-u>Denite file file:new<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer -auto-action=preview<CR>
nnoremap <silent> [denite]o :<C-u>Denite dirmark<CR>
nnoremap <silent> [denite]r :<C-u>Denite file_mru -floating-preview<CR>
nnoremap <silent> [denite]e :<C-u>Denite register<CR>
nnoremap <silent> [denite]y :<C-u>Denite neoyank<CR>
nnoremap <silent> [denite]h :<C-u>Denite help<CR>
nnoremap <silent> [denite]g :<C-u>Denite grep -auto-action=preview<CR>
nnoremap <silent> [denite]c :<C-u>Denite command<CR>
nnoremap <silent> [denite]d :<C-u>Denite contextMenu<CR>
nnoremap <silent> [denite]q :<C-u>Denite quickfix<CR>
nnoremap <silent> <Space>/ :<C-u>Denite line<CR>
