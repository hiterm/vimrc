" denite

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
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> <Tab>
        \ denite#do_map('choose_action')
endfunction

" The prefix key.
nnoremap [denite] <Nop>
nmap     <Space>u      [denite]

" denite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [denite]u          :<C-u>Denite<Space>
nnoremap [denite]<Space>    :<C-u>Denite<Space>
nnoremap <silent> [denite]f :<C-u>Denite<Space>file<Space>file:new<CR>
nnoremap <silent> [denite]b :<C-u>Denite<Space>buffer -auto-action=preview<CR>
nnoremap <silent> [denite]o :<C-u>Denite<Space>dirmark<CR>
nnoremap <silent> [denite]r :<C-u>Denite<Space>file_mru -auto-action=preview<CR>
nnoremap <silent> [denite]e :<C-u>Denite<Space>register<CR>
nnoremap <silent> [denite]y :<C-u>Denite<Space>neoyank<CR>
nnoremap <silent> [denite]h :<C-u>Denite<Space>help<CR>
nnoremap <silent> [denite]g :<C-u>Denite<Space>grep -auto-action=preview<CR>
nnoremap <silent> [denite]c :<C-u>Denite<Space>command<CR>
nnoremap <silent> [denite]d :<C-u>Denite<Space>contextMenu<CR>
" nnoremap <silent> ,vr :Denite -resume<CR>
nnoremap <silent> <Space>/ :<C-u>Denite<Space>line<CR>
