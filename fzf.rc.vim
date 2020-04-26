" fzf

" The prefix key.
nnoremap [fzf] <Nop>
nmap     <Space>u [fzf]

" fzf.vim keymap
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]r :<C-u>History<CR>
nnoremap <silent> [fzf]h :<C-u>Help<CR>
nnoremap <silent> [fzf]c :<C-u>Commands<CR>

nnoremap <silent> <Space>/ :<C-u>Lines<CR>
