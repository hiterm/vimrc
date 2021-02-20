" lightline
set laststatus=2
if !exists('g:lightline')
  let g:lightline = {}
endif
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified' ],
      \           [ 'gitgutter' ] ],
      \ 'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'myfileencoding', 'filetype' ],
      \   ]
      \ }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ]
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'close' ] ]
      \ }

let g:lightline.component = {
      \ 'myfileencoding': '%{&fenc!=#""?&fenc:&enc}(%{&ff})',
      \ }

let g:lightline.component_function = {
      \ 'gitgutter': 'LightlineGitgutter',
      \ }

" GitGutter
" From http://qiita.com/yuyuchu3333/items/20a0acfe7e0d0e167ccc
function! LightlineGitgutter()
  if !exists('*GitGutterGetHunkSummary')
        \ || !get(g:, 'gitgutter_enabled', 0)
        \ || winwidth(0) <= 100
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed,
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in range(3)
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction
