" fzf

" The prefix key.
nnoremap [fzf] <Nop>
nmap     <Space>u [fzf]

" fzf.vim keymap
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]r :<C-u>FZFMru<CR>
nnoremap <silent> [fzf]h :<C-u>Help<CR>
nnoremap <silent> [fzf]c :<C-u>Commands<CR>

nnoremap <silent> <Space>/ :<C-u>BLines<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
