" telescope

" oldfiles
set viminfo+='10000
set viminfo-='100

" The prefix key.
nnoremap [telescope] <Nop>
nmap     <Space>u [telescope]

" telescope.nvim keymap
nnoremap <silent> [telescope]f <cmd>Telescope find_files<cr>
nnoremap <silent> [telescope]b <cmd>Telescope buffers<cr>
nnoremap <silent> [telescope]r <cmd>Telescope oldfiles<cr>
nnoremap <silent> [telescope]h <cmd>Telescope help_tags<cr>
nnoremap <silent> [telescope]c <cmd>Telescope commands<cr>
nnoremap <silent> [telescope]g <cmd>Telescope live_grep<cr>

nnoremap <silent> <Space>/ :<C-u>BLines<CR>

function! Ripgreptelescope(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call telescope#vim#grep(initial_command, 1, telescope#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call Ripgreptelescope(<q-args>, <bang>0)
