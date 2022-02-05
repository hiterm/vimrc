" telescope

" oldfiles
set viminfo+='10000
set viminfo-='100

" The prefix key.
nnoremap [telescope] <Nop>
nmap     <Space>u [telescope]

" telescope.nvim keymap
nnoremap <silent> [telescope]u <cmd>Telescope builtin<cr>
nnoremap <silent> [telescope]f <cmd>Telescope find_files<cr>
nnoremap <silent> [telescope]b <cmd>Telescope buffers<cr>
nnoremap <silent> [telescope]r <cmd>Telescope oldfiles<cr>
nnoremap <silent> [telescope]h <cmd>Telescope help_tags<cr>
nnoremap <silent> [telescope]c <cmd>Telescope commands<cr>
nnoremap <silent> [telescope]g <cmd>Telescope live_grep<cr>
nnoremap <silent> [telescope]l <cmd>Telescope current_buffer_fuzzy_find<cr>

lua << EOF
require('telescope').load_extension('fzf')
EOF
