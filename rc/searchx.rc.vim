" Overwrite / and ?.
nnoremap g? <Cmd>call searchx#start({ 'dir': 0 })<CR>
nnoremap g/ <Cmd>call searchx#start({ 'dir': 1 })<CR>
xnoremap g? <Cmd>call searchx#start({ 'dir': 0 })<CR>
xnoremap g/ <Cmd>call searchx#start({ 'dir': 1 })<CR>
cnoremap ; <Cmd>call searchx#select()<CR>

" Move to next/prev match.
nnoremap N <Cmd>call searchx#prev_dir()<CR>
nnoremap n <Cmd>call searchx#next_dir()<CR>
xnoremap N <Cmd>call searchx#prev_dir()<CR>
xnoremap n <Cmd>call searchx#next_dir()<CR>

let g:searchx = {}

" Auto jump if the recent input matches to any marker.
let g:searchx.auto_accept = v:true

" The scrolloff value for moving to next/prev.
let g:searchx.scrolloff = &scrolloff

" To enable scrolling animation.
let g:searchx.scrolltime = 100

" Marker characters.
let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

" Convert search pattern.
function g:searchx.convert(input) abort
  let s:pattern = system(['cmigemo', '-d', '/usr/share/migemo/utf-8/migemo-dict', '-v', '-w', a:input])
  echomsg s:pattern
  return s:pattern
endfunction
