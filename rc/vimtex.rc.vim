augroup MyVimTeXAutoCmd
  autocmd!
augroup END

let g:tex_flavor='latex'
let g:tex_conceal = ''
let g:vimtex_imaps_enabled = 0
" latexmk
let g:vimtex_compiler_latexmk_engines = {
      \ '_'                : '-pdfdvi',
      \ 'uplatex'          : '-pdfdvi',
      \ 'pdflatex'         : '-pdf',
      \ 'lualatex'         : '-lualatex',
      \ 'xelatex'          : '-xelatex',
      \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
      \ 'context (luatex)' : '-pdf -pdflatex=context',
      \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
      \}
" viewer
if has('mac')
  let g:vimtex_view_method='skim'
else
  let g:vimtex_view_method='zathura'
endif
if has('nvim')
  let g:vimtex_compiler_progname
        \ = 'nvr'
endif
augroup MyVimTeXAutoCmd
  autocmd FileType tex syntax spell toplevel
augroup END
" template commands
command! TeXTemplateLuaTeX 0r ~/.vim/template/luatex.tex
command! TeXTemplateUpLaTeX 0r ~/.vim/template/uplatex.tex
" load template
augroup MyVimTeXAutoCmd
  autocmd BufNewFile *.tex 0r ~/.vim/template/uplatex.tex
augroup END
" 句読点の設定
augroup MyVimTeXAutoCmd
  autocmd FileType tex imap <buffer> 、 ，
  autocmd FileType tex imap <buffer> 。 ．
augroup END
