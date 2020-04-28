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
      \     [ 'lc_error', 'lc_warning' ],
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

let g:lightline.component_expand = {
      \ 'ale_error':   'Lightline_ale_error',
      \ 'ale_warning': 'Lightline_ale_warning',
      \ 'ale_ok':      'Lightline_ale_ok',
      \ 'lc_error': 'LC_error_count',
      \ 'lc_warning': 'LC_warning_count',
      \ }

let g:lightline.component_type = {
      \ 'ale_error':   'error',
      \ 'ale_warning': 'warning',
      \ 'ale_ok':      'ok',
      \ 'lc_error':    'error',
      \ 'lc_warning':    'warning',
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

" LanguageClient
" From https://github.com/autozimu/LanguageClient-neovim/issues/374
function! LC_warning_count()
  let current_buf_number = bufnr('%')
  let qflist = getqflist()
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'W'})
  let count = len(current_buf_diagnostics)
  return count > 0 && g:LanguageClient_loaded ? nr2char('0xf071') . count : ''
endfunction

function! LC_error_count()
  let current_buf_number = bufnr('%')
  let qflist = getqflist()
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'E'})
  let count = len(current_buf_diagnostics)
  return count > 0 && g:LanguageClient_loaded ? nr2char('0xf057') . count : ''
endfunction

function! LightLineLC()
endfunction

augroup MyLightLineLC
  autocmd!
  autocmd User LanguageClientDiagnosticsChanged call lightline#update()
augroup END
