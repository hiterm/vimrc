" unite
" default action
call unite#custom#default_action('word', 'append')
" unite in insert mode
inoremap <silent><expr> <C-z>
      \ unite#start_complete('register', { 'input': unite#get_cur_text() })
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
