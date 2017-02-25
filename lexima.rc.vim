" lexima {{{2
" tex
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'tex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex'})
"" \[\], \{\}
call lexima#add_rule({'char': '{', 'at': '\\\%#', 'input_after': '\}', 'filetype': 'tex'})
call lexima#add_rule({'char': '[', 'at': '\\\%#', 'input_after': '\]', 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',
      \ 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\{\%#\\}', 'input': '<BS><BS><Del><Del>',
      \ 'filetype': 'tex'})
call lexima#add_rule({'char': '<Space>', 'at': '\\{\%#\\}', 'input_after': '<Space>',
      \ 'filetype': 'tex'})
call lexima#add_rule({'char': '<Space>', 'at': '\\\[\%#\\\]', 'input_after': '<Space>',
      \ 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\\[ \%# \\\]', 'input': '<BS>', 'delete': 1,
      \ 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\{ \%# \\}', 'input': '<BS>', 'delete': 1,
      \ 'filetype': 'tex'})
"" \left(など
call lexima#add_rule({'char': '(', 'at': '\\l\%#', 'input': 'eft( ',
      \ 'input_after': ' \right)', 'filetype': 'tex'})
call lexima#add_rule({'char': '{', 'at': '\\l\%#', 'input': 'eft\{ ',
      \ 'input_after': ' \right\}', 'filetype': 'tex'})
call lexima#add_rule({'char': '[', 'at': '\\l\%#', 'input': 'eft[ ',
      \ 'input_after': ' \right]', 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\left( \%# \\right)',
      \'input': '<Esc>7h15xi', 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\left\[ \%# \\right\]',
      \'input': '<Esc>7h15xi', 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\\left\\{ \%# \\right\\}',
      \'input': '<Esc>7h17xi', 'filetype': 'tex'})
"" \[\]でEnter
call lexima#add_rule({'char': '<CR>', 'at': '\\\[\%#\\\]',
      \ 'input_after': '<CR>', 'filetype': 'tex'})

" lilypond
call lexima#add_rule({'char': '<', 'input_after': '>',
      \ 'filetype': 'lilypond'})

" html
call lexima#add_rule({'char': '<', 'input_after': '>',
      \ 'filetype': 'html'})
call lexima#add_rule({'char': '<BS>',
      \ 'at': '<\%#>', 'delete': 1,
      \ 'filetype': 'html'})

" eruby
call lexima#add_rule({'char': '<', 'input_after': '>',
      \ 'filetype': 'eruby'})
call lexima#add_rule({'char': '<BS>',
      \ 'at': '<\%#>', 'delete': 1,
      \ 'filetype': 'eruby'})
call lexima#add_rule({'char': '%', 'at': '<\%#>',
      \ 'input': '% ', 'input_after': ' %',
      \ 'filetype': 'eruby'})
call lexima#add_rule({'char': '<BS>', 'at': '<% \%# %>',
      \ 'input': '<BS><BS><BS>', 'delete': 3,
      \ 'filetype': 'eruby'})
