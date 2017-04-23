" lightline {{{2
set laststatus=2
let g:lightline = {}
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified' ],
      \           [ 'fugitive', 'gitgutter' ] ],
      \ 'right': [ [ 'ale_error', 'ale_warning', 'ale_ok', 'lineinfo' ],
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
      \ 'ale_error':   'Lightline_ale_error',
      \ 'ale_warning': 'Lightline_ale_warning',
      \ 'ale_ok':      'Lightline_ale_ok',
      \ }

let g:lightline.component_type = {
      \ 'ale_error':   'error',
      \ 'ale_warning': 'warning',
      \ 'ale_ok':      'ok',
      \ }

function! LightlineFugitive()
  if exists('*fugitive#head')
    return fugitive#head()
  endif
  return ''
endfunction

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

" From delphinus/lightline-delphinus

function! Lightline_ale_error() abort
  return s:ale_string(0)
endfunction

function! Lightline_ale_warning() abort
  return s:ale_string(1)
endfunction

function! Lightline_ale_ok() abort
  return s:ale_string(2)
endfunction

function! s:ale_string(mode)
  if !exists('g:ale_buffer_info')
    return ''
  endif

  let l:buffer = bufnr('%')
  let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

  if a:mode == 0 " Error
    return l:error_count ? printf(l:error_format, l:error_count) : ''
  elseif a:mode == 1 " Warning
    return l:warning_count ? printf(l:warning_format, l:warning_count) : ''
  endif

  return l:error_count == 0 && l:warning_count == 0 ? l:no_errors : ''
endfunction

augroup LightLineALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END
