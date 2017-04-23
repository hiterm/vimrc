" lightline {{{2
set laststatus=2
let g:lightline = {}
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified' ],
      \           [ 'fugitive', 'gitgutter' ] ],
      \ 'right': [ [ 'syntastic', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'myfileencoding', 'filetype' ] ]
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
let g:lightline.colorscheme = 'jellybeans'

let g:lightline.component = {
      \ 'myfileencoding': '%{&fenc!=#""?&fenc:&enc}(%{&ff})',
      \ }

let g:lightline.component_function = {
      \ 'fugitive': 'LightlineFugitive',
      \ 'gitgutter': 'LightlineGitgutter',
      \ }

let g:lightline.component_expand = {
      \ 'syntastic': 'SyntasticStatuslineFlag',
      \ }

let g:lightline.component_type = {
      \   'syntastic': 'error',
      \ }

function! LightlineFugitive()
  if exists('*fugitive#head')
    return fugitive#head()
  endif
  return ''
endfunction

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

" syntastic
let s:syntastic_passive_filetypes = ['c', 'cpp', 'ruby', 'python']
let g:syntastic_mode_map = {
      \ 'passive_filetypes': s:syntastic_passive_filetypes,
      \ }
augroup AutoSyntastic
  autocmd!
  " filetypeが指定したもので、ファイルに書き込みしたとき実行
  autocmd BufWritePost * if count(s:syntastic_passive_filetypes, &filetype)
        \ | call s:syntastic()
        \ | endif
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
